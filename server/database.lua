-- Tables, validation and the in-memory copy of every consumable and effect.
-- Everything is loaded once on start; admin changes update memory and write the one row they touch.

Data = {consumables = {}, effects = {}} -- [id] = row
ByItem = {} -- [item name] = consumable row
Items = {} -- [item name] = {label, usable}, from the items table
Ready = false
DataRevision = 0 -- goes up whenever consumables or effects change (the admin panel caches them)

local Specs = {
    consumables = {
        table = "ez_consumables_items",
        columns = {
            "item", "kind", "hunger", "thirst", "stress", "metabolism",
            "stamina", "inner_health", "outer_health", "inner_health_gold", "outer_health_gold", "inner_stamina_gold", "outer_stamina_gold",
            "alcohol", "cooldown", "animation", "interaction", "prop", "effect", "effect_time", "clear_effects", "sober", "gives",
            "uses", "use_time", "requires",
            "enabled", "updated_by",
        },
        json = {prop = true, gives = true, requires = true},
        list = {gives = true, requires = true}, -- JSON columns that hold a list (never NULL)
        bool = {clear_effects = true, sober = true, enabled = true},
    },
    effects = {
        table = "ez_consumables_effects",
        columns = {"label", "duration", "postfx", "start_fx", "end_fx", "timecycle", "strength", "drunk", "shake", "shake_amount", "shake_time", "blur", "enabled"},
        json = {postfx = true},
        list = {postfx = true},
        bool = {blur = true, enabled = true},
    },
}

