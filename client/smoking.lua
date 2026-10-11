-- Smoking and chewing (Config.Animations with smoke = ...), ported from ez_tobacco.
-- The player holds it and takes a puff with a prompt until the puffs run out or they put it away.
-- Each Smokers.<kind>(handle, ped, animation, prop, data, onPuff) returns how many puffs were taken.

Smokers = {}

local function anim(ped, dict, name, duration, flag)
    if not LoadAnimDict(dict) then return end
    TaskPlayAnim(ped, dict, name, 1.0, 1.0, duration or -1, flag or 1, 1, false, false, false, 0, true)
end

local function playing(ped, dict, name)
    return IsEntityPlayingAnim(ped, dict, name, 3)
end

---------------------------------------------------------------- Prompts

local Group = GetRandomIntInRange(0, 0xffffff)
local Prompts = {}

local function makePrompt(key, text)
    local prompt = PromptRegisterBegin()
    PromptSetControlAction(prompt, joaat(key))
    PromptSetText(prompt, CreateVarString(10, "LITERAL_STRING", text))
    PromptSetEnabled(prompt, true)
    PromptSetVisible(prompt, true)
    PromptSetStandardMode(prompt, true)
    PromptSetGroup(prompt, Group)
    PromptRegisterEnd(prompt)
    return prompt
end

CreateThread(function()
    Prompts.use = makePrompt(Config.SmokeKeys.use, T("prompt.puff"))
    Prompts.stop = makePrompt(Config.SmokeKeys.stop, T("prompt.putAway"))
    Prompts.stance = makePrompt(Config.SmokeKeys.stance, T("prompt.stance"))
end)

local function pressed(prompt)
    return PromptHasStandardModeCompleted(prompt)
end

--- Blocks fighting until the handle is done, for animations with blockWeapons
local function blockWeapons(handle, animation)
    if not animation.blockWeapons then return end
    local controls = {}
    for i, name in ipairs(Config.SmokeBlockedControls) do controls[i] = joaat(name) end
    CreateThread(function()
        while not handle.done do
            for _, control in ipairs(controls) do DisableControlAction(0, control, true) end
            Wait(0)
        end
    end)
end

--- The prompt loop every kind shares. s = {puff = fn() -> false if stopped, stance = fn()?, idle = fn()?}
--- Runs until the puffs are used up, Stop is pressed, the player dies or the handle is stopped
local function puffLoop(handle, data, s, onPuff)
    local puffs, uses = 0, data.uses or 1
    PromptSetEnabled(Prompts.stance, s.stance ~= nil)
    PromptSetVisible(Prompts.stance, s.stance ~= nil)
    while puffs < uses and not handle.stopped and not IsEntityDead(PlayerPedId()) do
        if pressed(Prompts.stop) then
            break
        elseif s.stance and pressed(Prompts.stance) then
            s.stance()
        elseif pressed(Prompts.use) then
            if s.puff() == false then break end
            puffs = puffs + 1
            onPuff(puffs)
        else
            if s.idle then s.idle() end
            PromptSetActiveGroupThisFrame(Group, CreateVarString(10, "LITERAL_STRING", T("prompt.usesLeft", data.label or "", uses - puffs)))
        end
        Wait(0)
    end
    return puffs
end

local function useTime(data, animation)
    return data.use_time or animation.useTime or 5000
end

---------------------------------------------------------------- Cigar

local CIGAR_IDLE <const> = {dict = "amb_rest@world_human_smoke_cigar@male_a@base", name = "base"}
local CIGAR_PUFF <const> = {dict = "amb_rest@world_human_smoke_cigar@male_a@idle_b", name = "idle_d"}

