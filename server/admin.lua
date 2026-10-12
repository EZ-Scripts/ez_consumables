-- /manageconsumables: admins create and edit consumables and effects in game.
-- Each change writes its row, updates memory, then sends just the changed rows to every admin with the panel open.

local AdminOpen = {} -- [src] = true while the panel is open

-- The panel keeps what it was sent while it is closed. Opening it again only sends what changed since:
--   DataRevision   consumables and effects (database.lua bumps it on every reload)
--   StaticRevision the items table and the config lists (rebuilt in the background)
local Sent = {} -- [src] = {data = revision, static = revision}
local Static, StaticRevision, StaticJson = nil, 0, nil
local STATIC_REFRESH <const> = 15 * 60 * 1000
local SEND_RATE <const> = 4000000 -- bytes a second for a full send

local function adminName(src)
    local identity = GetIdentity(src)
    return ((identity and identity.name or "?") .. " (" .. (GetPlayerName(src) or "?") .. ")"):sub(1, 100)
end

local function toast(src, text, ok)
    TriggerClientEvent("ez_consumables:client:adminToast", src, text, ok and true or false)
end

--- Sends changed rows to every open panel. patch = {consumables = {...}, effects = {...}, removed = {kind = {ids}}}
local function sendPatch(patch, src, select)
    DataRevision = DataRevision + 1
    for admin in pairs(AdminOpen) do
        TriggerClientEvent("ez_consumables:client:adminPatch", admin, patch, admin == src and select or nil)
        if Sent[admin] then Sent[admin].data = DataRevision end
    end
end

