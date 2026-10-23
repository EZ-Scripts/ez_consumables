function LoadModel(model)
    local hash = type(model) == "number" and model or joaat(model)
    if not IsModelValid(hash) then return nil end
    RequestModel(hash, false)
    local timeout = GetGameTimer() + 5000
    while not HasModelLoaded(hash) do
        if GetGameTimer() > timeout then return nil end
        Wait(0)
    end
    return hash
end

function LoadAnimDict(dict)
    if not DoesAnimDictExist(dict) then return false end
    RequestAnimDict(dict)
    local timeout = GetGameTimer() + 5000
    while not HasAnimDictLoaded(dict) do
        if GetGameTimer() > timeout then return false end
        Wait(0)
    end
    return true
end

---------------------------------------------------------------- Props and waits shared by animations.lua and smoking.lua

--- Waits ms, or less if the animation was stopped (handle.stopped). Returns false if it was stopped
function SleepUnlessStopped(handle, ms)
    local ends = GetGameTimer() + ms
    while not handle.stopped and GetGameTimer() < ends do Wait(50) end
    return not handle.stopped
end

function DeleteProp(object)
    if object and DoesEntityExist(object) then
        DetachEntity(object, true, true)
        DeleteObject(object)
    end
end

--- A networked prop at the ped, or nil if the model doesn't load
function CreateProp(ped, model, z)
    local hash = model and LoadModel(model)
    if not hash then return nil end
    local coords = GetEntityCoords(ped)
    local object = CreateObject(hash, coords.x, coords.y, coords.z + (z or 0.0), true, true, false)
    SetModelAsNoLongerNeeded(hash)
    return object
end

--- Attaches an object to a bone of the ped
function AttachToBone(object, ped, bone, o, r)
    AttachEntityToEntity(object, ped, GetEntityBoneIndexByName(ped, bone), o.x + 0.0, o.y + 0.0, o.z + 0.0, r.x + 0.0, r.y + 0.0, r.z + 0.0, true, true, false, true, 1, true)
end

--- Creates a prop {model, bone, offset, rotation} in the ped's hand
function AttachProp(ped, prop)
    local object = CreateProp(ped, prop.model, 0.2)
    if object then AttachToBone(object, ped, prop.bone, prop.offset, prop.rotation) end
    return object
end

function ShowTip(text, duration)
    TriggerEvent("vorp:TipRight", text, duration or 4000)
end

---------------------------------------------------------------- Natives without a name in the RedM Lua runtime

--- Shuts the vorp inventory window, used when a consumable is used from it
function CloseInventory()
    TriggerEvent("vorp_inventory:CloseInv")
end

function SetPedDrunkness(ped, drunk, amount)
    Citizen.InvokeNative(0x406CCF555B04FAD3, ped, drunk, amount + 0.0)
end

function GetAttributeCoreValue(ped, core)
    return tonumber(Citizen.InvokeNative(0x36731AC041289BB1, ped, core, Citizen.ResultAsInteger())) or 0
end

function SetAttributeCoreValue(ped, core, value)
    Citizen.InvokeNative(0xC6258F41D86676E0, ped, core, math.floor(value))
end

--- Makes an inner core gold for a while
function EnableAttributeCoreOverpower(ped, core, value)
    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, core, value + 0.0, true)
end

--- Makes an outer bar gold for a while
function EnableAttributeOverpower(ped, core, value)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, core, value + 0.0, true)
end

function TaskItemInteraction2(ped, propNameGxt, prop, propId, state, p5, p6, p7)
    Citizen.InvokeNative(0x72F52AA2D2B172CC, ped, propNameGxt, prop, propId, state, p5, p6, p7)
end

function GetItemInteractionState(ped)
    return Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, ped)
end

function SetItemInteractionState(ped, state, p2)
    Citizen.InvokeNative(0xB35370D5353995CB, ped, state, p2)
end

function SetFillInStateForEntity(entity, p1, name, fill)
    Citizen.InvokeNative(0x669655FFB29EF1A9, entity, p1, name, fill)
end
