-- Using a consumable. The server checks everything and takes the item; the client plays the animation and applies it

local Registered = {} -- [item name] = true, usable callbacks this resource added to vorp_inventory
local Cooldowns = {} -- [charId] = {[item name] = os.time() it ends}
local Busy = {} -- [src] = GetGameTimer() the current consumable is done by

local BUSY_EXTRA <const> = 2000 -- ms on top of the animation, for lag
local BUSY_SMOKING <const> = 15 * 60 * 1000 -- a cigar can be held as long as the player likes; this frees them if the client never says

--- What the client needs to play and apply a consumable
local function clientPayload(c)
    local effect = c.effect and Data.effects[c.effect]
    return {
        item = c.item,
        label = LabelOf(c.item),
        animation = c.animation,
        interaction = c.interaction,
        prop = c.prop,
        status = {hunger = c.hunger, thirst = c.thirst, stress = c.stress, metabolism = c.metabolism},
        stamina = c.stamina,
        inner_health = c.inner_health,
        outer_health = c.outer_health,
        inner_health_gold = c.inner_health_gold,
        outer_health_gold = c.outer_health_gold,
        inner_stamina_gold = c.inner_stamina_gold,
        outer_stamina_gold = c.outer_stamina_gold,
        alcohol = c.alcohol,
        clear_effects = c.clear_effects,
        sober = c.sober,
        effect = effect and effect.enabled and effect or nil,
        effect_time = c.effect_time or (effect and effect.duration) or Config.DefaultEffectTime,
        uses = c.uses,
        use_time = c.use_time,
    }
end

local function useConsumable(src, name, used)
    if not Ready then return Notify(src, T("notify.loading")) end
    local c = ByItem[name]
    if not c or not c.enabled then return Notify(src, T("notify.cantUse")) end
    local identity = GetIdentity(src)
    if not identity then return end

    local now = GetGameTimer()
    if Busy[src] and Busy[src] > now then return Notify(src, T("notify.busy")) end
    local cooldowns = Cooldowns[identity.charId]
    local left = cooldowns and cooldowns[name] and cooldowns[name] - os.time() or 0
    if left > 0 then return Notify(src, T("notify.cooldown", left)) end
    for _, need in ipairs(c.requires) do
        if ItemCount(src, need.name) < need.count then return Notify(src, T("notify.needs", need.count, LabelOf(need.name))) end
    end
    for _, give in ipairs(c.gives) do
        if not CanCarryItem(src, give.name, give.count) then return Notify(src, T("notify.tooFull")) end
    end

    if not TakeUsedItem(src, name, used and used.id) then return end
    local kind = FindKind(c.kind) or FindKind("other")
    for _, give in ipairs(c.gives) do
        if GiveItem(src, give.name, give.count) then
            if kind.gives then Notify(src, T("notify.received", give.count, LabelOf(give.name))) end
        else
            print(("^3[ez_consumables] Could not give %sx %s to %s for using %s^7"):format(give.count, give.name, src, name))
        end
    end
    if c.cooldown > 0 then
        Cooldowns[identity.charId] = cooldowns or {}
        Cooldowns[identity.charId][name] = os.time() + c.cooldown
    end

    local animation = Config.Animations[c.animation or Config.DefaultAnimation] or {}
    Busy[src] = now + (animation.smoke and BUSY_SMOKING or (animation.duration or 0) + BUSY_EXTRA)
    TriggerClientEvent("ez_consumables:client:use", src, clientPayload(c))
    Notify(src, (kind.used or "%s"):format(LabelOf(name)))
end

-- The client finished the animation
RegisterNetEvent("ez_consumables:server:done", function()
    Busy[source] = nil
end)

AddEventHandler("playerDropped", function()
    Busy[source] = nil
end)

---------------------------------------------------------------- Usable items

--- Registers every consumable's item with vorp_inventory, and drops ones that are gone
function SyncUsableItems()
    for name in pairs(Registered) do
        if not ByItem[name] then
            UnregisterUsableItem(name)
            Registered[name] = nil
        end
    end
    for name in pairs(ByItem) do
        if not Registered[name] then
            Registered[name] = true
            RegisterUsableItem(name, function(src, used) useConsumable(src, name, used) end)
        end
    end
end

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    for name in pairs(Registered) do UnregisterUsableItem(name) end
end)

CreateThread(function()
    EnsureTables()
    PruneHistory()
    LoadItemList()
    local counts = LoadAll()
    SyncUsableItems()
    Ready = true
    print(("^2[ez_consumables]^7 Loaded %s consumables and %s effects"):format(counts.consumables, counts.effects))
    if counts.consumables == 0 then
        print("^3[ez_consumables]^7 No consumables yet. Run ^5ez_consumables_migrate^7 once to bring over the old config")
    end
end)