local function list(kind)
    local rows = {}
    for _, row in pairs(Data[kind]) do rows[#rows + 1] = row end
    return rows
end

local function rebuildStatic()
    local items = {}
    for name, item in pairs(Items) do items[#items + 1] = {name = name, label = item.label, usable = item.usable} end
    table.sort(items, function(a, b) return a.label:lower() < b.label:lower() end)
    local animations = {}
    for key, animation in pairs(Config.Animations) do
        animations[#animations + 1] = {
            key = key, label = animation.label or key, prop = animation.prop, interaction = animation.interaction,
            none = animation.none == true, smoke = animation.smoke ~= nil, useTime = animation.useTime,
            -- The animation places the prop itself (coffee, stew, cigarette, chew): only its model can change
            modelOnly = animation.prop ~= nil and animation.prop.bone == nil,
        }
    end
    table.sort(animations, function(a, b) return a.label < b.label end)
    local kinds = {}
    for i, kind in ipairs(Config.Kinds) do kinds[i] = {key = kind.key, label = kind.label} end
    local static = {
        items = items,
        animations = animations,
        kinds = kinds,
        bones = Config.Bones,
        screenEffects = Config.ScreenEffects,
        timecycles = Config.Timecycles,
        shakes = Config.CameraShakes,
        limits = Limits,
    }
    local encoded = json.encode(static)
    if encoded ~= StaticJson then
        Static, StaticJson = static, encoded
        StaticRevision = StaticRevision + 1
    end
end

--- Re-reads the items table now and then, so items added since show up in the pickers
local function refreshItems()
    LoadItemList()
    rebuildStatic()
    SetTimeout(STATIC_REFRESH, refreshItems)
end

CreateThread(function()
    while not Ready do Wait(500) end
    SetTimeout(STATIC_REFRESH, refreshItems)
end)

-- ez_itemcreator made, changed or removed an item: re-read the items table now, not on the next refresh.
-- Server only (AddEventHandler), several changes close together are read once
local itemsQueued = false
AddEventHandler("ez_itemcreator:itemsChanged", function()
    if not Ready or itemsQueued then return end
    itemsQueued = true
    SetTimeout(1000, function()
        itemsQueued = false
        LoadItemList()
        rebuildStatic()
    end)
end)

--- Sends the panel only what it doesn't have yet. full = send everything
local function openPanel(src, full)
    if not Static then rebuildStatic() end
    local had = (not full and Sent[src]) or {}
    local payload = {
        revision = DataRevision,
        defaults = {
            animation = Config.DefaultAnimation, kind = Config.DefaultKind, effectTime = Config.DefaultEffectTime,
            drunk = Config.Drunk.Drunk, passOut = Config.Drunk.PassOut,
        },
    }
    if had.data ~= DataRevision then payload.rows = {consumables = list("consumables"), effects = list("effects")} end
    if had.static ~= StaticRevision then payload.static = Static end
    Sent[src] = {data = DataRevision, static = StaticRevision}
    AdminOpen[src] = true
    if payload.rows or payload.static then
        TriggerLatentClientEvent("ez_consumables:client:admin", src, SEND_RATE, payload)
    else
        TriggerClientEvent("ez_consumables:client:admin", src, payload)
    end
end

-- The panel lost what it had (should not happen): send everything
RegisterNetEvent("ez_consumables:server:adminResync", function()
    local src = source
    if AdminOpen[src] and IsAdmin(src) then openPanel(src, true) end
end)

RegisterCommand(Config.AdminCommand, function(src)
    if src == 0 then return print("[ez_consumables] /" .. Config.AdminCommand .. " is an in game command") end
    if not IsAdmin(src) then return Notify(src, T("notify.noPermission")) end
    if not Ready then return Notify(src, T("notify.loading")) end
    openPanel(src)
end, false)

-- Chat suggestion for admins only
AddEventHandler("vorp:SelectedCharacter", function(src)
    SetTimeout(2000, function()
        if IsAdmin(src) then TriggerClientEvent("chat:addSuggestion", src, "/" .. Config.AdminCommand, T("admin.suggestion")) end
    end)
end)

RegisterNetEvent("ez_consumables:server:adminClose", function()
    AdminOpen[source] = nil
end)

AddEventHandler("playerDropped", function()
    AdminOpen[source] = nil
    Sent[source] = nil
end)

---------------------------------------------------------------- Actions

local Actions = {}

--- Who made a change, for the history: their license and their name
local function actorOf(src)
    return {id = GetPlayerIdentifierByType(src, "license"), name = adminName(src)}
end

local function shown(value)
    if value == "" or value == nil then return "-" end
    if type(value) == "table" then value = json.encode(value) end
    return tostring(value):sub(1, 80)
end

--- "field: `old` → `new`" per changed column, for Discord
local function changesText(changes)
    local parts = {}
    for column, pair in pairs(changes or {}) do
        parts[#parts + 1] = ("%s: `%s` → `%s`"):format(column, shown(pair[1]), shown(pair[2]))
    end
    table.sort(parts)
    return table.concat(parts, "\n")
end

--- What a history entry is: a new row, a change, or a version put back (restore = put back after a delete)
local function actionOf(before, revertOf, restoring)
    if revertOf then return restoring and "restore" or "revert" end
    return before and "update" or "create"
end

local LogTitles = {
    consumables = {create = "Consumable Created", update = "Consumable Updated", revert = "Consumable Reverted", restore = "Consumable Restored"},
    effects = {create = "Effect Created", update = "Effect Updated", revert = "Effect Reverted", restore = "Effect Restored"},
}

--- Creates or changes a consumable. revertOf = the history entry being put back (from Actions.revert)
local function saveConsumable(src, input, revertOf)
    local c, why = CleanConsumable(input)
    if not c then return toast(src, T("admin.errors." .. why)) end
    local before = c.id and Data.consumables[c.id]
    -- Putting back a deleted consumable brings it back under its old id
    local restoring = revertOf ~= nil and c.id ~= nil and not before
    if c.id and not before and not restoring then return toast(src, T("admin.errors.missing")) end
    local other = ByItem[c.item]
    if other and other.id ~= c.id then return toast(src, T("admin.errors.duplicate", LabelOf(c.item))) end
    local names = {c.item}
    for _, give in ipairs(c.gives) do names[#names + 1] = give.name end
    for _, need in ipairs(c.requires) do names[#names + 1] = need.name end
    local unknown = UnknownItems(names)
    if #unknown > 0 then return toast(src, T("admin.errors.unknownItems", table.concat(unknown, ", "))) end
    local changes = Differences("consumables", before, c)
    if before and not changes then return toast(src, T(revertOf and "admin.errors.alreadyThat" or "admin.errors.nothingChanged")) end

    local actor = actorOf(src)
    c.updated_by = actor.name
    if before then
        DbUpdate("consumables", c)
    elseif not DbInsert("consumables", c, restoring and c.id or nil) then
        return toast(src, T("admin.errors.database"))
    end
    Data.consumables[c.id] = c
    RebuildIndex()
    SyncUsableItems()
    local action = actionOf(before, revertOf, restoring)
    DbHistory({kind = "consumables", row = c, action = action, actor = actor, changes = changes, before = before})

    sendPatch({consumables = {c}, history = true}, src, {kind = "consumables", id = c.id})
    toast(src, T(revertOf and "admin.reverted" or before and "admin.saved" or "admin.created", LabelOf(c.item)), true)
    Log(LogTitles.consumables[action], ("**%s** (`%s`, #%s)%s\n%s"):format(LabelOf(c.item), c.item, c.id, revertOf and (" to history #" .. revertOf) or "", changesText(changes)),
        revertOf and Config.LogColors.revert or nil, src)
end

function Actions.saveConsumable(src, input)
    saveConsumable(src, input)
end

function Actions.deleteConsumable(src, id)
    local c = Data.consumables[WholeNumber(id, 1) or 0]
    if not c then return toast(src, T("admin.errors.missing")) end
    DbDelete("consumables", c.id)
    Data.consumables[c.id] = nil
    RebuildIndex()
    SyncUsableItems()
    DbHistory({kind = "consumables", row = c, action = "delete", actor = actorOf(src), before = c})
    sendPatch({removed = {consumables = {c.id}}, history = true}, src)
    toast(src, T("admin.deleted", LabelOf(c.item)), true)
    Log("Consumable Deleted", ("**%s** (`%s`, #%s)\n```%s```"):format(LabelOf(c.item), c.item, c.id, json.encode(c)), Config.LogColors.delete, src)
end

--- Creates or changes an effect. revertOf = the history entry being put back (from Actions.revert)
local function saveEffect(src, input, revertOf)
    local e, why = CleanEffect(input)
    if not e then return toast(src, T("admin.errors." .. why)) end
    local before = e.id and Data.effects[e.id]
    local restoring = revertOf ~= nil and e.id ~= nil and not before
    if e.id and not before and not restoring then return toast(src, T("admin.errors.missing")) end
    local changes = Differences("effects", before, e)
    if before and not changes then return toast(src, T(revertOf and "admin.errors.alreadyThat" or "admin.errors.nothingChanged")) end

    if before then
        DbUpdate("effects", e)
    elseif not DbInsert("effects", e, restoring and e.id or nil) then
        return toast(src, T("admin.errors.database"))
    end
    Data.effects[e.id] = e
    local action = actionOf(before, revertOf, restoring)
    DbHistory({kind = "effects", row = e, action = action, actor = actorOf(src), changes = changes, before = before})

    sendPatch({effects = {e}, history = true}, src, {kind = "effects", id = e.id})
    toast(src, T(revertOf and "admin.reverted" or before and "admin.saved" or "admin.created", e.label), true)
    Log(LogTitles.effects[action], ("**%s** (#%s)%s\n%s"):format(e.label, e.id, revertOf and (" to history #" .. revertOf) or "", changesText(changes)),
        revertOf and Config.LogColors.revert or nil, src)
end

function Actions.saveEffect(src, input)
    saveEffect(src, input)
end

function Actions.deleteEffect(src, id)
    local e = Data.effects[WholeNumber(id, 1) or 0]
    if not e then return toast(src, T("admin.errors.missing")) end
    local actor = actorOf(src)
    local changed, olds = {}, {}
    for _, c in pairs(Data.consumables) do
        if c.effect == e.id then
            local old = {}
            for key, value in pairs(c) do old[key] = value end
            c.effect, c.effect_time = nil, nil
            changed[#changed + 1] = c
            olds[#olds + 1] = old
        end
    end
    DbUpdateMany("consumables", changed)
    DbDelete("effects", e.id)
    Data.effects[e.id] = nil
    DbHistory({kind = "effects", row = e, action = "delete", actor = actor, before = e})
    -- Each consumable that lost the effect gets its own entry, so it can be put back too
    for i, c in ipairs(changed) do
        DbHistory({kind = "consumables", row = c, action = "update", actor = actor, changes = Differences("consumables", olds[i], c), before = olds[i]})
    end
    sendPatch({consumables = changed, removed = {effects = {e.id}}, history = true}, src)
    toast(src, T("admin.deleted", e.label), true)
    if #changed > 0 then toast(src, T("admin.cleared", #changed)) end
    Log("Effect Deleted", ("**%s** (#%s), taken off %s consumables\n```%s```"):format(e.label, e.id, #changed, json.encode(e)), Config.LogColors.delete, src)
end

--- Puts a consumable or effect back the way it was before a history entry (brings it back if it was deleted)
function Actions.revert(src, id)
    id = WholeNumber(id, 1)
    local entry = id and DbReadHistory(id)
    if not entry or type(entry.before) ~= "table" then return toast(src, T("admin.errors.noVersion")) end
    local input = entry.before
    input.id = entry.row_id
    if entry.kind == "consumables" then
        saveConsumable(src, input, entry.id)
    else
        saveEffect(src, input, entry.id)
    end
end

--- A page of history for the History tab. filter = {kind?, row_id?, search?, before?, token}
function Actions.history(src, filter)
    filter = type(filter) == "table" and filter or {}
    local rows, more = DbHistoryPage({
        kind = filter.kind,
        row_id = WholeNumber(filter.row_id, 1),
        search = type(filter.search) == "string" and filter.search:sub(1, 64) or nil,
        before = WholeNumber(filter.before, 1),
    }, Config.HistoryPage)
    TriggerClientEvent("ez_consumables:client:adminHistory", src, {rows = rows, more = more, append = filter.before ~= nil, token = filter.token})
end

RegisterNetEvent("ez_consumables:server:admin", function(action, payload)
    local src = source
    if not AdminOpen[src] or not IsAdmin(src) or not Ready then return end
    local fn = type(action) == "string" and Actions[action]
    if not fn then return end
    local ok, err = pcall(fn, src, payload)
    if not ok then
        print(("^1[ez_consumables] Admin action %s failed: %s^7"):format(action, tostring(err)))
        toast(src, T("admin.errors.database"))
    end
end)
