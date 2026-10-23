-- Using a consumable: the server has already taken the item, this plays the animation and applies what it does

Consuming = false

local function clamp(value, min, max)
    return math.max(min, math.min(max, value))
end

--- Adds to an inner core (0 health, 1 stamina), 0 - 100
local function addCore(ped, core, amount)
    if amount == 0 then return end
    SetAttributeCoreValue(ped, core, clamp(GetAttributeCoreValue(ped, core) + amount, 0, 100))
end

--- What comes with each use (each puff when smoking): status, health, stamina, alcohol
function ApplyUse(c)
    local ped = PlayerPedId()
    Config.ApplyStatus(c.status)
    addCore(ped, 1, c.stamina)
    addCore(ped, 0, c.inner_health)
    if c.outer_health ~= 0 then
        local max = GetEntityMaxHealth(ped)
        SetEntityHealth(ped, math.floor(clamp(GetEntityHealth(ped) + c.outer_health, 0, max > 0 and max or 600)))
    end
    if c.alcohol > 0 then AddAlcohol(c.alcohol) end
end

function ApplyCures(c)
    if c.sober then SetAlcohol(0) end
    if c.clear_effects then StopEffect(false) end
end

--- What only comes once it is all used up (every puff taken): gold and the effect
function ApplyRewards(c)
    local ped = PlayerPedId()
    if c.inner_stamina_gold > 0 then EnableAttributeCoreOverpower(ped, 1, c.inner_stamina_gold) end
    if c.outer_stamina_gold > 0 then EnableAttributeOverpower(ped, 1, c.outer_stamina_gold) end
    if c.inner_health_gold > 0 then EnableAttributeCoreOverpower(ped, 0, c.inner_health_gold) end
    if c.outer_health_gold > 0 then EnableAttributeOverpower(ped, 0, c.outer_health_gold) end
    if c.effect then StartEffect(c.effect, c.effect_time) end
end

local function smoking(c)
    local animation = Config.Animations[c.animation or Config.DefaultAnimation]
    return animation and animation.smoke ~= nil
end

RegisterNetEvent("ez_consumables:client:use", function(c)
    CloseInventory()
    Consuming = true
    local smoke = smoking(c)
    PlayConsumeAnimation(c, function(completed)
        if smoke then
            -- Put away early: the puffs taken counted, the reward is only for finishing
            if completed then
                ApplyCures(c)
                ApplyRewards(c)
            end
        else
            -- The item is gone either way, so it always works, even if the animation was cut short.
            -- Cures go first so a sobering drink can still add its own alcohol
            ApplyCures(c)
            ApplyUse(c)
            ApplyRewards(c)
        end
        Consuming = false
        TriggerServerEvent("ez_consumables:server:done")
    end, smoke and function() ApplyUse(c) end or nil)
end)

-- /consumablelevel alcohol | stamina | health, for testing
RegisterCommand("consumablelevel", function(_, args)
    local what = args[1]
    local ped = PlayerPedId()
    if what == "alcohol" then
        print(("Alcohol: %s (drunk above %s, passes out above %s)"):format(Alcohol, Config.Drunk.Drunk, Config.Drunk.PassOut))
    elseif what == "stamina" then
        print("Stamina core: " .. GetAttributeCoreValue(ped, 1))
    elseif what == "health" then
        print(("Health core: %s, health: %s / %s"):format(GetAttributeCoreValue(ped, 0), GetEntityHealth(ped), GetEntityMaxHealth(ped)))
    else
        print("Use: /consumablelevel alcohol | stamina | health")
    end
end, false)
