RegisterNetEvent("ez_consume:consume", function(status, stamina, innerstaminagold, outerstaminagold, innerhealth, innerhealthgold, outerhealth, outerhealthgold)
    stamina = tonumber(stamina) or 0
    innerstaminagold = tonumber(innerstaminagold) or 0
    outerstaminagold = tonumber(outerstaminagold) or 0
    innerhealth = tonumber(innerhealth) or 0
    innerhealthgold = tonumber(innerhealthgold) or 0
	outerhealth = tonumber(outerhealth) or 0
    outerhealthgold = tonumber(outerhealthgold) or 0
	local ped = PlayerPedId()

	Config.ExecuteStatus(status)

	if (stamina ~= 0) then
		local s = Citizen.InvokeNative(0x36731AC041289BB1, ped, 1) --ACTUAL STAMINA CORE GETTER
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

RegisterNetEvent("ez_consume:useitem", function(item)
	local v = Config.ItemsToUse[item]
	if v.Animation ~= nil then
		local Animations = exports.vorp_animations.initiate()
		Animations.playAnimation(v.Animation, Config.AnimationTime)
	else
		if v.ItemInteraction ~= nil then
			TaskItemInteraction(PlayerPedId(), nil, GetHashKey(v.ItemInteraction), true, 0, 0)
		else
    		TaskItemInteraction(PlayerPedId(), nil, GetHashKey("EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND"), true, 0, 0)
		end
		Citizen.InvokeNative(0x2208438012482A1A, PlayerPedId(), true, true)
	end
	TriggerEvent("ez_consume:consume", v.Status, v.Stamina, v.InnerStaminaGold, v.OuterStaminaGold, v.InnerHealth, v.InnerHealthGold, v.OuterHealth, v.OuterHealthGold)
end)