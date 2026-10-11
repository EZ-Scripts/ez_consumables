Config = Config or {}

--- Function to add values.
--- This is compatible with VORP & EZ.
--- @param status table
--- @return nil
--- @usage Config.ExecuteStatus({ Stress = 100, Hunger = 50, Thirst = 75, Metabolism = 25 })
Config.ExecuteStatus = function(status)
    for k, v in pairs(status) do
        if k == "Stress" then
            v = v * -1
        end
        TriggerEvent("vorpmetabolism:changeValue", k, v*10)
    end
    return nil
end

--- Table that holds functions for animations.
Config.Animations = {
    --- @param itemInfo table
    --- @param cb function
    drink = function(itemInfo, cb)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local dict = "amb_rest_drunk@world_human_drinking@male_a@idle_a"
        local anim = "idle_a"

        if (not IsPedMale(PlayerPedId())) then
            dict = "amb_rest_drunk@world_human_drinking@female_a@idle_b"
            anim = "idle_b"
        end

        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do
            Wait(100)
        end

        local hashItem = GetHashKey(itemInfo.Prop and itemInfo.Prop.name or "P_GLENSWHISKY01X")

        local prop = CreateObject(hashItem, playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
        local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), itemInfo.Prop and itemInfo.Prop.bone or "SKEL_R_HAND") -- SKEL_R_Finger12

        Wait(1000)

        TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
        local pcoords = itemInfo.Prop and itemInfo.Prop.coords or {x = 0.08, y = -0.04, z = -0.05}
        local prot = itemInfo.Prop and itemInfo.Prop.rot or {x = -75.0, y = 0.0, z = 0.0}
        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, pcoords.x, pcoords.y, pcoords.z, prot.x, prot.y, prot.z, true, true, false, true, 1, true)
        -- AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.02, -0.018, 0.10, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
        Wait(5300) -- 6000

        DeleteObject(prop)
        ClearPedSecondaryTask(PlayerPedId())
        if cb then cb(true) end
    end,
    eat = function(itemInfo, cb)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local dict = "mech_inventory@clothing@bandana"
        local anim = "NECK_2_FACE_RH"

        --if (!IsPedMale(PlayerPedId())) then
        --    dict = "amb_rest_drunk@world_human_drinking@female_a@idle_b"
        --    anim = "idle_b"
        --end

        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do
            Wait(100)
        end

        local hashItem = GetHashKey(itemInfo.Prop and itemInfo.Prop.name)

        local prop = CreateObject(hashItem, playerCoords.x, playerCoords.y, playerCoords.z + 0.2, true, true, false)
        local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), itemInfo.Prop and itemInfo.Prop.bone or "SKEL_R_HAND") -- SKEL_R_Finger12

        Wait(1000)

        TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
        local pcoords = itemInfo.Prop and itemInfo.Prop.coords or {x = 0.08, y = -0.04, z = -0.05}
        local prot = itemInfo.Prop and itemInfo.Prop.rot or {x = -75.0, y = 0.0, z = 0.0}
        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, pcoords.x, pcoords.y, pcoords.z, prot.x, prot.y, prot.z, true, true, false, true, 1, true)
        Wait(5300) -- 6000

        DeleteObject(prop)
        ClearPedSecondaryTask(PlayerPedId())
        if cb then cb(true) end
    end,
    coffee = function(itemInfo, cb)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local coffeeProp = CreateObject(joaat(itemInfo.Prop and itemInfo.Prop.name or "p_mugcoffee01x"), playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
        SetFillInStateForEntity(coffeeProp, 0, "CTRL_cupFill", 1.0)
        TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_COFFEE"), coffeeProp, GetHashKey("P_MUGCOFFEE01X_PH_R_HAND"), GetHashKey("DRINK_COFFEE_HOLD"), 1, 0, -1082130432)
        CreateThread(function()
            local timer = 0
            while timer < 60000 do
                Wait(1000)
                timer = timer + 1000
                local state = GetItemInteractionState(PlayerPedId())
                if state == 0 or state == nil or state == false then
                    break
                end
            end
            if cb then cb(true) end
            Wait(2000)
            DeleteObject(coffeeProp)
            ClearPedSecondaryTask(PlayerPedId())
        end)
    end,
    bandage = function(itemInfo, cb)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local dict = "mini_games@story@mob4@heal_jules@bandage@arthur"
        local anim = "tourniquet_slow"

        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do
            Wait(100)
        end

        local hashItem = GetHashKey(itemInfo.Prop and itemInfo.Prop.name or "p_cs_bandage01x")

        local prop = CreateObject(hashItem, playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
        local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_L_HAND")

        Wait(1000)

        TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
        local pcoords = itemInfo.Prop and itemInfo.Prop.coords or {x = 0.10, y = 0.0, z = 0.03}
        local prot = itemInfo.Prop and itemInfo.Prop.rot or {x = 0.0, y = -60.0, z = -90.0}
        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, pcoords.x, pcoords.y, pcoords.z, prot.x, prot.y, prot.z, true, true, false, true, 1, true)
        Wait(6000)

        DeleteObject(prop)
        ClearPedSecondaryTask(PlayerPedId())
        if cb then cb(true) end
    end,
    syringe = function(itemInfo, cb)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local dict = "mech_inventory@item@stimulants@inject@quick"
        local anim = "quick_stimulant_inject_lhand"

        RequestAnimDict(dict)
        while (not HasAnimDictLoaded(dict)) do
            Wait(100)
        end

        local hashItem = GetHashKey(itemInfo.Prop and itemInfo.Prop.name or "mp007_p_mp_syringe01x_1")

        local prop = CreateObject(hashItem, playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
        local boneIndex = GetEntityBoneIndexByName(PlayerPedId(), "SKEL_L_HAND")

        Wait(1000)

        TaskPlayAnim(PlayerPedId(), dict, anim, 1.0, 8.0, 5000, 31, 0.0, false, false, false)
        local pcoords = itemInfo.Prop and itemInfo.Prop.coords or {x = 0.10, y = 0.0, z = 0.03}
        local prot = itemInfo.Prop and itemInfo.Prop.rot or {x = 0.0, y = -80.0, z = -90.0}
        AttachEntityToEntity(prop, PlayerPedId(), boneIndex, pcoords.x, pcoords.y, pcoords.z, prot.x, prot.y, prot.z, true, true, false, true, 1, true)
        Wait(2000) -- 6000

        DeleteObject(prop)
        ClearPedSecondaryTask(PlayerPedId())
        if cb then cb(true) end
    end,
    stew = function(itemInfo, cb)
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local stewProp = CreateObject(itemInfo.Prop and itemInfo.Prop.name or "p_syringe01x", playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
        local stewSpoonProp = CreateObject("p_beefstew_spoon01x", playerCoords.x, playerCoords.y, playerCoords.z, true, true, false)
        Citizen.InvokeNative(0x669655FFB29EF1A9, stewProp, 0, "Stew_Fill", 1.0)
        Citizen.InvokeNative(0xCAAF2BCCFEF37F77, stewProp, 20)
        Citizen.InvokeNative(0xCAAF2BCCFEF37F77, stewSpoonProp, 82)
        -- https://github.com/femga/rdr3_discoveries/blob/ab8efca7aaf8f3e3b3b5a76893ac4787ad676dbf/animations/scenarios/scenario_attached_props.lua
        TaskItemInteraction_2(playerPed, 599184882, stewProp, joaat("p_bowl04x_stew_PH_L_HAND"), -583731576, 1, 0, -1.0)
        TaskItemInteraction_2(playerPed, 599184882, stewSpoonProp, joaat("p_spoon01x_PH_R_HAND"), -583731576, 1, 0, -1.0)
        -- https://github.com/femga/rdr3_discoveries/tree/master/tasks/TASK_ITEM_INTERACTION#-4-item_interaction_state_name--item_interaction_propid--1
        SetItemInteractionState(playerPed, -583731576, 1.0)
        CreateThread(function()
            local timer = 0
            while timer < 60000 do
                Wait(1000)
                timer = timer + 1000
                local state = GetItemInteractionState(PlayerPedId())
                if state == 0 or state == nil or state == false then
                    break
                end
            end
            if cb then cb(true) end
            Wait(2000)
            DeleteObject(stewProp)
            DeleteObject(stewSpoonProp)
            ClearPedSecondaryTask(PlayerPedId())
        end)
    end,
}