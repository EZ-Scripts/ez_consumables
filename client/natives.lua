function TaskItemInteraction_2(ped --[[ Ped ]], propNameGxt --[[ Hash ]], prop --[[ Object ]], propId --[[ Hash ]], itemInteractionState --[[ Hash ]], p5 --[[ integer ]], p6 --[[ Any ]], p7 --[[ number ]])
    Citizen.InvokeNative(0x72F52AA2D2B172CC, ped, propNameGxt, prop, propId, itemInteractionState, p5, p6, p7)
end

function SetFillInStateForEntity(entity --[[ Entity ]], p1 --[[ integer ]], p2 --[[ string ]], fill --[[ number ]])
    Citizen.InvokeNative(0x669655FFB29EF1A9, entity, p1, p2, fill)
end

function GetItemInteractionState(ped --[[ Ped ]])
    return Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, ped)
end

function SetItemInteractionState(ped --[[ Ped ]], itemInteractionState --[[ Hash ]], p2 --[[ number ]])
    Citizen.InvokeNative(0xB35370D5353995CB, ped, itemInteractionState, p2)
end

function ForcePedAiAndAnimationUpdate(ped --[[ Ped ]], p1 --[[ boolean ]], p2 --[[ boolean ]])
    Citizen.InvokeNative(0x2208438012482A1A, ped, p1, p2)
end