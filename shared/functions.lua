--- What each number can be: {min, max, step}. The server holds saves to min..max and the panel's sliders use all
--- three (step is how far a slider moves, typed values can be finer)
Limits = {
    consumables = {
        hunger = {-100, 100, 1},
        thirst = {-100, 100, 1},
        stress = {-100, 100, 1}, -- relief: 10 takes away 10 stress
        metabolism = {-1000, 1000, 10},
        stamina = {-100, 100, 1},
        inner_health = {-100, 100, 1},
        outer_health = {-600, 600, 5},
        inner_health_gold = {0, 2000, 10},
        outer_health_gold = {0, 2000, 10},
        inner_stamina_gold = {0, 2000, 10},
        outer_stamina_gold = {0, 2000, 10},
        alcohol = {0, 500, 5},
    },
    effects = {
        strength = {0, 1, 0.05},
        drunk = {0, 1, 0.05},
        shake_amount = {0, 2, 0.05},
    },
}

function DebugPrint(name, info)
    if Config.Debug then print("^5Debug^7: ^2" .. tostring(name) .. "^7: '^6" .. tostring(info) .. "^7'") end
end

--- Text from Lang, with %s filled in
--- @param key string Dotted path, e.g. "notify.busy"
function T(key, ...)
    local value = Lang
    for part in key:gmatch("[^%.]+") do
        value = type(value) == "table" and value[part] or nil
    end
    if type(value) ~= "string" then return key end
    if select("#", ...) == 0 then return value end
    return value:format(...)
end

--- A number between min and max (clamped), or nil if it isn't a number
function Number(value, min, max)
    value = tonumber(value)
    if not value or value ~= value or value == math.huge or value == -math.huge then return nil end
    if min and value < min then value = min end
    if max and value > max then value = max end
    return value
end

--- Whole number between min and max, or nil
function WholeNumber(value, min, max)
    value = tonumber(value)
    if not value or value ~= value or value == math.huge or value == -math.huge then return nil end
    value = math.floor(value)
    if (min and value < min) or (max and value > max) then return nil end
    return value
end

function FindKind(key)
    for _, kind in ipairs(Config.Kinds) do
        if kind.key == key then return kind end
    end
    return nil
end

--- The prop a consumable holds: its own fields over the animation's. nil when there is no model
--- @param animation table Config.Animations entry
--- @param own table? the consumable's prop {model, bone, offset, rotation}
function MergeProp(animation, own)
    local base = animation and animation.prop
    if not base and not (own and own.model) then return nil end
    base, own = base or {}, own or {}
    local prop = {
        model = own.model or base.model,
        bone = own.bone or base.bone or "SKEL_R_HAND",
        offset = own.offset or base.offset or {x = 0.0, y = 0.0, z = 0.0},
        rotation = own.rotation or base.rotation or {x = 0.0, y = 0.0, z = 0.0},
    }
    if not prop.model then return nil end
    return prop
end
