--[[
    Brings the old config (Config.ItemsToUse, Config.ItemToSplit and Config.Effects) into the database.
    Run once from the server console:  ez_consumables_migrate
    It stops if the tables already have rows. ez_consumables_migrate reset wipes both tables first.

    The old file is only read (Config.LegacyConfig). How the old fields map:
      Status.Metabolism = math.random(a, b)  -> the middle of a and b (the old one rolled once on start)
      Values past the new limits (Limits in shared/functions.lua) are held to them: metabolism +-2000 becomes +-1000
      Animation "food" / none                -> the default quick bite interaction, as before
      Func = Config.Effects.high(60)         -> the "High" effect for 60s. The old function also set the health core to
                                                100 and made it gold for 1000, so those go on the consumable
      ItemReturn                             -> gives back 1
      Config.ItemToSplit                     -> "pack" consumables with no animation that give their contents

    ez_consumables_migrate tobacco  brings in ez_tobacco's Config.Tobacco (Config.LegacyTobacco) next to what is there.
    Items that are already consumables are skipped, so it can run again. How the old fields map:
      type Cigar / Cigarette / Pipe / Chewingtobacco -> the cigar / cigarette / pipe / chew animation
      numOfUse, timePerUse, prop (cigars)          -> puffs, time per puff, the cigar's model
      metabolism (each puff)                       -> status, given with every puff
      requiredItems                                -> needs (kept, not used up)
      onComplete                                   -> run once with the natives recorded: the gold it gave and the
                                                      effect it started (High / Vintage Eye) become the reward
]]

-- The two old effect functions (Config.Effects.high / vintageEye in both old configs), as effects
local LegacyEffects = {
    high = {
        label = "High", duration = 60, start_fx = "PlayerWakeUpDrunk", end_fx = "PlayerWakeUpDrunk", postfx = {"playerdrugshalluc01"},
        timecycle = "LensDistDrunk", drunk = 1.0, shake = "SMALL_EXPLOSION_SHAKE", shake_amount = 0.35, shake_time = 6, blur = true,
    },
    vintageEye = {
        label = "Vintage Eye", duration = 60, postfx = {"EagleEye", "PhotoMode_FilterVintage02"}, timecycle = "EagleEyeDark", strength = 0.5,
        shake = "SMALL_EXPLOSION_SHAKE", shake_amount = 0.35, shake_time = 6, blur = true,
    },
}

--- Inserts one of LegacyEffects, or finds the one already there with its name
local function legacyEffect(key, report)
    local def = LegacyEffects[key]
    for _, effect in pairs(Data.effects) do
        if effect.label == def.label then return effect end
    end
    local effect = CleanEffect(def)
    DbInsert("effects", effect)
    Data.effects[effect.id] = effect
    report.effects = report.effects + 1
    return effect
end

-- math.random in the old file is recorded, not rolled, so the middle of each range can be taken
local function legacyConfig()
    local path = Config.LegacyConfig
    local source = LoadResourceFile(GetCurrentResourceName(), path)
    if not source then return nil, ("Could not read %s"):format(path) end
    -- The old file starts with "Config = Config or {}": it must not see (and write over) the live Config
    local env = setmetatable({}, {__index = function(_, key) if key ~= "Config" then return _G[key] end end})
    env.math = setmetatable({random = function(a, b) return {random = {a, b}} end}, {__index = math})
    local chunk, err = load(source, "@" .. path, "t", env)
    if not chunk then return nil, ("%s does not load: %s"):format(path, tostring(err)) end
    local ok, runErr = pcall(chunk)
    if not ok then return nil, ("%s errored: %s"):format(path, tostring(runErr)) end
    if type(env.Config) ~= "table" or type(env.Config.ItemsToUse) ~= "table" then return nil, path .. " has no Config.ItemsToUse" end
    return env.Config
end

--- A number, or the middle of a math.random(a, b) range
local function middle(value)
    if type(value) == "table" and value.random then
        local a, b = tonumber(value.random[1]) or 0, tonumber(value.random[2])
        if not b then a, b = 1, a end -- math.random(m) is 1..m
        return math.floor((a + b) / 2 + 0.5)
    end
    return tonumber(value) or 0
end

