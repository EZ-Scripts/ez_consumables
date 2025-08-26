local alcoholCount = 0
local effectActive = false
local CoolDown = {}

local function loadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(100)
    end
end

-- Drunkness
Citizen.CreateThread(function()
    while true do
        Wait(10)
        if alcoholCount > 0 then
            Wait(0)
            alcoholCount = alcoholCount -1
            if Config.Debug == true then
                print("alcohol count: "..alcoholCount)
            end
            if alcoholCount > Config.Drunk.PassOut then
                loadAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
				TaskPlayAnim(PlayerPedId(), "amb_misc@world_human_vomit@male_a@idle_b", "idle_f", 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
				RemoveAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
                Wait(10000)
                TriggerEvent('ez_consumables:client:cancelemote')
                TriggerEvent('ez_consumables:client:sleep')
                Wait(30000)
                TriggerEvent('ez_consumables:client:cancelemote')
			elseif alcoholCount > Config.Drunk.Drunk then
				Citizen.InvokeNative(0x406CCF555B04FAD3 , PlayerPedId(), 1, 0.95) --drunk
				if effectActive == false then
					AnimpostfxPlay("PlayerDrunk01") -- start screen effect
					effectActive = true
				end
				Wait(2000)
            else
                Citizen.InvokeNative(0x406CCF555B04FAD3 , PlayerPedId(), 1, 0.0) --not drunk
                if Config.Debug or effectActive == true then
                    AnimpostfxStop("PlayerDrunk01") -- stop screen effect
                    effectActive = false
                end
				Wait(5000)
            end
        else
            Wait(2000)
        end
    end
end)

RegisterNetEvent('ez_consumables:client:cancelemote', function()
    local ped = PlayerPedId()
    ClearPedTasks(ped)
    SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
end)

RegisterNetEvent('ez_consumables:client:sleep', function()
    -- Fade out the screen
    loadAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_b')
    TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_sleep_ground@arm@male_b@idle_b', 'idle_f', 8.0, -8.0, -1, 1, 0, true, false, false)
    RemoveAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_b')
    Wait(10000)
    AnimpostfxPlay('PlayerDrunk01_PassOut')
    DoScreenFadeOut(10000)  -- 10 seconds fade-out
    Wait(10000)
    -- Fade in the screen
    AnimpostfxPlay('PlayerWakeUpDrunk')
    DoScreenFadeIn(10000)  -- 10 seconds fade-in 
    AnimpostfxPlay('Title_Gen_daylater')
    Wait(10000)
	alcoholCount = Config.Drunk.Drunk + 1
    AnimpostfxStop('PlayerWakeUpDrunk')
	AnimpostfxStop('Title_Gen_daylater')
	ClearPedTasks(PlayerPedId())
    Citizen.InvokeNative(0x58F7DB5BD8FA2288, PlayerPedId())
end)

RegisterNetEvent("ez_consume:consume", function(status, stamina, innerstaminagold, outerstaminagold, innerhealth, innerhealthgold, outerhealth, outerhealthgold, alcoholLevel)
    stamina = tonumber(stamina) or 0
    innerstaminagold = tonumber(innerstaminagold) or 0
    outerstaminagold = tonumber(outerstaminagold) or 0
    innerhealth = tonumber(innerhealth) or 0
    innerhealthgold = tonumber(innerhealthgold) or 0
	outerhealth = tonumber(outerhealth) or 0
    outerhealthgold = tonumber(outerhealthgold) or 0
	local ped = PlayerPedId()

	Config.ExecuteStatus(status)

	if alcoholLevel then
		alcoholCount = alcoholCount + alcoholLevel
	end

	if (stamina ~= 0) then
		local s = Citizen.InvokeNative(0x36731AC041289BB1, ped, 1) --ACTUAL STAMINA CORE GETTER
		if type(s) == "number" then
			--print("stamina before: "..s)
		else
			s = 0
		end
		s = s + tonumber(stamina)

		if (s > 100) then
		    s = 100
		end
		Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, s)
	end

	if (innerhealth ~= 0)then
		local health = Citizen.InvokeNative(0x36731AC041289BB1, ped, 0) --ACTUAL HEALTH CORE GETTER
		if type(health) == "number" then
			health = health + tonumber(innerhealth)

			if (health > 100) then
				health = 100
			end
			Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, health)
		end
	end

	if (outerhealth ~= 0)then -- Health outercore is between 100 and 600
		local health = GetEntityHealth(ped)
		if type(health) == "number" then
			health = health + tonumber(outerhealth)

			if (health > 600) then
				health = 600
			end
			SetEntityHealth(ped, health)
		end
	end

	--GOLDS
	if (innerstaminagold ~= 0) then
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, innerstaminagold, true)
	end
	if (outerstaminagold ~= 0) then
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, outerstaminagold, true)
	end
	if (innerhealthgold ~= 0) then
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, innerhealthgold, true)
	end
	if (outerhealthgold ~= 0) then
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, outerhealthgold, true)
	end