function Smokers.cigar(handle, ped, animation, prop, data, onPuff)
    local cigar = prop and AttachProp(ped, prop)
    handle.cleanup = function()
        DeleteProp(cigar)
        ClearPedSecondaryTask(PlayerPedId())
        RemoveAnimDict(CIGAR_IDLE.dict)
        RemoveAnimDict(CIGAR_PUFF.dict)
    end
    blockWeapons(handle, animation)
    anim(ped, CIGAR_IDLE.dict, CIGAR_IDLE.name, -1, 31)
    local time = useTime(data, animation)
    return puffLoop(handle, data, {
        idle = function()
            if not playing(ped, CIGAR_IDLE.dict, CIGAR_IDLE.name) and not playing(ped, CIGAR_PUFF.dict, CIGAR_PUFF.name) then
                anim(ped, CIGAR_IDLE.dict, CIGAR_IDLE.name, -1, 31)
            end
        end,
        puff = function()
            anim(ped, CIGAR_PUFF.dict, CIGAR_PUFF.name, time, 30)
            return SleepUnlessStopped(handle, time)
        end,
    }, onPuff)
end

---------------------------------------------------------------- Cigarette

local CIGARETTE_STANCES <const> = {
    male = {
        {idle = {"amb_rest@world_human_smoking@male_c@base", "base"}, puff = {"amb_rest@world_human_smoking@male_c@idle_a", "idle_a"}},
        {idle = {"amb_rest@world_human_smoking@nervous_stressed@male_b@base", "base"}, puff = {"amb_rest@world_human_smoking@nervous_stressed@male_b@idle_a", "idle_a"}},
        {idle = {"amb_rest@world_human_smoking@male_d@base", "base"}, puff = {"amb_rest@world_human_smoking@male_d@idle_a", "idle_a"}},
        {idle = {"amb_wander@code_human_smoking_wander@male_a@base", "base"}, puff = {"amb_rest@world_human_smoking@male_a@idle_a", "idle_a"}},
    },
    female = {
        {idle = {"amb_rest@world_human_smoking@female_c@base", "base"}, puff = {"amb_rest@world_human_smoking@female_c@idle_a", "idle_a"}},
        {idle = {"amb_rest@world_human_smoking@female_b@base", "base"}, puff = {"amb_rest@world_human_smoking@female_b@idle_a", "idle_a"}},
        {idle = {"amb_rest@world_human_smoking@female_a@base", "base"}, puff = {"amb_rest@world_human_smoking@female_a@idle_a", "idle_a"}},
    },
}
local ORIGIN <const> = {x = 0.0, y = 0.0, z = 0.0}