local Schema = {
    [[CREATE TABLE IF NOT EXISTS `ez_consumables_effects` (
        `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        `label` VARCHAR(64) NOT NULL,
        `duration` INT NULL DEFAULT NULL,
        `postfx` LONGTEXT NOT NULL,
        `start_fx` VARCHAR(64) NULL DEFAULT NULL,
        `end_fx` VARCHAR(64) NULL DEFAULT NULL,
        `timecycle` VARCHAR(64) NULL DEFAULT NULL,
        `strength` FLOAT NOT NULL DEFAULT 1,
        `drunk` FLOAT NOT NULL DEFAULT 0,
        `shake` VARCHAR(64) NULL DEFAULT NULL,
        `shake_amount` FLOAT NOT NULL DEFAULT 0,
        `shake_time` INT NOT NULL DEFAULT 0,
        `blur` TINYINT(1) NOT NULL DEFAULT 0,
        `enabled` TINYINT(1) NOT NULL DEFAULT 1,
        PRIMARY KEY (`id`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4]],
    [[CREATE TABLE IF NOT EXISTS `ez_consumables_items` (
        `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        `item` VARCHAR(50) NOT NULL,
        `kind` VARCHAR(16) NOT NULL DEFAULT 'food',
        `hunger` FLOAT NOT NULL DEFAULT 0,
        `thirst` FLOAT NOT NULL DEFAULT 0,
        `stress` FLOAT NOT NULL DEFAULT 0,
        `metabolism` INT NOT NULL DEFAULT 0,
        `stamina` FLOAT NOT NULL DEFAULT 0,
        `inner_health` FLOAT NOT NULL DEFAULT 0,
        `outer_health` FLOAT NOT NULL DEFAULT 0,
        `inner_health_gold` FLOAT NOT NULL DEFAULT 0,
        `outer_health_gold` FLOAT NOT NULL DEFAULT 0,
        `inner_stamina_gold` FLOAT NOT NULL DEFAULT 0,
        `outer_stamina_gold` FLOAT NOT NULL DEFAULT 0,
        `alcohol` INT NOT NULL DEFAULT 0,
        `cooldown` INT NOT NULL DEFAULT 0,
        `animation` VARCHAR(32) NULL DEFAULT NULL,
        `interaction` VARCHAR(100) NULL DEFAULT NULL,
        `prop` LONGTEXT NULL DEFAULT NULL,
        `effect` INT UNSIGNED NULL DEFAULT NULL,
        `effect_time` INT NULL DEFAULT NULL,
        `clear_effects` TINYINT(1) NOT NULL DEFAULT 0,
        `sober` TINYINT(1) NOT NULL DEFAULT 0,
        `gives` LONGTEXT NOT NULL,
        `uses` INT NOT NULL DEFAULT 1,
        `use_time` INT NULL DEFAULT NULL,
        `requires` LONGTEXT NULL DEFAULT NULL,
        `enabled` TINYINT(1) NOT NULL DEFAULT 1,
        `updated_by` VARCHAR(100) NULL DEFAULT NULL,
        `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
        PRIMARY KEY (`id`),
        UNIQUE KEY `item` (`item`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4]],
    -- Every admin change: who, when, what changed, and the version it replaced (so it can be put back)
    [[CREATE TABLE IF NOT EXISTS `ez_consumables_history` (
        `id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
        `kind` VARCHAR(16) NOT NULL,
        `row_id` INT UNSIGNED NOT NULL,
        `name` VARCHAR(64) NOT NULL,
        `action` VARCHAR(16) NOT NULL,
        `actor_id` VARCHAR(100) NULL DEFAULT NULL,
        `actor` VARCHAR(100) NULL DEFAULT NULL,
        `at` INT NOT NULL,
        `changes` LONGTEXT NULL DEFAULT NULL,
        `before` LONGTEXT NULL DEFAULT NULL,
        PRIMARY KEY (`id`),
        KEY `row` (`kind`, `row_id`),
        KEY `at` (`at`)
    ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4]],
}

local function hasColumn(tableName, column)
    local rows = MySQL.query.await(("SHOW COLUMNS FROM `%s` LIKE '%s'"):format(tableName, column)) or {}
    return #rows > 0
end

function EnsureTables()
    for _, query in ipairs(Schema) do MySQL.query.await(query) end
    -- The first version rolled metabolism between a min and a max: keep the middle of the two
    -- Smoking (puffs) came later
    if not hasColumn("ez_consumables_items", "uses") then
        MySQL.query.await("ALTER TABLE `ez_consumables_items` ADD COLUMN `uses` INT NOT NULL DEFAULT 1, ADD COLUMN `use_time` INT NULL DEFAULT NULL, ADD COLUMN `requires` LONGTEXT NULL DEFAULT NULL")
    end
    if hasColumn("ez_consumables_items", "metabolism_min") then
        MySQL.query.await("ALTER TABLE `ez_consumables_items` ADD COLUMN `metabolism` INT NOT NULL DEFAULT 0 AFTER `stress`")
        MySQL.query.await("UPDATE `ez_consumables_items` SET `metabolism` = ROUND((`metabolism_min` + `metabolism_max`) / 2)")
        MySQL.query.await("ALTER TABLE `ez_consumables_items` DROP COLUMN `metabolism_min`, DROP COLUMN `metabolism_max`")
        print("^2[ez_consumables]^7 Metabolism is now one value (the middle of the old range)")
    end
end

function TableName(kind)
    return Specs[kind].table
end

---------------------------------------------------------------- Validation
-- Used for admin input and for rows read from the database, so a bad row can't break the script

local function trim(value)
    return type(value) == "string" and value:gsub("^%s+", ""):gsub("%s+$", "") or nil
end

local function text(value, max)
    value = trim(value)
    if not value or value == "" then return nil end
    return value:sub(1, max)
end

local function bool(value, default)
    if value == nil then return default end
    return value == true or value == 1 or value == "1" or value == "true"
end

local function whole(value, min, max, default)
    value = Number(value, min, max)
    if not value then return default end
    return math.floor(value + 0.5)
end

--- x, y, z clamped to +-limit, to 3 decimals (prop offsets are fine-tuned)
local function cleanVector(value, limit)
    if type(value) ~= "table" then return nil end
    local function axis(n)
        n = Number(n, -limit, limit)
        return n and math.floor(n * 1000 + 0.5) / 1000
    end
    local x, y, z = axis(value.x), axis(value.y), axis(value.z)
    if not x or not y or not z then return nil end
    return {x = x, y = y, z = z}
end

--- The consumable's own prop fields. nil when it sets none (the animation's prop is used)
local function cleanProp(value)
    if type(value) ~= "table" then return nil end
    local prop = {
        model = text(value.model, 64),
        bone = text(value.bone, 64),
        offset = cleanVector(value.offset, 5),
        rotation = cleanVector(value.rotation, 720),
    }
    if not next(prop) then return nil end
    return prop
end

