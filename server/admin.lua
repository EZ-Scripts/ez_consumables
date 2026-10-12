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

function Actions.saveConsumable(src, input)
    local c, why = CleanConsumable(input)
    if not c then return toast(src, T("admin.errors." .. why)) end
    local before = c.id and Data.consumables[c.id]
    if c.id and not before then return toast(src, T("admin.errors.missing")) end
    local other = ByItem[c.item]
    if other and other.id ~= c.id then return toast(src, T("admin.errors.duplicate", LabelOf(c.item))) end
    local names = {c.item}
    for _, give in ipairs(c.gives) do names[#names + 1] = give.name end
    for _, need in ipairs(c.requires) do names[#names + 1] = need.name end
    local unknown = UnknownItems(names)
    if #unknown > 0 then return toast(src, T("admin.errors.unknownItems", table.concat(unknown, ", "))) end

    c.updated_by = adminName(src)
    if before then
        DbUpdate("consumables", c)
    elseif not DbInsert("consumables", c) then
        return toast(src, T("admin.errors.database"))
    end
    Data.consumables[c.id] = c
    RebuildIndex()
    SyncUsableItems()

    sendPatch({consumables = {c}}, src, {kind = "consumables", id = c.id})
    toast(src, T(before and "admin.saved" or "admin.created", LabelOf(c.item)), true)
    Log(before and "Consumable Updated" or "Consumable Created", ("**%s** (`%s`, #%s)\n```%s```"):format(LabelOf(c.item), c.item, c.id, json.encode(c)), nil, src)
end

function Actions.deleteConsumable(src, id)
    local c = Data.consumables[WholeNumber(id, 1) or 0]
    if not c then return toast(src, T("admin.errors.missing")) end
    DbDelete("consumables", c.id)
    Data.consumables[c.id] = nil
    RebuildIndex()
    SyncUsableItems()
    sendPatch({removed = {consumables = {c.id}}}, src)
    toast(src, T("admin.deleted", LabelOf(c.item)), true)
    Log("Consumable Deleted", ("**%s** (`%s`, #%s)\n```%s```"):format(LabelOf(c.item), c.item, c.id, json.encode(c)), Config.LogColors.delete, src)
end

function Actions.saveEffect(src, input)
    local e, why = CleanEffect(input)
    if not e then return toast(src, T("admin.errors." .. why)) end
    local before = e.id and Data.effects[e.id]
    if e.id and not before then return toast(src, T("admin.errors.missing")) end
    if before then
        DbUpdate("effects", e)
    elseif not DbInsert("effects", e) then
        return toast(src, T("admin.errors.database"))
    end
    Data.effects[e.id] = e
    sendPatch({effects = {e}}, src, {kind = "effects", id = e.id})
    toast(src, T(before and "admin.saved" or "admin.created", e.label), true)
    Log(before and "Effect Updated" or "Effect Created", ("**%s** (#%s)\n```%s```"):format(e.label, e.id, json.encode(e)), nil, src)
end

function Actions.deleteEffect(src, id)
    local e = Data.effects[WholeNumber(id, 1) or 0]
    if not e then return toast(src, T("admin.errors.missing")) end
    local changed = {}
    for _, c in pairs(Data.consumables) do
        if c.effect == e.id then
            c.effect, c.effect_time = nil, nil
            changed[#changed + 1] = c
        end
    end
    DbUpdateMany("consumables", changed)
    DbDelete("effects", e.id)
    Data.effects[e.id] = nil
    sendPatch({consumables = changed, removed = {effects = {e.id}}}, src)
    toast(src, T("admin.deleted", e.label), true)
    if #changed > 0 then toast(src, T("admin.cleared", #changed)) end
    Log("Effect Deleted", ("**%s** (#%s), taken off %s consumables"):format(e.label, e.id, #changed), Config.LogColors.delete, src)
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