function Smokers.cigarette(handle, ped, animation, prop, data, onPuff)
    local male = IsPedMale(ped)
    local stances = male and CIGARETTE_STANCES.male or CIGARETTE_STANCES.female
    local stance = 1
    local cigarette = CreateProp(ped, prop and prop.model or "p_cigarette01x", 0.2)
    if not cigarette then return 0 end
    handle.cleanup = function()
        DeleteProp(cigarette)
        ClearPedSecondaryTask(PlayerPedId())
        for _, s in ipairs(stances) do
            RemoveAnimDict(s.idle[1])
            RemoveAnimDict(s.puff[1])
        end
    end
    blockWeapons(handle, animation)
    local function idle() anim(ped, stances[stance].idle[1], stances[stance].idle[2], -1, 30) end

    -- Light up: the cigarette goes from the mouth to the hand and back
    AttachToBone(cigarette, ped, "skel_head", ORIGIN, ORIGIN)
    if male then
        anim(ped, "amb_rest@world_human_smoking@male_c@stand_enter", "enter_back_rf", 9400, 0)
        if not SleepUnlessStopped(handle, 1000) then return 0 end
        AttachToBone(cigarette, ped, "SKEL_R_Finger13", {x = 0.03, y = -0.01, z = 0.0}, {x = 0.0, y = 90.0, z = 0.0})
        if not SleepUnlessStopped(handle, 1000) then return 0 end
        AttachToBone(cigarette, ped, "skel_head", {x = -0.017, y = 0.1, z = -0.01}, {x = 0.0, y = 90.0, z = -90.0})
        if not SleepUnlessStopped(handle, 3000) then return 0 end
        AttachToBone(cigarette, ped, "SKEL_R_Finger13", {x = 0.017, y = -0.01, z = -0.01}, {x = 0.0, y = 120.0, z = 10.0})
        if not SleepUnlessStopped(handle, 1000) then return 0 end
        idle()
        RemoveAnimDict("amb_rest@world_human_smoking@male_c@stand_enter")
        if not SleepUnlessStopped(handle, 1000) then return 0 end
    else
        idle()
        if not SleepUnlessStopped(handle, 1000) then return 0 end
        AttachToBone(cigarette, ped, "SKEL_R_Finger13", {x = 0.01, y = 0.0, z = 0.01}, {x = 0.0, y = -160.0, z = -130.0})
        if not SleepUnlessStopped(handle, 2500) then return 0 end
    end

    local time = useTime(data, animation)
    local puffs = puffLoop(handle, data, {
        stance = function()
            stance = stance % #stances + 1
            idle()
        end,
        puff = function()
            if not SleepUnlessStopped(handle, 500) then return false end
            anim(ped, stances[stance].puff[1], stances[stance].puff[2], -1, 30)
            local ok = SleepUnlessStopped(handle, time)
            idle()
            return ok
        end,
    }, onPuff)

    -- Put it out and flick it away
    if not handle.stopped then
        ClearPedSecondaryTask(ped)
        if male then
            anim(ped, "amb_rest@world_human_smoking@male_a@stand_exit", "exit_back", -1, 1)
            Wait(2800)
            DetachEntity(cigarette, true, true)
            SetEntityVelocity(cigarette, 0.0, 0.0, -1.0)
            Wait(1500)
        else
            anim(ped, "amb_rest@world_human_smoking@female_b@trans", "b_trans_fire_stand_a", -1, 1)
            Wait(3800)
            DetachEntity(cigarette, true, true)
            Wait(800)
        end
        ClearPedTasks(ped)
    end
    return puffs
end

---------------------------------------------------------------- Pipe

local PIPE_TRANS <const> = "amb_wander@code_human_smoking_wander@male_b@trans"
local PIPE_IDLE <const> = {dict = "amb_rest@world_human_smoking@male_b@base", name = "base"}
local PIPE_IDLE2 <const> = {dict = "amb_rest@world_human_smoking@pipe@proper@male_d@wip_base", name = "wip_base"}
local PIPE_PUFF <const> = {dict = "amb_rest@world_human_smoking@male_b@idle_a", name = "idle_a"}

function Smokers.pipe(handle, ped, animation, prop, data, onPuff)
    local pipe = prop and AttachProp(ped, prop)
    handle.cleanup = function()
        DeleteProp(pipe)
        ClearPedSecondaryTask(PlayerPedId())
        for _, dict in ipairs({PIPE_TRANS, PIPE_IDLE.dict, PIPE_IDLE2.dict, PIPE_PUFF.dict}) do RemoveAnimDict(dict) end
    end
    anim(ped, PIPE_TRANS, "nopipe_trans_pipe", -1, 30)
    if not SleepUnlessStopped(handle, 9000) then return 0 end
    blockWeapons(handle, animation)
    local current = PIPE_IDLE
    anim(ped, current.dict, current.name, -1, 31)
    if not SleepUnlessStopped(handle, 3500) then return 0 end

    local time = useTime(data, animation)
    local puffs = puffLoop(handle, data, {
        stance = function()
            current = current == PIPE_IDLE and PIPE_IDLE2 or PIPE_IDLE
            anim(ped, current.dict, current.name, -1, 31)
        end,
        puff = function()
            anim(ped, PIPE_PUFF.dict, PIPE_PUFF.name, -1, 30)
            local ok = SleepUnlessStopped(handle, time)
            anim(ped, current.dict, current.name, -1, 31)
            return ok
        end,
    }, onPuff)

    if not handle.stopped then
        anim(ped, PIPE_TRANS, "pipe_trans_nopipe", -1, 30)
        Wait(6066)
        ClearPedTasks(ped)
    end
    return puffs
