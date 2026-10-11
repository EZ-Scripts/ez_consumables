-- Effects (screen effects, wobble, camera shake, blur that last a while) and alcohol

local Active = nil -- {effect, ends, token}: the effect running now. One at a time, a new one replaces it
local END_FX_TIME <const> = 4000 -- ms an effect's "at the end" screen effect plays for
local SHAKE_EVERY <const> = 1500 -- ms between camera shakes

Alcohol = 0
local PassingOut = false
local DrunkFx = false

---------------------------------------------------------------- Alcohol

--- Wobble and the drunk screen effect, from the alcohol level. An effect with its own wobble wins while it runs
function RefreshDrunk()
    local ped = PlayerPedId()
    local drunk = Alcohol > Config.Drunk.Drunk
    if not (Active and Active.effect.drunk > 0) then
        SetPedDrunkness(ped, drunk, drunk and Config.Drunk.Wobble or 0.0)
    end
    if drunk ~= DrunkFx then
        DrunkFx = drunk
        if drunk then AnimpostfxPlay(Config.Drunk.ScreenEffect) else AnimpostfxStop(Config.Drunk.ScreenEffect) end
    end
end

function AddAlcohol(amount)
    Alcohol = math.max(0, Alcohol + (tonumber(amount) or 0))
    RefreshDrunk()
end

function SetAlcohol(amount)
    Alcohol = math.max(0, tonumber(amount) or 0)
    RefreshDrunk()
end

local function playAnim(ped, dict, name, flag)
    if not LoadAnimDict(dict) then return end
    TaskPlayAnim(ped, dict, name, 8.0, -8.0, -1, flag, 0, true, 0, false, 0, false)
    RemoveAnimDict(dict)
end

--- Throws up, falls asleep, wakes up a day later still drunk
local function passOut()
    PassingOut = true
    local ped = PlayerPedId()
    playAnim(ped, "amb_misc@world_human_vomit@male_a@idle_b", "idle_f", 31)
    Wait(10000)
    ClearPedTasks(ped)
    playAnim(ped, "amb_rest@world_human_sleep_ground@arm@male_b@idle_b", "idle_f", 1)
    Wait(10000)
    AnimpostfxPlay("PlayerDrunk01_PassOut")
    DoScreenFadeOut(10000)
    Wait(10000)
    AnimpostfxStop("PlayerDrunk01_PassOut")
    AnimpostfxPlay("PlayerWakeUpDrunk")
    AnimpostfxPlay("Title_Gen_daylater")
    DoScreenFadeIn(10000)
    Wait(10000)
    AnimpostfxStop("PlayerWakeUpDrunk")
    AnimpostfxStop("Title_Gen_daylater")
    ClearPedTasks(ped)
    Citizen.InvokeNative(0x58F7DB5BD8FA2288, ped) -- kept from the original pass out code
    Alcohol = Config.Drunk.Drunk + 1
    PassingOut = false
    RefreshDrunk()
end

-- Alcohol wears off a point at a time: faster while drunk, slower while just tipsy
CreateThread(function()
    local wearOff = 0
    while true do
        Wait(1000)
        if Alcohol > 0 and not PassingOut then
            if Alcohol > Config.Drunk.PassOut then
                passOut()
            else
                wearOff = wearOff + 1
                local every = Alcohol > Config.Drunk.Drunk and Config.Drunk.SoberDrunk or Config.Drunk.SoberTipsy
                if wearOff >= every then
                    wearOff = 0
                    Alcohol = math.max(0, Alcohol - 1)
                    DebugPrint("alcohol", Alcohol)
                end
                RefreshDrunk()
            end
        end
    end
end)

---------------------------------------------------------------- Effects

--- Ends the running effect. finished = it ran its full time (plays its "at the end" screen effect)
function StopEffect(finished)
    local current = Active
    if not current then return end
    Active = nil
    local e, ped = current.effect, PlayerPedId()
    if e.start_fx then AnimpostfxStop(e.start_fx) end
    for _, name in ipairs(e.postfx or {}) do AnimpostfxStop(name) end
    if e.timecycle then ClearTimecycleModifier() end
    if e.blur then SetEntityMotionBlur(ped, false) end
    if e.shake then StopGameplayCamShaking(true) end
    RefreshDrunk() -- back to the alcohol's wobble
    if finished and e.end_fx then
        local name = e.end_fx
        AnimpostfxPlay(name)
        SetTimeout(END_FX_TIME, function()
            if not (Active and Active.effect.start_fx == name) then AnimpostfxStop(name) end
        end)
    end
end

--- Starts an effect for some seconds, replacing the one running
--- @param effect table an effect row
--- @param seconds number
function StartEffect(effect, seconds)
    StopEffect(false)
    local token = {}
    local started = GetGameTimer()
    Active = {effect = effect, ends = started + seconds * 1000, token = token}
    local ped = PlayerPedId()
    if effect.start_fx then AnimpostfxPlay(effect.start_fx) end
    for _, name in ipairs(effect.postfx or {}) do AnimpostfxPlay(name) end
    if effect.timecycle then
        SetTimecycleModifier(effect.timecycle)
        SetTimecycleModifierStrength(effect.strength or 1.0)
    end
    if effect.drunk > 0 then SetPedDrunkness(ped, true, effect.drunk) end
    if effect.blur then SetEntityMotionBlur(ped, true) end

    CreateThread(function()
        local nextShake = started
        -- Shake for shake_time seconds, fading out, or for the whole effect at full strength
        local shakeEnds = effect.shake_time > 0 and started + effect.shake_time * 1000 or nil
        while Active and Active.token == token and GetGameTimer() < Active.ends do
            local now = GetGameTimer()
            if effect.shake and effect.shake_amount > 0 and now >= nextShake and (not shakeEnds or now < shakeEnds) then
                local amount = effect.shake_amount
                if shakeEnds then amount = amount * (1 - (now - started) / (shakeEnds - started)) end
                ShakeGameplayCam(effect.shake, math.max(0.01, amount))
                nextShake = now + SHAKE_EVERY
            end
            Wait(100)
        end
        if Active and Active.token == token then StopEffect(true) end
    end)
end

function EffectRunning()
    return Active ~= nil
end

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    StopEffect(false)
    if DrunkFx then AnimpostfxStop(Config.Drunk.ScreenEffect) end
    SetPedDrunkness(PlayerPedId(), false, 0.0)
end)

exports("GetAlcohol", function() return Alcohol end)
exports("AddAlcohol", AddAlcohol)
exports("SetAlcohol", SetAlcohol)
exports("StopEffect", function() StopEffect(false) end)
