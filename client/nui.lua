-- Bridge between the admin panel (html/) and the server, plus previews on the admin

AdminOpen = false

local function settings()
    return {image = Config.ItemImage, pageSize = Config.PageSize}
end

local function closePanel()
    if not AdminOpen then return end
    AdminOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({action = "close"})
    TriggerServerEvent("ez_consumables:server:adminClose")
end

RegisterNetEvent("ez_consumables:client:admin", function(data)
    AdminOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({action = "admin", data = data, settings = settings(), lang = Lang.admin})
end)

RegisterNetEvent("ez_consumables:client:adminPatch", function(patch, select)
    if AdminOpen then SendNUIMessage({action = "adminPatch", patch = patch, select = select}) end
end)

RegisterNetEvent("ez_consumables:client:adminHistory", function(result)
    if AdminOpen then SendNUIMessage({action = "history", result = result}) end
end)

RegisterNetEvent("ez_consumables:client:adminToast", function(text, ok)
    if AdminOpen then SendNUIMessage({action = "toast", text = text, ok = ok}) end
end)

RegisterNUICallback("close", function(_, cb)
    cb("ok")
    closePanel()
end)

RegisterNUICallback("admin", function(data, cb)
    cb("ok")
    if not AdminOpen or type(data) ~= "table" or type(data.action) ~= "string" then return end
    TriggerServerEvent("ez_consumables:server:admin", data.action, data.payload)
end)

--- The window has no copy of the panel data to reuse: ask for all of it
RegisterNUICallback("adminResync", function(_, cb)
    cb("ok")
    if AdminOpen then TriggerServerEvent("ez_consumables:server:adminResync") end
end)

---------------------------------------------------------------- Preview
-- The panel hides and the admin sees the animation / effect on themselves. The panel comes back when it is over,
-- or straight away on the preview key. Nothing is used up and no stats change

local Previewing = false

--- The bar at the bottom while previewing. seconds = show a countdown
local function previewBar(text, seconds)
    SendNUIMessage({action = "previewBar", text = text, key = T("prompt.stop"), seconds = seconds})
end

local function numberOr(value, default)
    value = tonumber(value)
    if not value or value ~= value then return default end
    return value
end

--- The effect the panel sent, with every field the effect code reads
local function previewEffect(e)
    if type(e) ~= "table" then return nil end
    local postfx = {}
    for _, name in ipairs(type(e.postfx) == "table" and e.postfx or {}) do
        if type(name) == "string" and name ~= "" then postfx[#postfx + 1] = name end
    end
    local function name(value) return type(value) == "string" and value ~= "" and value or nil end
    return {
        label = name(e.label) or "?",
        postfx = postfx, start_fx = name(e.start_fx), end_fx = name(e.end_fx), timecycle = name(e.timecycle),
        strength = numberOr(e.strength, 1.0), drunk = numberOr(e.drunk, 0.0),
        shake = name(e.shake), shake_amount = numberOr(e.shake_amount, 0.0), shake_time = numberOr(e.shake_time, 0),
        blur = e.blur == true,
    }
end

local function previewProp(prop)
    if type(prop) ~= "table" then return nil end
    local function vec(v)
        if type(v) ~= "table" then return nil end
        local x, y, z = tonumber(v.x), tonumber(v.y), tonumber(v.z)
        if not x or not y or not z then return nil end
        return {x = x, y = y, z = z}
    end
    local function name(value) return type(value) == "string" and value ~= "" and value or nil end
    return {model = name(prop.model), bone = name(prop.bone), offset = vec(prop.offset), rotation = vec(prop.rotation)}
end

RegisterNUICallback("preview", function(data, cb)
    cb("ok")
    if not AdminOpen or Previewing or Consuming or type(data) ~= "table" then return end
    local effect = previewEffect(data.effect)
    local seconds = math.max(1, math.min(3600, numberOr(data.seconds, Config.DefaultEffectTime)))
    local animation
    if data.kind == "consumable" then
        animation = {
            animation = Config.Animations[data.animation] and data.animation or nil,
            interaction = type(data.interaction) == "string" and data.interaction ~= "" and data.interaction or nil,
            prop = previewProp(data.prop),
            label = type(data.label) == "string" and data.label or "?",
            uses = math.floor(math.max(1, math.min(50, numberOr(data.uses, 1)))),
            use_time = tonumber(data.use_time) and math.max(500, math.min(60000, tonumber(data.use_time))) or nil,
        }
    elseif data.kind ~= "effect" or not effect then
        return
    end

    Previewing = true
    SetNuiFocus(false, false)
    SendNUIMessage({action = "hide"})
    local key = joaat(Config.PreviewKey)
    local stopped = false

    CreateThread(function()
        local label = type(data.label) == "string" and data.label ~= "" and data.label or "?"
        -- The panel draws the key hint, so the key can be blocked for the game (Backspace would open the pause menu)
        local function stopPressed()
            DisableControlAction(0, key, true)
            if IsDisabledControlJustPressed(0, key) or IsEntityDead(PlayerPedId()) or not AdminOpen then stopped = true end
            return stopped
        end

        if animation then
            previewBar(T("prompt.previewing", label))
            local done = false
            local handle = PlayConsumeAnimation(animation, function() done = true end)
            while not done do
                if stopPressed() then handle.stop() end
                Wait(0)
            end
        end
        if effect and not stopped then
            previewBar(T("prompt.previewing", effect.label), seconds)
            StartEffect(effect, seconds)
            while EffectRunning() and not stopPressed() do Wait(0) end
            StopEffect(not stopped)
        end

        Previewing = false
        SendNUIMessage({action = "previewBar"})
        if AdminOpen then
            SetNuiFocus(true, true)
            SendNUIMessage({action = "show"})
        end
    end)
end)

AddEventHandler("onResourceStop", function(resource)
    if resource ~= GetCurrentResourceName() then return end
    if AdminOpen then SetNuiFocus(false, false) end
end)