--- A few old rotations were written {xr, yr, zr}, which the old code never read (the prop wasn't turned at all).
--- They are taken as meant
local function vector(value)
    if type(value) ~= "table" then return nil end
    return {x = value.x or value.xr, y = value.y or value.yr, z = value.z or value.zr}
end

local ANIMATIONS <const> = {drink = true, eat = true, bandage = true, syringe = true, coffee = true, stew = true}

local function kindOf(name, old)
    local lower = name:lower()
    if lower:find("cigar") or lower:find("tobacco") or lower:find("pipe") then return "tobacco" end
    if old.Func then return "drug" end
    if old.Animation == "bandage" or old.Animation == "syringe" or lower:find("^medical_") or lower:find("bandage") then return "medicine" end
    if old.Animation == "drink" or old.Animation == "coffee" then return "drink" end
    if old.Animation == "eat" or old.Animation == "stew" or old.Animation == "food" then return "food" end
    local status = type(old.Status) == "table" and old.Status or {}
    if (tonumber(status.Thirst) or 0) > (tonumber(status.Hunger) or 0) then return "drink" end
    return "food"
end

--- The old Prop as the new prop. Each old animation only read some of it, so only that part is kept
local function propOf(animation, old)
    if type(old) ~= "table" or not ANIMATIONS[animation] then return nil end
    if animation == "coffee" or animation == "stew" then return old.name and {model = old.name} or nil end
    return {
        model = old.name,
        bone = (animation ~= "bandage" and animation ~= "syringe") and old.bone or nil, -- these two always used the left hand
        offset = vector(old.coords),
        rotation = vector(old.rot),
    }
end

local function countRows(kind)
    return tonumber(MySQL.scalar.await(("SELECT COUNT(*) FROM `%s`"):format(TableName(kind)))) or 0
end

function MigrateLegacy(reset)
    EnsureTables()
    local old, why = legacyConfig()
    if not old then return nil, why end

    local existing = countRows("consumables") + countRows("effects")
    if existing > 0 and not reset then
        return nil, ("The consumables tables already have %s rows. Run ^5ez_consumables_migrate reset^7 to wipe them and import again"):format(existing)
    end
    if reset then
        for _, kind in ipairs({"consumables", "effects"}) do
            MySQL.query.await(("DELETE FROM `%s`"):format(TableName(kind)))
            MySQL.query.await(("ALTER TABLE `%s` AUTO_INCREMENT = 1"):format(TableName(kind)))
        end
    end
    LoadItemList()
    Data = {consumables = {}, effects = {}}
    local report = {consumables = 0, packs = 0, effects = 0, skipped = {}, notes = {}, unknown = {}, wiped = reset and existing or 0}

    local high = legacyEffect("high", report)
    legacyEffect("vintageEye", report)

    local seenUnknown = {}
    local function checkName(name)
        if next(Items) and not Items[name] and not seenUnknown[name] then
            seenUnknown[name] = true
            report.unknown[#report.unknown + 1] = name
        end
    end

    local names = {}
    for name in pairs(old.ItemsToUse) do names[#names + 1] = name end
    table.sort(names)
    for _, name in ipairs(names) do
        local v = old.ItemsToUse[name]
        local status = type(v.Status) == "table" and v.Status or {}
        local animation = v.Animation
        if animation ~= nil and not ANIMATIONS[animation] then
            if animation ~= "food" then report.notes[#report.notes + 1] = ("%s had animation %q, which never existed: it gets the quick bite, as before"):format(name, tostring(animation)) end
            animation = nil
        end
        local interaction
        if not animation and type(v.ItemInteraction) == "string" then
            animation, interaction = "interaction", v.ItemInteraction
        end
        local input = {
            item = name, kind = kindOf(name, v),
            hunger = middle(status.Hunger), thirst = middle(status.Thirst), stress = middle(status.Stress),
            metabolism = middle(status.Metabolism),
            stamina = v.Stamina, inner_health = v.InnerHealth, outer_health = v.OuterHealth,
            inner_health_gold = v.InnerHealthGold, outer_health_gold = v.OuterHealthGold,
            inner_stamina_gold = v.InnerStaminaGold, outer_stamina_gold = v.OuterStaminaGold,
            alcohol = v.AlcoholLevel, cooldown = v.CoolDown,
            animation = animation, interaction = interaction, prop = propOf(animation, v.Prop),
            gives = type(v.ItemReturn) == "string" and {{name = v.ItemReturn, count = 1}} or {},
            enabled = true, updated_by = "migration",
        }
        if type(v.Func) == "function" then
            input.effect = high.id
            input.inner_health = 100
            input.inner_health_gold = math.max(tonumber(v.InnerHealthGold) or 0, 1000)
        end
        local row, why2 = CleanConsumable(input, true)
        if row and DbInsert("consumables", row) then
            Data.consumables[row.id] = row
            report.consumables = report.consumables + 1
            checkName(row.item)
            for _, give in ipairs(row.gives) do checkName(give.name) end
        else
            report.skipped[#report.skipped + 1] = ("%s (%s)"):format(name, tostring(why2 or "database"))
        end
    end

    names = {}
    for name in pairs(old.ItemToSplit or {}) do names[#names + 1] = name end
    table.sort(names)
    for _, name in ipairs(names) do
        if old.ItemsToUse[name] then
            report.skipped[#report.skipped + 1] = ("pack %s (it is already a consumable)"):format(name)
        else
            local gives = {}
            for item, entry in pairs(old.ItemToSplit[name]) do
                gives[#gives + 1] = {name = item, count = type(entry) == "table" and entry.count or 1}
            end
            table.sort(gives, function(a, b) return a.name < b.name end)
            local row, why2 = CleanConsumable({item = name, kind = "pack", animation = "none", gives = gives, enabled = true, updated_by = "migration"}, true)
            if row and DbInsert("consumables", row) then
                Data.consumables[row.id] = row
                report.packs = report.packs + 1
                checkName(row.item)
                for _, give in ipairs(row.gives) do checkName(give.name) end
            else
                report.skipped[#report.skipped + 1] = ("pack %s (%s)"):format(name, tostring(why2 or "database"))
            end
        end
    end
    return report
end

---------------------------------------------------------------- ez_tobacco

local TOBACCO_ANIMATIONS <const> = {Cigar = "cigar", Cigarette = "cigarette", Pipe = "pipe", Chewingtobacco = "chew"}
local CORE_GOLD <const> = { -- [native][core] = column
    [0x4AF5A4C7B9157D14] = {[0] = "inner_health_gold", [1] = "inner_stamina_gold"}, -- EnableAttributeCoreOverpower
    [0xF6A7C08DF2E28B28] = {[0] = "outer_health_gold", [1] = "outer_stamina_gold"}, -- EnableAttributeOverpower
}

--- ez_tobacco's config, with what each onComplete does recorded instead of done
local function tobaccoConfig()
    local path = Config.LegacyTobacco
    local source = LoadResourceFile(GetCurrentResourceName(), path)
    if not source then return nil, ("Could not read %s"):format(path) end
    local record -- the onComplete being run writes here
    local env = setmetatable({}, {__index = function(_, key) if key ~= "Config" then return _G[key] end end})
    env.PlayerPedId = function() return 0 end
    env.Wait = function() end
    env.Citizen = {
        Wait = function() end,
        InvokeNative = function(hash, _, core, value)
            local column = CORE_GOLD[hash] and CORE_GOLD[hash][core]
            if record and column then record[column] = math.max(record[column] or 0, tonumber(value) or 0) end
        end,
    }
    local chunk, err = load(source, "@" .. path, "t", env)
    if not chunk then return nil, ("%s does not load: %s"):format(path, tostring(err)) end
    local ok, runErr = pcall(chunk)
    if not ok then return nil, ("%s errored: %s"):format(path, tostring(runErr)) end
    if type(env.Config) ~= "table" or type(env.Config.Tobacco) ~= "table" then return nil, path .. " has no Config.Tobacco" end
    env.Config.Effects = setmetatable({}, {__index = function(_, key)
        return function(seconds) if record then record.effect = {key = key, seconds = tonumber(seconds)} end end
    end})
    --- What onComplete gives for smoking it all: {inner_health_gold = n, ..., effect = {key, seconds}}
    local function reward(item)
        record = {}
        local ok2, why = pcall(item.onComplete, item.numOfUse)
        local result = record
        record = nil
        return result, not ok2 and tostring(why) or nil
    end
    return env.Config, reward
end

function MigrateTobacco()
    EnsureTables()
    local old, reward = tobaccoConfig()
    if not old then return nil, reward end
    LoadItemList()
    local report = {consumables = 0, effects = 0, skipped = {}, notes = {}, unknown = {}}

    local names = {}
    for name in pairs(old.Tobacco) do names[#names + 1] = name end
    table.sort(names)
    for _, name in ipairs(names) do
        local v = old.Tobacco[name]
        local animation = TOBACCO_ANIMATIONS[v.type]
        if ByItem[name] then
            report.skipped[#report.skipped + 1] = ("%s (already a consumable)"):format(name)
        elseif not animation then
            report.skipped[#report.skipped + 1] = ("%s (type %s is not a smoking animation)"):format(name, tostring(v.type))
        else
            local status = {}
            for key, value in pairs(type(v.metabolism) == "table" and v.metabolism or {}) do status[tostring(key):lower()] = value end
            local requires = {}
            for _, need in pairs(type(v.requiredItems) == "table" and v.requiredItems or {}) do
                requires[#requires + 1] = {name = need.item, count = need.count}
            end
            local got, failed = reward(v)
            if failed then report.notes[#report.notes + 1] = ("%s: its onComplete errored (%s), imported without a reward"):format(name, failed) end
            local effect
            if got.effect then
                if LegacyEffects[got.effect.key] then
                    effect = legacyEffect(got.effect.key, report)
                else
                    report.notes[#report.notes + 1] = ("%s started the unknown effect %s, left out"):format(name, got.effect.key)
                end
            end
            local input = {
                item = name, kind = effect and effect.label == "High" and "drug" or "tobacco",
                hunger = status.hunger, thirst = status.thirst, stress = status.stress, metabolism = status.metabolism,
                animation = animation, prop = animation == "cigar" and type(v.prop) == "string" and {model = v.prop:lower()} or nil,
                uses = v.numOfUse, use_time = v.timePerUse, requires = requires,
                inner_health_gold = got.inner_health_gold, outer_health_gold = got.outer_health_gold,
                inner_stamina_gold = got.inner_stamina_gold, outer_stamina_gold = got.outer_stamina_gold,
                effect = effect and effect.id,
                effect_time = effect and got.effect.seconds ~= effect.duration and got.effect.seconds or nil,
                enabled = true, updated_by = "migration (ez_tobacco)",
            }
            local row, why = CleanConsumable(input, true)
            if row and DbInsert("consumables", row) then
                Data.consumables[row.id] = row
                ByItem[row.item] = row
                report.consumables = report.consumables + 1
                for _, item in ipairs(UnknownItems({row.item})) do report.unknown[#report.unknown + 1] = item end
                for _, need in ipairs(row.requires) do
                    for _, item in ipairs(UnknownItems({need.name})) do report.unknown[#report.unknown + 1] = item end
                end
            else
                report.skipped[#report.skipped + 1] = ("%s (%s)"):format(name, tostring(why or "database"))
            end
        end
    end
    return report
end

RegisterCommand("ez_consumables_migrate", function(src, args)
    if src ~= 0 then return end -- console only
    if args[1] == "tobacco" then
        Ready = false
        local report, why = MigrateTobacco()
        LoadAll()
        SyncUsableItems()
        Ready = true
        if not report then return print("^3[ez_consumables]^7 " .. why) end
        print(("^2[ez_consumables]^7 Imported %s tobacco consumables (%s new effects)"):format(report.consumables, report.effects))
        for _, line in ipairs(report.notes) do print("^3[ez_consumables]^7 Note: " .. line) end
        for _, line in ipairs(report.skipped) do print("^3[ez_consumables]^7 Skipped: " .. line) end
        if #report.unknown > 0 then
            print(("^3[ez_consumables]^7 %s item names are not in the items table:"):format(#report.unknown))
            print("    " .. table.concat(report.unknown, ", "))
        end
        return print("^2[ez_consumables]^7 Done. Remove ez_tobacco now, or its items are registered twice")
    end
    Ready = false
    local report, why = MigrateLegacy(args[1] == "reset")
    if not report then
        LoadAll()
        Ready = true
        return print("^3[ez_consumables]^7 " .. why)
    end
    if report.wiped > 0 then print(("^3[ez_consumables]^7 Wiped %s rows"):format(report.wiped)) end
    print(("^2[ez_consumables]^7 Imported %s consumables, %s packs and %s effects"):format(report.consumables, report.packs, report.effects))
    for _, line in ipairs(report.notes) do print("^3[ez_consumables]^7 Note: " .. line) end
    for _, line in ipairs(report.skipped) do print("^3[ez_consumables]^7 Skipped: " .. line) end
    if #report.unknown > 0 then
        print(("^3[ez_consumables]^7 %s item names are not in the items table (fix or delete them in /%s):"):format(#report.unknown, Config.AdminCommand))
        print("    " .. table.concat(report.unknown, ", "))
    end

    LoadAll()
    SyncUsableItems()
    Ready = true
    print("^2[ez_consumables]^7 Done. The old config in " .. Config.LegacyConfig .. " was not changed")
end, true)
