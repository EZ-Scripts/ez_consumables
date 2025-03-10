Config = {}

Config.Debug = false -- Enable debug messages

Config.AnimationTime = 5000 -- Time in MS for the animation to play

Config.Drunk = {
    Drunk = 100,
    PassOut = 300,
}
--[[
Functions to add values. This is compatible with VORP & EZ.
Note: VORP does not have a stress system, so it will be ignored.
Note: It is important to multiply the values by 10, as the VORP system is based on 1000.
        Do not worry about changing it for EZ Hud, we use 100 but divide by 10 for the VORP system automatically.
]]

Config.ExecuteStatus = function(status)
    for k, v in pairs(status) do
        if k == "Stress" then
            v = v * -1
        end
        TriggerEvent("vorpmetabolism:changeValue", k, v*10)
    end
end

--[[ 
Example Item Format:
item_name = { -- Database Name (DB NAME)
    Status = {
        Hunger = 35,        -- Amount of food it restores (0 to 100)
        Thirst = 5,         -- Amount of thirst it restores (0 to 100)
        Stress = 0,         -- Amount of stress it reduces (0 to 100)
        Metabolism = 10,    -- Affects body weight (-1000 to 1000, where -1000 is skinny, 0 is normal, and 1000 is fat)
    },
    Stamina = 0,            -- Affects Stamina regeneration
    InnerStaminaGold = 0.0, -- Inner Core Stamina Gold overpower
    OuterStaminaGold = 0.0, -- Outer Core Stamina Gold overpower
    InnerHealth = 0,        -- Inner Core Health effect
    OuterHealth = 0,        -- Outer Core Health effect
    InnerHealthGold = 0.0,  -- Inner Core Health Gold overpower
    OuterHealthGold = 100.0,-- Outer Core Health Gold overpower
    Animation = "drink_whisky_bottle", -- Animation when consuming the item (optional)
    ItemInteraction = "EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT" -- Specific interaction for the item (optional)
},
]]

-- Items to use
Config.ItemsToUse = {
    --
    -- FOODS
    --
    consumable_bluegil = {
        Status = {
            Hunger = 25,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_breakfast = {
        Status = {
            Hunger = 30,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 10,
        OuterHealth = 10,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_caramel = {
        Status = {
            Hunger = 10,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(30, 50), -- Fatty
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_chocolate = {
        Status = {
            Hunger = 10,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(30, 50), -- Fatty
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_fruitsalad = {
        Status = {
            Hunger = 15,
            Thirst = 0,
            Stress = 13,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 10,
        OuterHealth = 7,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_game = {
        Status = {
            Hunger = 35,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(-40, -10), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 10,
        OuterHealth = 20,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_peach = {
        Status = {
            Hunger = 15,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_salmon = {
        Status = {
            Hunger = 30,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 7,
        OuterHealth = 7,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    cheesecake = {
        Status = {
            Hunger = 20,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(40, 70), -- Fatty
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_pear = {
        Status = {
            Hunger = 15,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_kidneybeans_can = {
        Status = {
            Hunger = 20,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(-80, -1), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 7,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        ItemInteraction = "EAT_CANNED_FOOD_CYLINDER@D8-2_H10-5_QUICK_LEFT"
    },
    consumable_blueberrypie = {
        Status = {
            Hunger = 25,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_chickenpie = {
        Status = {
            Hunger = 30,
            Thirst = 0,
            Stress = 2,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 10,
        OuterHealth = 10,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_chocolatecake = {
        Status = {
            Hunger = 25,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_cupcake = {
        Status = {
            Hunger = 15,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_donut = {
        Status = {
            Hunger = 15,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_lemoncake = {
        Status = {
            Hunger = 20,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_poundcake = {
        Status = {
            Hunger = 20,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_spongecake = {
        Status = {
            Hunger = 20,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(1, 80), -- Fatty
        },
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
    whisky = {
        Status = {
            Hunger = 0,
            Thirst = 25,
            Stress = 10,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 30,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_whisky_bottle"
    },
    wine = {
        Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 8,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 25,
        Stamina = 4,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_wine_bottle"
    },
    vodka = {
        Status = {
            Hunger = 0,
            Thirst = 28,
            Stress = 15,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 35,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_wine_bottle2"
    },
    beer = {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 6,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 20,
        Stamina = 3,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_beer_bottle"
    },
    tequila = {
        Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 10,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 40,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_tequila_bottle"
    },
    tropicalPunchMoonshine = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 45,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    wildCiderMoonshine = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 45,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    raspberryale = {
        Status = {
            Hunger = 0,
            Thirst = 22,
            Stress = 5,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 3,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_coffee"
    },
    consumable_coffee = {
        Status = {
            Hunger = 0,
            Thirst = 25,
            Stress = 2,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 8,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_coffee"
    },
    consumable_raspberrywater = {
        Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 1,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_coffee"
    },
    consumable_water = {
        Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 1,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_coffee",
        ItemReturn = "emptywaterbottle" -- or "glassbottle" if you want to be more generic
    },

    --
    -- MEDICINES
    --
    ["consumable_medicine"] = {
        Status = {
            Hunger = 0,
            Thirst = 5,
            Stress = 10,
            Metabolism = 0,
        },
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 0.0,
    },
}
