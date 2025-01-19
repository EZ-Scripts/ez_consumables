Config = {}

Config.AnimationTime = 5000 -- Time in MS for the animation to play


--[[
Functions to add values. This is compatible with VORP & EZ.
Note: VORP does not have a stress system, so it will be ignored.
Note: It is important to multiply the values by 10, as the VORP system is based on 1000.
        Do not worry about changing it for EZ Hud, we use 100 but divide by 10 for the VORP system automatically.
]]
Config.AddHunger = function(hunger)
    TriggerEvent("vorpmetabolism:changeValue", "hunger", hunger*10)
end

Config.AddThirst = function(thirst)
    TriggerEvent("vorpmetabolism:changeValue", "thirst", thirst*10)
end

Config.AddStress = function(stress)
    TriggerEvent("vorpmetabolism:changeValue", "stress", stress*10)
end

-- Items to use
Config.ItemsToUse = {
    --[[["consumable_peach"] = { -- DB NAME
        Hunger = 35, -- Food it gives
        Thirst = 5, -- Water it gives
        Stress = 0, -- Stress it gives
        Stamina = 0, -- Inner Core Stamina effect
        InnerStaminaGold = 0.0, -- Inner Core Stamina Gold overpower
        OuterStaminaGold = 0.0, -- Outer Core Stamina Gold overpower
        InnerHealth = 0, -- Inner Core Health effect
        OuterHealth = 0, -- Outer Core Health effect
        InnerHealthGold = 0.0, -- Inner Core Health Gold overpower
        OuterHealthGold = 100.0, -- Outer Core Health Gold overpower
    },]]

    --
    -- FOODS
    --
    ["consumable_bluegil"] = {
        Hunger = 25,
        Thirst = 0,
        Stress = 5,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_breakfast"] = {
        Hunger = 30,
        Thirst = 0,
        Stress = 5,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 10,
        OuterHealth = 10,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_caramel"] = {
        Hunger = 10,
        Thirst = 0,
        Stress = 5,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_chocolate"] = {
        Hunger = 10,
        Thirst = 0,
        Stress = 5,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_fruitsalad"] = {
        Hunger = 15,
        Thirst = 0,
        Stress = 13,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 10,
        OuterHealth = 7,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_game"] = {
        Hunger = 35,
        Thirst = 0,
        Stress = 5,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 10,
        OuterHealth = 20,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_peach"] = {
        Hunger = 15,
        Thirst = 0,
        Stress = 5,
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_pear"] = {
        Hunger = 15,
        Thirst = 0,
        Stress = 5,
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_salmon"] = {
        Hunger = 30,
        Thirst = 0,
        Stress = 5,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 7,
        OuterHealth = 7,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_kidneybeans_can"] = {
        Hunger = 20,
        Thirst = 0,
        Stress = 5,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 7,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        ItemInteraction = "EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT"
    },
    ["cheesecake"] = {
        Hunger = 20,
        Thirst = 0,
        Stress = 5,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_blueberrypie"] = {
        Hunger = 25,
        Thirst = 0,
        Stress = 5,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_chickenpie"] = {
        Hunger = 30,
        Thirst = 0,
        Stress = 2,
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 10,
        OuterHealth = 10,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_chocolatecake"] = {
        Hunger = 25,
        Thirst = 0,
        Stress = 5,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_cupcake"] = {
        Hunger = 15,
        Thirst = 0,
        Stress = 5,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_donut"] = {
        Hunger = 15,
        Thirst = 0,
        Stress = 5,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_lemoncake"] = {
        Hunger = 20,
        Thirst = 0,
        Stress = 5,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_poundcake"] = {
        Hunger = 20,
        Thirst = 0,
        Stress = 5,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    ["consumable_spongecake"] = {
        Hunger = 20,
        Thirst = 0,
        Stress = 5,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },    

    --
    -- DRINKS
    --
    ["whisky"] = {
        Hunger = 0,
        Thirst = 25,
        Stress = 10,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_whisky_bottle"
    },
    ["wine"] = {
        Hunger = 0,
        Thirst = 30,
        Stress = 8,
        Stamina = 4,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_wine_bottle"
    },
    ["vodka"] = {
        Hunger = 0,
        Thirst = 28,
        Stress = 9,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_wine_bottle2"
    },
    ["beer"] = {
        Hunger = 0,
        Thirst = 20,
        Stress = 6,
        Stamina = 3,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_beer_bottle"
    },
    ["tequila"] = {
        Hunger = 0,
        Thirst = 30,
        Stress = 10,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_tequila_bottle"
    },
    ["tropicalPunchMoonshine"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 10,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    ["wildCiderMoonshine"] = {
        Hunger = 0,
        Thirst = 35,
        Stress = 10,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    ["raspberryale"] = {
        Hunger = 0,
        Thirst = 22,
        Stress = 5,
        Stamina = 3,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_coffee"
    },
    ["consumable_coffee"] = {
        Hunger = 0,
        Thirst = 25,
        Stress = 2,
        Stamina = 8,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_coffee"
    },
    ["consumable_raspberrywater"] = {
        Hunger = 0,
        Thirst = 30,
        Stress = 1,
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_coffee"
    },    

    --
    -- MEDICINES
    --
    ["consumable_medicine"] = {
        Hunger = 0,
        Thirst = 5,
        Stress = 10,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 0.0,
    },

    
}
