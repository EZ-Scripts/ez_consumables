Config = Config or {}

Config.Debug = true -- Enable debug messages

Config.AnimationTime = 5000 -- Time in MS for the animation to play

Config.Drunk = {
    Drunk = 100,
    PassOut = 350,
}

Config.AnimationRun = "ez_consumables" -- "ez_consumable" or "vorp_animations"

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
    Animation = "drink", -- Animation when consuming the item (optional)
    Prop = {
        name = "P_GLENSWHISKY01X",
        bone = "SKEL_R_Finger12",
        coords = {
            x = 0.01999999999999,
            y = -0.01999999999999,
            z = 0.25,
        },
        rot = {
            x = 0.0,
            y = 180.0,
            z = 180.0
        }
    },
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
            Hunger = 10,
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
            Hunger = 30,
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
            Hunger = 10,
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
            Hunger = 30,
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
    consumable_friedchicken = {
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
    consumable_stringymeat = {
        Status = {
            Hunger = 10,
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
            Hunger = 20,
            Thirst = 0,
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
    consumable_gamemeatjerky = {
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
    consumable_boiledegg = {
        Status = {
            Hunger = 15,
            Thirst = -3,
            Stress = 5,
            Metabolism = math.random(200),
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
            Stress = 20,
            Metabolism = math.random(30, 50), -- Fatty
        },
        Stamina = 10,
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
            Stress = 20,
            Metabolism = math.random(30, 50), -- Fatty
        },
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
        Prop = {
            name = "s_chocolatebar01x",
            bone = "SKEL_R_HAND",
            coords = {x = 0.13,y = 0.01,z = -0.05},
            rot = {xr = -85.0, yr = 100.0, zr = 81.1}
        }
    },
    consumable_fruitsalad = {
        Status = {
            Hunger = 10,
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
    consumable_peach = {
        Status = {
            Hunger = 5,
            Thirst = 2,
            Stress = 2,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
        Prop = {
            name = "S_BIT_PEACH01X",
        }
    },
    consumable_salmon = {
        Status = {
            Hunger = 5,
            Thirst = 1,
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
        Animation = "eat",
        Prop = {
            name = "p_can01x",
        }
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
        Animation = "eat",
        Prop = {
            name = "s_cheesewedge1x",
        }
    },
    consumable_pear = {
        Status = {
            Hunger = 3,
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
        Animation = "eat",
        Prop = {
            name = "s_bit_pear_02x",
        }
    },
    consumable_kidneybeans_can = {
        Status = {
            Hunger = 5,
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
        Animation = "eat",
        Prop = {
            name = "s_canbeans01x",
        }
    },
    consumable_blueberrypie = {
        Status = {
            Hunger = 20,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    consumable_chickenpie = {
        Status = {
            Hunger = 20,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    consumable_chocolatecake = {
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
    consumable_donut = {
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
        Animation = "stew",
        Prop = {
            name = "p_bowl04x_stew",
        }
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
        Animation = "stew",
        Prop = {
            name = "p_stewplate01x",
        }
    },
    consumable_pretzel = {
        Status = {
            Hunger = 20,
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
            Hunger = 20,
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
            Hunger = 10,
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
        Animation = "stew",
        Prop = {
            name = "p_beefstew01x",
        }
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    Red_Raspberry = {
        Status = {
            Hunger = 5,
            Thirst = 0,
            Stress = 10,
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
    consumable_spaghetti_meatballs = {
        Status = {
            Hunger = 35,
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
            Hunger = 10,
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
            Hunger = 10,
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
            Hunger = 30,
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
        Animation = "stew",
        Prop = {
            name = "p_stewplate01x",
        }
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
        Animation = "drink",
        Prop = {
            name = "s_inv_whiskey01x",
            bone = "SKEL_R_HAND",
            coords = {x = 0.08,y = -0.14,z = -0.08},
            rot = {x = -75.0, y = 0.0, z = 0.0}
        },
        ItemReturn = "emptywaterbottle"
    },
    wine = {
        Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 10,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 30,
        Stamina = 4,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_bottlewine01x",
            bone = "SKEL_R_Finger12",
            coords = {x = 0.01999999999999,y = -0.01999999999999,z = 0.25,},
            rot = {x = 0.0,y = 180.0,z = 180.0}
        },
    },
    vodka = {
        Status = {
            Hunger = 0,
            Thirst = 25,
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
        Animation = "drink",
        Prop = {
            name = "p_bottlewine01x",
            bone = "SKEL_R_Finger12",
            coords = {x = 0.01999999999999, y = -0.01999999999999, z = 0.25,},
            rot = {x = 0.0, y = 180.0, z = 180.0}
        },
    },
    beer = {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 10,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 15,
        Stamina = 3,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_bottlebeer01a",
            bone = "SKEL_R_Finger12",
            coords = {x = 0.01999999999999, y = -0.01999999999999, z = 0.10},
            rot = {x = 0.0, y = 180.0, z = 180.0}
        },
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
        Animation = "drink",
        Prop = {
            name = "P_BOTTLETEQUILA01X",
            bone = "SKEL_R_Finger12",
            coords = {x = 0.01999999999999, y = -0.01999999999999, z = 0.25},
            rot = {x = 0.0, y = 180.0, z = 180.0}
        },
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
        Animation = "drink",
        Prop = {
            name = "p_bottlebeer01a",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.01999999999999,
                y = -0.01999999999999,
                z = 0.10,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
    },
    consumable_coffee = {
        Status = {
            Hunger = 0,
            Thirst = 10,
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
        Animation = "coffee"
    },
    consumable_creamcoffee = {
        Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 10,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 20,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "coffee"
    },
    consumable_ginsengtea = {
        Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 5,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "coffee",
        Prop = {
            name = "p_teacup",
        }
    },
    consumable_raspberrywater = {
        Status = {
            Hunger = 0,
            Thirst = 40,
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
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
        ItemReturn = "emptywaterbottle" -- or "glassbottle" if you want to be more generic
    },
    consumable_blackberrywater = {
        Status = {
            Hunger = 0,
            Thirst = 25,
            Stress = 5,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
        ItemReturn = "emptywaterbottle" -- or "glassbottle" if you want to be more generic

    },
    consumable_water = {
        Status = {
            Hunger = 0,
            Thirst = 10,
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
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
        ItemReturn = "emptywaterbottle" -- or "glassbottle" if you want to be more generic
    },
    milk = {
        Status = {
            Hunger = 0,
            Thirst = 10,
            Stress = 0,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
        ItemReturn = "emptywaterbottle" -- or "glassbottle" if you want to be more generic
    },
    consumable_chocolatemilk = {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 5,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        Stamina = 10,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "coffee",
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
        Animation = "drink",
        Prop = {
            name = "p_masonjar01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
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
        Animation = "drink",
        Prop = {
            name = "p_masonjar01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
    },
    ["medical_cocainegum"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 50,
            Metabolism = 0,
        },
        CoolDown = 90,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 100.0,
        OuterHealth = 0,
        InnerHealthGold = 0.0,
        OuterHealthGold = 0.0,
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
        Animation = "drink",
        Prop = {
            name = "p_masonjar01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
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
        Animation = "drink",
        Prop = {
            name = "p_masonjar01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
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
        Animation = "drink",
        Prop = {
            name = "p_masonjar01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
    },
    ["medical_lolipop"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 50,
            Metabolism = 0,
        },
        CoolDown = 90,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 60.0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 0.0,
    },
    ["medical_goldenpot"] = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 50,
            Metabolism = 0,
        },
        CoolDown = 90,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 60.0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 0.0,
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
        Animation = "bandage",
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
        Animation = "drink",
        Prop = {
            name = "p_masonjarmoonshine01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        }
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
        Animation = "drink",
        Prop = {
            name = "p_masonjarmoonshine01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        }
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
        Animation = "drink",
        Prop = {
            name = "p_masonjarmoonshine01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        }
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
        Animation = "drink",
        Prop = {
            name = "p_masonjarmoonshine01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        }
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
        Animation = "drink",
        Prop = {
            name = "p_masonjarmoonshine01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        }
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
        Animation = "drink",
        Prop = {
            name = "p_masonjarmoonshine01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        }
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
        Animation = "drink",
        Prop = {
            name = "p_masonjarmoonshine01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        }
    },
    --- Jade Dragon 
    consumable_saki = {
        Status = {
            Hunger = 0,
            Thirst = 15,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_masonjarmoonshine01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        }
    },
    consumable_dumpling = {
        Status = {
            Hunger = 5,
            Thirst = 70,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100,
        OuterStaminaGold = 100,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_ramen = {
        Status = {
            Hunger = 25,
            Thirst = 10,
            Stress = 5,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_friedrice = {
        Status = {
            Hunger = 20,
            Thirst = 0,
            Stress = 5,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },

---custom Items
    consumable_eggroll = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 5,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        InnerHealth = 100.0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_fortunecookie = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 5,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_fruitcake = {
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
    consumable_hashbrown = {
        Status = {
            Hunger = 40,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0.0,
        OuterHealth = 30.0,
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
        Animation = "drink",
        Prop = {
            name = "P_GLENSWHISKY01X",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.01999999999999,
                y = -0.01999999999999,
                z = 0.25,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
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
    consumable_cbkiss = {
        Status = {
            Hunger = 45,
            Thirst = 0,
            Stress = 25,
            Metabolism =  math.random(-10, 10),
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
    consumable_bittenblue = {
        Status = {
            Hunger = 0,
            Thirst = 40,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "coffee",
        ItemReturn = "emptywaterbottle"
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
        Animation = "stew",
        Prop = {
            name = "p_bowl04x_stew",
        }
    },
    consumable_velvetsin = {
        Status = {
            Hunger = 40,
            Thirst = 0,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_rhubarbpie = {
        Status = {
            Hunger = 40,
            Thirst = 0,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    consumable_potatosoup = {
        Status = {
            Hunger = 40,
            Thirst = 20,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "stew",
        Prop = {
            name = "p_fishstew01x",
        }
    },
    consumable_gumbo = {
        Status = {
            Hunger = 65,
            Thirst = 0,
            Stress = 5,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "stew",
        Prop = {
            name = "p_beefstew01x",
        }
    },
    consumable_blueberrycobbler = {
        Status = {
            Hunger = 60,
            Thirst = 0,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
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
    consumable_peachpalinka = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 10,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 55,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "P_GLENSWHISKY01X",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.01999999999999,
                y = -0.01999999999999,
                z = 0.25,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
    },
    consumable_sparklingwater = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism =  math.random(-10, 10),
        },
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
        ItemReturn = "emptywaterbottle"
    },
    consumable_gulyas = {
        Status = {
            Hunger = 55,
            Thirst = 15,
            Stress = 0,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "stew",
        Prop = {
            name = "p_beefstew01x",
        }
    },
    consumable_rootbeer = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism =  math.random(-10, 10),
        },
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_bottlebeer01a",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.01999999999999,
                y = -0.01999999999999,
                z = 0.10,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
        ItemReturn = "emptywaterbottle"
    },
    consumable_blueberrylightning = {
        Status = {
            Hunger = 0,
            Thirst = 50,
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
        Animation = "drink",
        Prop = {
            name = "P_GLENSWHISKY01X",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.01999999999999,
                y = -0.01999999999999,
                z = 0.25,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
        ItemReturn = "emptywaterbottle"
    },
    consumable_bethbrew = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism =  math.random(-10, 10),
        },
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_masonjar01x",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.03999999999998,
                y = -0.01999999999999,
                z = 0.09999999999999,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
    },
    consumable_kendallkake = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_buffalobites = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "stew",
        Prop = {
            name = "p_beefstew01x",
        }
    },
    consumable_popeyeschicken = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
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
    consumable_fricot = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "stew",
        Prop = {
            name = "p_fishstew01x",
        }
    },
    consumable_sweettea = {
        Status = {
            Hunger = 0,
            Thirst = 60,
            Stress = 10,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 0,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_whiskeyglass01x",
        },
        ItemReturn = "emptywaterbottle"
    },
    consumable_maltscotch = {
        Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 30,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 40,
        Stamina = 5,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_whiskeyglass01x",
        },
        ItemReturn = "emptywaterbottle"
    },
    consumable_strawberrylemonade = {
        Status = {
            Hunger = 0,
            Thirst = 60,
            Stress = 10,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 0,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_whiskeyglass01x",
        },
        ItemReturn = "emptywaterbottle"
    },
    consumable_ghostshot = {
        Status = {
            Hunger = 0,
            Thirst = 10,
            Stress = 10,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 80,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_cs_shotglass01x",
            bone = "SKEL_R_HAND",
            coords = {x = 0.08, y = 0.02, z = -0.05},
            rot = {x = -75.0, y = 0.0, z = 0.0}
        },
    },
    consumable_beefstew = {
        Status = {
            Hunger = 40,
            Thirst = 30,
            Stress = 5,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100,
        OuterStaminaGold = 100,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "stew",
        Prop = {
            name = "p_beefstew01x",
        }
    },
    consumable_stickywings = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 5,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_water_honey = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 0,
        Stamina = 5,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
        ItemReturn = "emptywaterbottle"
    },
    consumable_mudslide = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_blueberrycheesecake = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_blueberrywaffles = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 5,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_chocolatemilkshake = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_kola = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "P_GLENSWHISKY01X",
            bone = "SKEL_R_Finger12",
            coords = {
                x = 0.01999999999999,
                y = -0.01999999999999,
                z = 0.25,
            },
            rot = {
                x = 0.0,
                y = 180.0,
                z = 180.0
            }
        },
        ItemReturn = "emptywaterbottle"
    },
    consumable_honeypack = {
        Status = {
            Hunger = 5,
            Thirst = 0,
            Stress = 45,
            Metabolism =  math.random(-10, 10),
        },
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_shot = {
        Status = {
            Hunger = 0,
            Thirst = 10,
            Stress = 60,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 30,
        Stamina = 5,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_cs_shotglass01x",
            bone = "SKEL_R_HAND",
            coords = {x = 0.08, y = 0.02, z = -0.05},
            rot = {x = -75.0, y = 0.0, z = 0.0}
        },
    },
    consumable_chickenwaffle = {
        Status = {
            Hunger = 40,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 0,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_buckshot = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_cs_shotglass01x",
            bone = "SKEL_R_HAND",
            coords = {x = 0.08, y = 0.02, z = -0.05},
            rot = {x = -75.0, y = 0.0, z = 0.0}
        },
    },
    consumable_buckshine = {
        Status = {
            Hunger = 0,
            Thirst = 10,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 90,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "s_inv_whiskey01x",
            bone = "SKEL_R_HAND",
            coords = {x = 0.08,y = -0.14,z = -0.08},
            rot = {x = -75.0, y = 0.0, z = 0.0}
        },
        ItemReturn = "emptywaterbottle"
    },
    consumable_gravy = {
        Status = {
            Hunger = 50,
            Thirst = 10,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "stew",
        Prop = {
            name = "p_gravybowl01x",
        }
    },
    consumable_bbqchicken = {
        Status = {
            Hunger = 60,
            Thirst = 10,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
}

-- Usable items that when used give you different items.
Config.ItemToSplit = {
    -- Example Vanilla Cake gives you 5 sponge cakes and 1 beer box.
    vanillacake = {consumable_spongecake = {count = 5, label = "Sponge Cake"}, beerbox = {count = 1, label = "Beer Box"}},
    cigar_hamishbox = {cigar_hamishs_stoagie = {count = 5, label = "Hamish's Stoagies"}},
    
}