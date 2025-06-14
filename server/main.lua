VorpInv = exports.vorp_inventory:vorp_inventoryApi()


Citizen.CreateThread(function()
    for k, v in pairs(Config.ItemsToUse) do
        VorpInv.RegisterUsableItem(k, function(data)
            if not v.CoolDown then
                VorpInv.subItem(data.source, k, 1)
            end
            local item = exports.vorp_inventory:getItemDB(k)
            TriggerClientEvent("ez_consume:useitem", data.source, k, item.label)
            Wait(1000)
            if not v.CoolDown then
                TriggerClientEvent("vorp:TipRight", data.source, "Consumed a "..item.label, 5000)
            end
            if v.ItemReturn then
                VorpInv.addItem(data.source, v.ItemReturn, 1)
            end
        end)
    end

    for k, v in pairs(Config.ItemToSplit) do
        VorpInv.RegisterUsableItem(k, function(data)
            VorpInv.subItem(data.source, k, 1)
            for j, l in pairs(v) do
                l.count = l.count or 1
                l.label = l.label or exports.vorp_inventory:getItemDB(l.item).label
                VorpInv.addItem(data.source, j, l.count)
                TriggerClientEvent("vorp:TipRight", data.source, "Received "..l.count.." "..l.label, 5000)
                Wait(1000)
            end
        end)
    end
end)

RegisterNetEvent("ez_consume:removeItem", function(item)
    local src = source
    VorpInv.subItem(src, item, 1)
end)