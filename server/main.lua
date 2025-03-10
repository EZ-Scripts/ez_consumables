VorpInv = exports.vorp_inventory:vorp_inventoryApi()


Citizen.CreateThread(function()
    for k, v in pairs(Config.ItemsToUse) do
        VorpInv.RegisterUsableItem(k, function(data)
            TriggerClientEvent("ez_consume:useitem", data.source, k)
            VorpInv.subItem(data.source, k, 1)
            local item = exports.vorp_inventory:getItemDB(k)
            Wait(1000)
            TriggerClientEvent("vorp:TipRight", data.source, "Consumed a "..item.label, 5000)
            if v.ItemReturn then
                VorpInv.addItem(data.source, v.ItemReturn, 1)
            end
        end)
    end
end)