end)

RegisterCommand("getlevelconsumable", function(source, args)
	local type = args[1]
	if type == nil then
		print("Please specify a consumable type.")
		return
	end
	if type == "alcohol" then
		print("Alcohol level: " .. alcoholCount)
	elseif type == "stamina" then
		local stamina = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 1) --ACTUAL STAMINA CORE GETTER
		if type(stamina) == "number" then
			print("Stamina level: " .. stamina)
		else
			print("Stamina level: 0")
		end
	elseif type == "health" then
		local health = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 0) --ACTUAL HEALTH CORE GETTER
		if type(health) == "number" then
			print("Health level: " .. health)
		else
			print("Health level: 0")
		end
	else
		print("Invalid consumable type. Use 'alcohol', 'stamina', or 'health'.")
	end
end, false)

RegisterNetEvent("ez_consume:useitem", function(item, label)
	local v = Config.ItemsToUse[item]
	if v == nil then
		return
	end
	if CoolDown[item] ~= nil then
		TriggerEvent("vorp:TipRight", "You need to wait ".. CoolDown[item] .." seconds before using this item again.", 5000)
		return
	end
	if v.CoolDown then
		TriggerServerEvent("ez_consume:removeItem", item)
		TriggerEvent("vorp:TipRight", "You used a "..label, 5000)
		CoolDown[item] = v.CoolDown
		Citizen.CreateThread(function()
			while CoolDown[item] and CoolDown[item] > 0 do
				CoolDown[item] = CoolDown[item] - 1
				Wait(1000)
			end
			CoolDown[item] = nil
		end)
	end
	if v.Animation ~= nil and Config.AnimationRun == "vorp_animations" then
		if Animations == nil then
			Animations = exports.vorp_animations.initiate()
		end
		Animations.playAnimation(v.Animation, v.AnimationTime or Config.AnimationTime or 8000)
		Wait(v.AnimationTime or Config.AnimationTime or 8000)
		Animations.endAnimation(v.Animation)
		TriggerEvent("ez_consume:consume", v.Status, v.Stamina, v.InnerStaminaGold, v.OuterStaminaGold, v.InnerHealth, v.InnerHealthGold, v.OuterHealth, v.OuterHealthGold, v.AlcoholLevel)
	elseif Config.AnimationRun == "ez_consumables" and v.Animation ~= nil and Config.Animations[v.Animation] then
		Config.Animations[v.Animation](v, function(success)
			if success then
				TriggerEvent("ez_consume:consume", v.Status, v.Stamina, v.InnerStaminaGold, v.OuterStaminaGold, v.InnerHealth, v.InnerHealthGold, v.OuterHealth, v.OuterHealthGold, v.AlcoholLevel)
			end
		end)
	else
		if v.ItemInteraction ~= nil then
			TaskItemInteraction(PlayerPedId(), nil, GetHashKey(v.ItemInteraction), true, 0, 0)
		else
    		TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
		end
		ForcePedAiAndAnimationUpdate(PlayerPedId(), true, true)
		TriggerEvent("ez_consume:consume", v.Status, v.Stamina, v.InnerStaminaGold, v.OuterStaminaGold, v.InnerHealth, v.InnerHealthGold, v.OuterHealth, v.OuterHealthGold, v.AlcoholLevel)
	end
end)