local function cleanStacks(list, max, maxCount)
    local stacks, index = {}, {}
    for _, raw in ipairs(type(list) == "table" and list or {}) do
        if type(raw) == "table" then
            local name = text(raw.name, 50)
            local count = WholeNumber(raw.count, 1, maxCount)
            if name and count then
                if index[name] then
                    index[name].count = math.min(maxCount, index[name].count + count)
                elseif #stacks < max then
                    index[name] = {name = name, count = count}
                    stacks[#stacks + 1] = index[name]
                end
            end
        end
    end
    return stacks
end

local function cleanNames(list, max)
    local names, seen = {}, {}
    for _, value in ipairs(type(list) == "table" and list or {}) do
        value = text(value, 64)
        if value and not seen[value:lower()] and #names < max then
            seen[value:lower()] = true
            names[#names + 1] = value
        end
    end
    return names
end

--- A number held to Limits[kind][key], to 2 decimals. The default (0) when it isn't a number.
--- The step is only how far a slider moves; a typed value is kept as it is
local function limited(kind, input, key, default)
    local limit = Limits[kind][key]
    local value = Number(input[key], limit[1], limit[2])
    if not value then return default or 0 end
    return math.floor(value * 100 + 0.5) / 100
end

--- A consumable from any input, or nil and why not
--- @param input table
--- @param loading boolean? Reading the database: effects that aren't loaded yet are kept
function CleanConsumable(input, loading)
    if type(input) ~= "table" then return nil, "invalid" end
    local c = {
        id = WholeNumber(input.id, 1),
        item = text(input.item, 50),
        kind = FindKind(input.kind) and input.kind or Config.DefaultKind,
        cooldown = whole(input.cooldown, 0, 86400, 0),
        animation = Config.Animations[input.animation] and input.animation or nil,
        prop = cleanProp(input.prop),
        effect = WholeNumber(input.effect, 1),
        effect_time = WholeNumber(input.effect_time, 1, 3600),
        clear_effects = bool(input.clear_effects, false),
        sober = bool(input.sober, false),
        gives = cleanStacks(input.gives, 10, 1000),
        requires = cleanStacks(input.requires, 5, 100),
        uses = math.floor(Number(input.uses, 1, 50) or 1),
        use_time = Number(input.use_time, 500, 60000) and math.floor(Number(input.use_time, 500, 60000)) or nil,
        enabled = bool(input.enabled, true),
        updated_by = text(input.updated_by, 100),
    }
    for key in pairs(Limits.consumables) do c[key] = limited("consumables", input, key) end
    if c.animation == Config.DefaultAnimation then c.animation = nil end
    -- Puffs only mean something for smoking animations
    local smoking = Config.Animations[c.animation or Config.DefaultAnimation]
    if not (smoking and smoking.smoke) then c.uses, c.use_time = 1, nil end
    -- A custom interaction only means something for interaction animations
    local animation = Config.Animations[c.animation or Config.DefaultAnimation]
    if animation and animation.interaction then c.interaction = text(input.interaction, 100) end
    if c.effect and not loading and not Data.effects[c.effect] then c.effect = nil end
    if not c.effect then c.effect_time = nil end

    if not c.item then return nil, "item" end
    return c
end

function CleanEffect(input)
    if type(input) ~= "table" then return nil, "invalid" end
    local e = {
        id = WholeNumber(input.id, 1),
        label = text(input.label, 64),
        duration = WholeNumber(input.duration, 1, 3600),
        postfx = cleanNames(input.postfx, 10),
        start_fx = text(input.start_fx, 64),
        end_fx = text(input.end_fx, 64),
        timecycle = text(input.timecycle, 64),
        strength = limited("effects", input, "strength", 1),
        drunk = limited("effects", input, "drunk"),
        shake = text(input.shake, 64),
        shake_amount = limited("effects", input, "shake_amount"),
        shake_time = whole(input.shake_time, 0, 3600, 0),
        blur = bool(input.blur, false),
        enabled = bool(input.enabled, true),
    }
    if not e.label then return nil, "label" end
    return e
end

local Cleaners = {consumables = CleanConsumable, effects = CleanEffect}

---------------------------------------------------------------- Reading and writing rows

--- Named parameters for a row ({column = value}). A missing key is written as NULL by oxmysql, so NULL columns
--- can't shift the others out of place the way gaps in a positional list can
local function params(kind, row)
    local spec, values = Specs[kind], {}
    for _, column in ipairs(spec.columns) do
        local value = row[column]
        if spec.json[column] then
            if value ~= nil then
                value = json.encode(value)
                if value == "{}" and spec.list[column] then value = "[]" end -- an empty table may come out as {}
            elseif spec.list[column] then
                value = "[]"
            end
        elseif spec.bool[column] then
            value = value and 1 or 0
        end
        values[column] = value
    end
    return values
end

local function decode(value, fallback)
    if type(value) ~= "string" or value == "" then return fallback end
    local ok, result = pcall(json.decode, value)
    if ok and result ~= nil then return result end
    return fallback
end

local function fromRow(kind, row)
    local spec, input = Specs[kind], {id = row.id}
    for _, column in ipairs(spec.columns) do
        local value = row[column]
        if spec.json[column] then
            value = decode(value, spec.list[column] and {} or nil)
        elseif spec.bool[column] then
            value = value == true or tonumber(value) == 1
        end
        input[column] = value
    end
    return Cleaners[kind](input, true)
end

--- Inserts a new row and gives it its id
--- @return number | nil
function DbInsert(kind, row, id)
    local spec = Specs[kind]
    local columns, marks = {}, {}
    for i, column in ipairs(spec.columns) do
        columns[i] = "`" .. column .. "`"
        marks[i] = "@" .. column
    end
    local values = params(kind, row)
    if id then
        table.insert(columns, 1, "`id`")
        table.insert(marks, 1, "@id")
        values.id = id
    end
    local query = ("INSERT INTO `%s` (%s) VALUES (%s)"):format(spec.table, table.concat(columns, ", "), table.concat(marks, ", "))
    local newId = MySQL.insert.await(query, values)
    if newId then row.id = id or newId end
    return newId and row.id or nil
end

function DbUpdateQuery(kind, row)
    local spec = Specs[kind]
    local sets = {}
    for i, column in ipairs(spec.columns) do sets[i] = ("`%s` = @%s"):format(column, column) end
    local values = params(kind, row)
    values.id = row.id
    return ("UPDATE `%s` SET %s WHERE `id` = @id"):format(spec.table, table.concat(sets, ", ")), values
end

function DbUpdate(kind, row)
    local query, values = DbUpdateQuery(kind, row)
    return MySQL.update.await(query, values)
end

--- Writes several rows in one transaction
function DbUpdateMany(kind, rows)
    if #rows == 0 then return true end
    local queries = {}
    for i, row in ipairs(rows) do
        local query, values = DbUpdateQuery(kind, row)
        queries[i] = {query = query, values = values}
    end
    return MySQL.transaction.await(queries)
end

function DbDelete(kind, id)
    return MySQL.update.await(("DELETE FROM `%s` WHERE `id` = ?"):format(Specs[kind].table), {id})
end

---------------------------------------------------------------- Loading

function LoadItemList()
    Items = LoadItems()
end

function RebuildIndex()
    ByItem = {}
    for _, c in pairs(Data.consumables) do ByItem[c.item] = c end
end

function LoadAll()
    local loaded = {consumables = {}, effects = {}}
    for _, kind in ipairs({"effects", "consumables"}) do
        local rows = MySQL.query.await(("SELECT * FROM `%s`"):format(Specs[kind].table)) or {}
        for _, row in ipairs(rows) do
            local clean, why = fromRow(kind, row)
            if clean then
                loaded[kind][clean.id] = clean
            else
                print(("^3[ez_consumables] %s row %s is broken (%s) and was skipped^7"):format(kind, tostring(row.id), tostring(why)))
            end
        end
    end
    -- Effects that were deleted outside the panel
    for _, c in pairs(loaded.consumables) do
        if c.effect and not loaded.effects[c.effect] then c.effect, c.effect_time = nil, nil end
    end
    Data = loaded
    RebuildIndex()
    DataRevision = DataRevision + 1
    local counts = {}
    for kind, list in pairs(Data) do
        local n = 0
        for _ in pairs(list) do n = n + 1 end
        counts[kind] = n
    end
    return counts
end

function LabelOf(item)
    return Items[item] and Items[item].label or item
end

---------------------------------------------------------------- History

--- What changed between two versions of a row: {[column] = {old, new}}, nil when nothing did.
--- before = nil for a new row. "" stands in for nothing (a nil would break the pair)
function Differences(kind, before, after)
    local changes, any = {}, false
    for _, column in ipairs(Specs[kind].columns) do
        if column ~= "updated_by" then
            local a, b = before and before[column], after[column]
            local same = a == b
            if not same and type(a) == "table" and type(b) == "table" then same = json.encode(a) == json.encode(b) end
            -- An empty list and nothing are the same thing
            if not same and Specs[kind].list[column] and (a == nil or (type(a) == "table" and not next(a))) and (b == nil or (type(b) == "table" and not next(b))) then same = true end
            if not same then
                changes[column] = {a == nil and "" or a, b == nil and "" or b}
                any = true
            end
        end
    end
    return any and changes or nil
end

--- The name a history entry is listed under
function HistoryName(kind, row)
    return (kind == "consumables" and row.item or row.label or "?"):sub(1, 64)
end

--- Adds a history row
--- @param entry table {kind, row, action, actor = {id, name}, changes?, before?}
function DbHistory(entry)
    MySQL.insert.await(
        "INSERT INTO `ez_consumables_history` (`kind`, `row_id`, `name`, `action`, `actor_id`, `actor`, `at`, `changes`, `before`) VALUES (@kind, @row_id, @name, @action, @actor_id, @actor, @at, @changes, @before)",
        {
            kind = entry.kind, row_id = entry.row.id, name = HistoryName(entry.kind, entry.row), action = entry.action,
            actor_id = entry.actor and entry.actor.id, actor = entry.actor and entry.actor.name, at = os.time(),
            changes = entry.changes and json.encode(entry.changes) or nil, before = entry.before and json.encode(entry.before) or nil,
        }
    )
end

--- History rows, newest first. filter = {kind?, row_id?, search?, before? (history id)}
function DbHistoryPage(filter, limit)
    local where, values = {}, {}
    if Specs[filter.kind] then
        where[#where + 1] = "`kind` = ?"
        values[#values + 1] = filter.kind
        if filter.row_id then
            where[#where + 1] = "`row_id` = ?"
            values[#values + 1] = filter.row_id
        end
    end
    if filter.search and filter.search ~= "" then
        local like = "%" .. filter.search:gsub("[%%_\\]", "\\%0") .. "%"
        where[#where + 1] = "(`name` LIKE ? OR `actor` LIKE ?)"
        values[#values + 1] = like
        values[#values + 1] = like
    end
    if filter.before then
        where[#where + 1] = "`id` < ?"
        values[#values + 1] = filter.before
    end
    values[#values + 1] = limit + 1
    local query = ("SELECT `id`, `kind`, `row_id`, `name`, `action`, `actor`, `at`, `changes`, (`before` IS NOT NULL) AS `has_before` FROM `ez_consumables_history`%s ORDER BY `id` DESC LIMIT ?")
        :format(#where > 0 and (" WHERE " .. table.concat(where, " AND ")) or "")
    local rows = MySQL.query.await(query, values) or {}
    local more = #rows > limit
    if more then rows[#rows] = nil end
    for i, row in ipairs(rows) do
        rows[i] = {
            id = tonumber(row.id), kind = row.kind, row_id = tonumber(row.row_id), name = row.name, action = row.action,
            actor = row.actor, at = tonumber(row.at), changes = decode(row.changes, nil),
            has_before = row.has_before == true or tonumber(row.has_before) == 1,
        }
    end
    return rows, more
end

--- One history row with the version it replaced (cleaned like any other row), or nil
function DbReadHistory(id)
    local row = (MySQL.query.await("SELECT * FROM `ez_consumables_history` WHERE `id` = ?", {id}) or {})[1]
    if not row or not Specs[row.kind] then return nil end
    local before = decode(row.before, nil)
    if type(before) == "table" then before = Cleaners[row.kind](before, true) end
    return {id = tonumber(row.id), kind = row.kind, row_id = tonumber(row.row_id), name = row.name, action = row.action, before = before}
end

--- Drops history older than Config.HistoryKeepDays (0 = keep for ever)
function PruneHistory()
    if (Config.HistoryKeepDays or 0) <= 0 then return end
    MySQL.update.await("DELETE FROM `ez_consumables_history` WHERE `at` < ?", {os.time() - Config.HistoryKeepDays * 86400})
end

--- Item names that aren't in the items table (none when the table couldn't be read)
function UnknownItems(names)
    local unknown = {}
    if not next(Items) then return unknown end
    for _, name in ipairs(names) do
        if not Items[name] then unknown[#unknown + 1] = name end
    end
    return unknown
end