end

---------------------------------------------------------------- Chewing tobacco

local CHEW <const> = "amb_misc@world_human_chew_tobacco@"
local CHEW_STANCES <const> = {
    {base = CHEW .. "male_a@base", idles = CHEW .. "male_a@idle_", trans = {CHEW .. "male_a@trans", "a_trans_b", 7333}},
    {base = CHEW .. "male_b@base", idles = CHEW .. "male_b@idle_", trans = {CHEW .. "male_b@trans", "b_trans_a", 5833}},
}
-- The nine chews of each stance: {idle dict letter, anim}
local CHEWS <const> = {{"a", "idle_a"}, {"a", "idle_b"}, {"a", "idle_c"}, {"b", "idle_d"}, {"b", "idle_e"}, {"b", "idle_f"}, {"d", "idle_j"}, {"d", "idle_k"}, {"d", "idle_l"}}

function Smokers.chew(handle, ped, animation, prop, data, onPuff)
    local stance = 1
    local tin
    handle.cleanup = function()
        DeleteProp(tin)
        ClearPedSecondaryTask(PlayerPedId())
        RemoveAnimDict(CHEW .. "male_a@stand_enter")
        for _, s in ipairs(CHEW_STANCES) do
            RemoveAnimDict(s.base)
            RemoveAnimDict(s.trans[1])
            for _, letter in ipairs({"a", "b", "d"}) do RemoveAnimDict(s.idles .. letter) end
        end
    end
    blockWeapons(handle, animation)

    -- Take a pinch from the tin
    anim(ped, CHEW .. "male_a@stand_enter", "enter_back", -1, 30)
    if not SleepUnlessStopped(handle, 2500) then return 0 end
    tin = CreateProp(ped, prop and prop.model or "s_tobaccotin01x", 0.2)
    if tin then AttachToBone(tin, ped, "SKEL_R_Finger13", {x = 0.0, y = -0.05, z = 0.02}, {x = 30.0, y = 180.0, z = 0.0}) end
    if not SleepUnlessStopped(handle, 6000) then return 0 end
    DeleteProp(tin)
    tin = nil
    anim(ped, CHEW_STANCES[1].base, "base", -1, 31)
    if not SleepUnlessStopped(handle, 3500) then return 0 end

    local puffs = puffLoop(handle, data, {
        idle = function()
            local base = CHEW_STANCES[stance].base
            if not playing(ped, base, "base") then anim(ped, base, "base", -1, 31) end
        end,
        stance = function()
            local trans = CHEW_STANCES[stance].trans
            anim(ped, trans[1], trans[2], -1, 30)
            SleepUnlessStopped(handle, trans[3])
            stance = stance % #CHEW_STANCES + 1
            anim(ped, CHEW_STANCES[stance].base, "base", -1, 30)
        end,
        puff = function()
            local chew = CHEWS[math.random(#CHEWS)]
            local dict = CHEW_STANCES[stance].idles .. chew[1]
            if not LoadAnimDict(dict) then return true end
            -- With a set time per puff the chew is cut to it, otherwise it plays out
            local length = data.use_time or math.floor(GetAnimDuration(dict, chew[2]) * 1000)
            anim(ped, dict, chew[2], -1, 30)
            local ok = SleepUnlessStopped(handle, length)
            anim(ped, CHEW_STANCES[stance].base, "base", -1, 31)
            return ok
        end,
    }, onPuff)

    if not handle.stopped then
        anim(ped, CHEW .. "male_b@idle_b", "idle_d", 5500, 30)
        Wait(5500)
        ClearPedTasks(ped)
    end
    return puffs
end
