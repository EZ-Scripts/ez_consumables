Config = {}

Config.Debug = false -- Enable debug messages

Config.AnimationTime = 5000 -- Time in MS for the animation to play

Config.Drunk = {
    Drunk = 100,
    PassOut = 350,
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
    AlcoholLevel = 0,      -- Alcohol level (0 to 100)
    InnerHealthGold = 0.0,  -- Inner Core Health Gold overpower
    OuterHealthGold = 100.0,-- Outer Core Health Gold overpower
    CoolDown = 0,         -- Cooldown time in seconds (optional)
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
    consumable_venison = {
        Status = {
            Hunger = 15,
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
    consumable_steak = {
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
    consumable_porkchop = {
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
    consumable_bacon = {
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
    consumable_mutton = {
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
   
    consumable_bird = {
        Status = {
            Hunger = 19,
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
    consumable_friedchicken = {
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
    consumable_stringymeat = {
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
    consumable_biggamechop = {
        Status = {
            Hunger = 30,
            Thirst = -15,
            Stress = 5,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_herptile = {
        Status = {
            Hunger = 22,
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
    consumable_gamemeatjerky = {
        Status = {
            Hunger = 18,
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
    consumable_boiledegg = {
        Status = {
            Hunger = 10,
            Thirst = -3,
            Stress = 5,
            Metabolism = math.random(1000,1000),
        },
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_heartcookie = {
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
    consumable_bread = {
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
    consumable_caramel = {
        Status = {
            Hunger = 10,
            Thirst = 0,
            Stress = 18,
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
            Stress = 15,
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
            Stress = 5,
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
            Thirst = 10,
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
            Metabolism = math.random(-1000, -999), -- Healthy
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
            Hunger = 19,
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
            Stress = 5,
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
    consumable_veggiestew = {
        Status = {
            Hunger = 25,
            Thirst = 20,
            Stress = 10,
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
    consumable_veggies = {
        Status = {
            Hunger = 25,
            Thirst = 0,
            Stress = 8,
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
    consumable_pretzel = {
        Status = {
            Hunger =18,
            Thirst = 0,
            Stress = 8,
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
    consumable_pickle = {
        Status = {
            Hunger =15,
            Thirst = 0,
            Stress = 8,
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
    consumable_lemondrops = {
        Status = {
            Hunger =8,
            Thirst = 0,
            Stress = 10,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_meat_greavy = {
        Status = {
            Hunger = 20,
            Thirst = 20,
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
    consumable_steakpie = {
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
    Red_Raspberry = {
        Status = {
            Hunger = 5,
            Thirst = 0,
            Stress = 8,
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
    consumable_raspberryjello = {
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
    consumable_spaghetti_meatballs = {
        Status = {
            Hunger = 45,
            Thirst = 0,
            Stress = 15,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_peachcobbler = {
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
    consumable_crablegs = {
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
    consumable_cracker = {
        Status = {
            Hunger = 8,
            Thirst = 0,
            Stress = 4,
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

    Consumable_lemondrops = {
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

    consumable_breakfast = {
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
    consumable_frostedandglazed = {
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
    consumable_wuwamen = {
        Status = {
            Hunger = 40,
            Thirst = 20,
            Stress = 10,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 0,
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
            Thirst = 20,
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
            Stress = 10,
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
            Stress = 10,
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
            Stress = 10,
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
    consumable_creamcoffee = {
        Status = {
            Hunger = 0,
            Thirst = 25,
            Stress = 10,
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
    consumable_ginsengtea = {
        Status = {
            Hunger = 0,
            Thirst = 25,
            Stress = 5,
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
            Thirst = 35,
            Stress = 5,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 100,
        OuterStaminaGold = 100,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_coffee",
        ItemReturn = "emptywaterbottle" -- or "glassbottle" if you want to be more generic
    },
    consumable_blackberrywater = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 5,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 100,
        OuterStaminaGold = 100,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_coffee",
        ItemReturn = "emptywaterbottle" -- or "glassbottle" if you want to be more generic

    },
    consumable_water = {
        Status = {
            Hunger = 0,
            Thirst = 15,
            Stress = 5,
            Metabolism = math.random(-10, 0), -- Healthy
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
    ["medical_morphine"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 100,
            Metabolism = 0,
        },
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 100.0,
    },
    ["medical_tylenol"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 0,
            Metabolism = 0,
        },
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 100,
        OuterHealth = 30,
        InnerHealthGold = 0.0,
        OuterHealthGold = 0.0,
    },
    ["medical_cocainegum"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 0,
            Metabolism = 0,
        },
        CoolDown = 90,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 100.0,
    },
    ["medical_octavio"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 0,
            Metabolism = 0,
        },
        Stamina = 100,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 100,
        OuterHealth = 100,
        InnerHealthGold = 0.0,
        OuterHealthGold = 0.0,
    },
    ["medical_tankertonic"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 0,
            Metabolism = -500, -- Healthy,
        },
        Stamina = 50,
        InnerStaminaGold = 50.0,
        OuterStaminaGold = 50.0,
        InnerHealth = 100,
        OuterHealth = 50,
        InnerHealthGold = 0.0,
        OuterHealthGold = 0.0,
    },
    ["medical_thickelixir"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 0,
            Metabolism = 500, -- Fatty,
        },
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0.0,
        OuterHealthGold = 0.0,
    },
    ["medical_lolipop"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 40,
            Metabolism = 0,
        },
        CoolDown = 90,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 100.0,   
    },
    ["bandage"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 0,
            Metabolism = 0,
        },
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 100,
        OuterHealth = 0,
        InnerHealthGold = 0.0,
        OuterHealthGold = 0.0,   
        
    },
    --Moonshines
    consumable_moonshine = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 75,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    consumable_blackberry_moonshine = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 75,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    consumable_apple_moonshine = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 75,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    consumable_peach_moonshine60p = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 100,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    consumable_plum_moonshine60p = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 100,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    consumable_blackberry_moonshine90p = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 200,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    consumable_raspberry_moonshine90p = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 200,
        Stamina = 7,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_moonshine_jar"
    },
    --custom Items
    ["consumable_fruitcake"] = {
        Status = {
            Hunger = 30,
            Thirst = 10,
            Stress = 0,
            Metabolism = 50,
        },
        CoolDown = 90,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
     bluegill_everyclear = {
        Status = {
            Hunger = 0,
            Thirst = 40,
            Stress = 0,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 60,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink_whisky_bottle"
    },
    consumable_chocolatecookie = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    
}
