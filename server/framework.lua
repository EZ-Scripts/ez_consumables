-- Everything that touches vorp_core, vorp_inventory or ez_logs lives here

Core = exports.vorp_core:GetCore()
local Inv = exports.vorp_inventory

--- Who the player is: charId and name. nil if they have no character loaded
GetIdentity = function(source)
    local user = Core.getUser(source)
    local character = user and user.getUsedCharacter
    if not character then return nil end
    return {
        charId = tonumber(character.charIdentifier),
        name = (character.firstname or "") .. " " .. (character.lastname or ""),
    }
end

IsAdmin = function(source)
    if source == 0 then return true end
    local user = Core.getUser(source)
    return user and Config.AdminGroups[user.getGroup] or false
end

Notify = function(source, text, duration)
    TriggerClientEvent("vorp:TipRight", source, text, duration or 4000)
end

---------------------------------------------------------------- Inventory

--- Takes the exact stack the player used (keeps degradation right), or any one of the item
TakeUsedItem = function(source, name, id)
    if id then return Inv:subItemID(source, id) and true or false end
    return Inv:subItem(source, name, 1) and true or false
end

ItemCount = function(source, name)
    return tonumber(Inv:getItemCount(source, nil, name)) or 0
end

GiveItem = function(source, name, amount)
    return Inv:addItem(source, name, amount) and true or false
end

CanCarryItem = function(source, name, amount)
    return Inv:canCarryItem(source, name, amount) and true or false
end

RegisterUsableItem = function(name, fn)
    Inv:registerUsableItem(name, function(data) fn(data.source, data.item) end, GetCurrentResourceName())
end

UnregisterUsableItem = function(name)
    Inv:unRegisterUsableItem(name)
end

--- {[name] = {label, usable}} for every item in the items table
LoadItems = function()
    local items = {}
    for _, row in ipairs(MySQL.query.await("SELECT `item`, `label`, `usable` FROM `items`") or {}) do
        items[row.item] = {label = row.label or row.item, usable = tonumber(row.usable) == 1 or row.usable == true}
    end
    return items
end

---------------------------------------------------------------- Logs

--- Discord log through ez_logs (it adds the player's details)
Log = function(title, message, color, src)
    if Config.Webhook == "" then return DebugPrint("Log (no webhook)", title .. ": " .. message) end
    if GetResourceState("ez_logs") ~= "started" then return end
    exports.ez_logs:CreateLog({
        title = title,
        color = color or Config.LogColors.admin,
        message = message,
        players = src and src > 0 and {src} or nil,
        webhook = Config.Webhook,
    })
end
