-- Plays what the player does when they use a consumable (Config.Animations), with its prop

local sleep, deleteObject, createProp, attachProp = SleepUnlessStopped, DeleteProp, CreateProp, AttachProp -- client/functions.lua

--- Waits for the player to finish an item interaction (they stop sipping), up to ms
local function waitInteraction(handle, ped, ms)
    local ends = GetGameTimer() + ms
    sleep(handle, 1000)
    while not handle.stopped and GetGameTimer() < ends do
        local state = GetItemInteractionState(ped)
        if not state or state == 0 then break end
        Wait(250)
    end
end

local Players = {}

--- dict / name: an animation for its duration, holding the prop
function Players.dict(handle, ped, animation, prop)
    local dict, name = animation.dict, animation.name
    if animation.female and not IsPedMale(ped) then dict, name = animation.female.dict, animation.female.name end
    if not LoadAnimDict(dict) then return end
    local object = prop and attachProp(ped, prop)
    handle.cleanup = function()
        deleteObject(object)
        StopAnimTask(ped, dict, name, 1.0)
        RemoveAnimDict(dict)
    end
    TaskPlayAnim(ped, dict, name, 1.0, 8.0, animation.duration, animation.flag or 31, 0.0, false, false, false)
    sleep(handle, animation.duration)
end

--- A game item interaction (the game brings its own prop)
function Players.interaction(handle, ped, animation, _, data)
    TaskItemInteraction(ped, 0, joaat(data.interaction or animation.interaction), true, 0, 0)
    Citizen.InvokeNative(0x2208438012482A1A, ped, true, true) -- ForcePedAiAndAnimationUpdate
    handle.cleanup = function() ClearPedSecondaryTask(ped) end
    sleep(handle, animation.duration or 3000)
end

--- Sipping from a coffee mug until the player puts it away
function Players.coffee(handle, ped, animation, prop)
    local mug = createProp(ped, prop and prop.model or "p_mugcoffee01x")
    if not mug then return end
    handle.cleanup = function()
        ClearPedSecondaryTask(ped)
        SetTimeout(2000, function() deleteObject(mug) end)
    end
    SetFillInStateForEntity(mug, 0, "CTRL_cupFill", 1.0)
    TaskItemInteraction2(ped, joaat("CONSUMABLE_COFFEE"), mug, joaat("P_MUGCOFFEE01X_PH_R_HAND"), joaat("DRINK_COFFEE_HOLD"), 1, 0, -1.0)
    waitInteraction(handle, ped, animation.duration)
end

--- Eating stew from a bowl with a spoon until the player stops
-- https://github.com/femga/rdr3_discoveries/tree/master/tasks/TASK_ITEM_INTERACTION
function Players.stew(handle, ped, animation, prop)
    local bowl = createProp(ped, prop and prop.model or "p_bowl04x_stew")
    local spoon = createProp(ped, "p_beefstew_spoon01x")
    if not bowl or not spoon then
        deleteObject(bowl)
        deleteObject(spoon)
        return
    end
    handle.cleanup = function()
        ClearPedSecondaryTask(ped)
        SetTimeout(2000, function()
            deleteObject(bowl)
            deleteObject(spoon)
        end)
    end
    SetFillInStateForEntity(bowl, 0, "Stew_Fill", 1.0)
    -- Flags the stew interaction needs, kept from the original stew code
    Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)
    Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)
    TaskItemInteraction2(ped, 599184882, bowl, joaat("p_bowl04x_stew_PH_L_HAND"), -583731576, 1, 0, -1.0)
    TaskItemInteraction2(ped, 599184882, spoon, joaat("p_spoon01x_PH_R_HAND"), -583731576, 1, 0, -1.0)
    SetItemInteractionState(ped, -583731576, 1.0)
    waitInteraction(handle, ped, animation.duration)
end

--- Plays a consumable's animation. finished(completed) runs once it ends.
--- Normal animations: completed is false if it was stopped. Smoking: completed is true when every puff was taken,
--- and onPuff(n) runs after each puff
--- @param data table {animation, interaction, prop, uses, use_time, label} as sent for the consumable
--- @return table handle Call handle.stop() to end it early
function PlayConsumeAnimation(data, finished, onPuff)
    local key = data.animation or Config.DefaultAnimation
    local animation = Config.Animations[key] or Config.Animations[Config.DefaultAnimation]
    local handle = {stopped = false, done = false}
    function handle.stop()
        if handle.stopped then return end
        handle.stopped = true
    end

    CreateThread(function()
        local ped = PlayerPedId()
        local prop = MergeProp(animation, data.prop)
        local player -- nil for "none": nothing to play
        if animation.smoke then
            player = Smokers[animation.smoke] -- client/smoking.lua
        elseif animation.scripted then
            player = Players[animation.scripted]
        elseif animation.interaction then
            player = Players.interaction
        elseif animation.dict then
            player = Players.dict
        end
        local completed = true
        if player then
            local ok, result = pcall(player, handle, ped, animation, prop, data, onPuff or function() end)
            if not ok then print("^1[ez_consumables] Animation " .. tostring(key) .. " failed: " .. tostring(result) .. "^7") end
            if animation.smoke then
                completed = ok and (tonumber(result) or 0) >= (data.uses or 1)
            else
                completed = not handle.stopped
            end
        end
        handle.done = true
        if handle.cleanup then handle.cleanup() end
        if finished then finished(completed) end
    end)
    return handle
end
