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
    Func = function() -- Function to run when consumption is complete client side (optional)
        Config.Effects.high(60) -- Example effect
    end,
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
    consumable_taco_catch = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_payforaday = {
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
    consumable_coldprayer_sangria = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 5,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 90,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
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
    consumable_caboose_cooler = {
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
    consumable_caboose_club = {
        Status = {
            Hunger = 50,
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
    consumable_native_chocolate_mousse = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_ducky_delight = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
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
consumable_bethsmilktea = {
        Status = {
            Hunger = 10,
            Thirst = 60,
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
    consumable_fishies_flan = {
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
    consumable_alexhorchata = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
    consumable_midnight_in_rhodes = {
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
        OuterHealth = 30.0,
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
    consumable_pumpkincookie = {
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
        Animation = "eat",
        Prop = {
            name = "ntc_pumpkincookie",
            bone = "SKEL_R_HAND",
            coords = {x = 0.169, y = 0.000, z = -0.070},
            rot = {xr = 23.000, yr = -345.000, zr = -223.000}
        }
    },
    consumable_heartcookie = {
        Status = {
            Hunger = 35,
            Thirst = 0,
            Stress = 5,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 5,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_bread = {
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
    consumable_baguette = {
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
    consumable_sourdough = {
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
    consumable_peachpie = {
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
    consumable_peach_donut = {
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
    consumable_strawberrycobbler = {
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
    consumable_lemoncake = {
        Status = {
            Hunger = 35,
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
    consumable_lemonpie = {
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
    consumable_coffeemuffin = {
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
    consumable_pumpkinpie = {
        Status = {
            Hunger = 40,
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
    consumable_pumpkinroll = {
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
    consumable_pumpkinspice = {
        Status = {
            Hunger = 0,
            Thirst = 50,
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
    consumable_cappuccino = {
        Status = {
            Hunger = 0,
            Thirst = 30,
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
    consumable_blackrose = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 50,
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
    consumable_darkberrypour = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
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
    consumable_johns_sweetsin = {
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
    consumable_rosa_braised_beef = {
        Status = {
            Hunger = 50,
            Thirst = 5,
            Stress = 15,
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
            name = "p_bowl04x_stew",
        }
    },
    consumable_frontier_lemonade = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
    },
    consumable_cb_signature = {
        Status = {
            Hunger = 50,
            Thirst = 5,
            Stress = 15,
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
    consumable_cubbykebab = {
        Status = {
            Hunger = 30,
            Thirst = 0,
            Stress = 5,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 15,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
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
    ["medical_smelling_salts"] = {
        Status = {
            Hunger = 10,
            Thirst = 0,
            Stress = 100.0,
            Metabolism = 0,
        },
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 30.0,
        OuterHealth = 0,
        InnerHealthGold = 0.0,
        OuterHealthGold = 0.0,
        Animation = "eat",
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
        CoolDown = 15,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0.0,
        OuterHealthGold = 0.0,
        Animation = "bandage",
    },


-- Native General
   consumable_native_cornbread = {
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
    consumable_native_frybread = {
        Status = {
            Hunger = 25,
            Thirst = 0,
            Stress = 20,
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
    consumable_native_icecream = {
        Status = {
            Hunger = 25,
            Thirst = 0,
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
    consumable_native_cuccotash = {
        Status = {
            Hunger = 30,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "stew",
        Prop = {
            name = "p_beefstew01x",
        }
    },
    consumable_native_tea = {
        Status = {
            Hunger = 0,
            Thirst = 30,
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
    consumable_wojapi = {
        Status = {
            Hunger = 25,
            Thirst = 0,
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
    consumable_wojapi_bread = {
        Status = {
            Hunger = 35,
            Thirst = 0,
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

-- Shaman
    ["medical_nativewillow"] = {
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
    ["medical_nativeherbal"] = {
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
    medical_peyote = {
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
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },
        Func = function()
            Config.Effects.high(60)
        end,
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
            Hunger = 20,
            Thirst = 50,
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

---Halloween Items
    candy_halloween = {
        Status = {
            Hunger = 70.0,
            Thirst = 0,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 100.0,
        OuterHealth = 100.0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 100.0,
    },
    consumable_vampireshot_halloween = {
        Status = {
            Hunger = 0,
            Thirst = 100.0,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 350.0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_halloween_cakepop = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 0,
            Metabolism = 0,
        },
        CoolDown = 300,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 100.0,
        OuterHealth = 100.0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 100.0,
        Animation = "eat",
    },
    consumable_halloween_brittle = {
        Status = {
            Hunger = 100,
            Thirst = 0,
            Stress = 0,
            Metabolism = 0,
        },
        CoolDown = 300,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 100.0,
        OuterHealth = 100.0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 100.0,
        Animation = "eat",
    },
    consumable_halloween_sangria = {
        Status = {
            Hunger = 0,
            Thirst = 100,
            Stress = 0,
            Metabolism = 0,
        },
        CoolDown = 300,
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 100.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
    },
--- Christmas Items
    consumable_event_cookies = {
        Status = {
            Hunger = 100,
            Thirst = 100,
            Stress = 100,
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
    consumable_event_gingerbread = {
        Status = {
            Hunger = 100,
            Thirst = 100,
            Stress = 100,
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

--- Bundle Items
    consumable_bundle_caviar = {
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
    consumable_bundle_whitechampagne = {
        Status = {
            Hunger = 0,
            Thirst = 100.0,
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
    medical_gold_bandage = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 0,
            Metabolism = 0,
        },
        Stamina = 0,
        CoolDown = 15,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 100.0,
        Animation = "bandage",
    },

--- BFRP ITEMS
    bfrp_bandage = {
        Status = {
            Hunger = 0,
            Thirst = 0,
            Stress = 0,
            Metabolism = 0,
        },
        CoolDown = 300,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 100.0,
        OuterHealth = 100.0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 100.0,
        Animation = "bandage",
    },
    bfrp_kernal_corn = {
        Status = {
            Hunger = 100.0,
            Thirst = 0,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        CoolDown = 300,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 100.0,
        OuterHealth = 100.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
      bfrp_cookie = {
        Status = {
            Hunger = 100,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        CoolDown = 300,
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    bfrp_milkshake = {
        Status = {
            Hunger = 0,
            Thirst = 100.0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
                CoolDown = 300,
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
    seasonal_star_spangled_spritz = {
        Status = {
            Hunger = 0,
            Thirst = 100.0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        CoolDown = 300,
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 100.0,
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


---custom Items
consumable_angels_cure = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
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
            },
        },
    }, 
consumable_ironbark_jerky = {
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
        Animation = "eat",
    },
consumable_wasp_cake = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 0,
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
        Animation = "eat",
Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
consumable_smothered_burrito = {
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
        Animation = "eat",
Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
},
consumable_menudo = {
        Status = {
            Hunger = 10,
            Thirst = 60,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "stew",
        Prop = {
            name = "p_beefstew01x",
        }
    },
consumable_slinger_energy = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = .0,
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
            },
        },
    }, 
consumable_smiths_sarsaparilla = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
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
consumable_love_first_bite = {
        Status = {
            Hunger = 40,
            Thirst = 0,
            Stress = 30,
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
        Animation = "eat",
Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
},
 consumable_tommys_cinnamon_latte = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = .0,
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
            },
        },
    }, 
consumable_beths_matcha = {
        Status = {
            Hunger = 0,
            Thirst = 60,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = .0,
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
            },
        },
    }, 
consumable_cheddar_bay_biscuits = {
        Status = {
            Hunger = 30,
            Thirst = 0,
            Stress = 40,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
consumable_emerald_garden = {
        Status = {
            Hunger = 60,
            Thirst = 0,
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
         Animation = "eat",
    },
consumable_golden_steak  = {
        Status = {
            Hunger = 60,
            Thirst = 0,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
consumable_emerald_refresher = {
        Status = {
            Hunger = 0,
            Thirst = 60,
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
         Animation = "drink",
    },
consumable_clarks_cola = {
        Status = {
            Hunger = 10,
            Thirst = 50,
            Stress = 10,
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
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        }
    },
consumable_luckycatch_boil = {
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
            name = "p_gravybowl01x",
        }
    },
consumable_raspberry_liqueur = {
        Status = {
            Hunger = 50,
            Thirst = 10,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
    },
consumable_ironbark_coldbrew = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
            },
        },
    },
consumable_bailey_cheesecake = {
        Status = {
            Hunger = 40,
            Thirst = 0,
            Stress = 10,
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
         Animation = "eat",
Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0},
        },
    },
consumable_pumpkin_cream = {
        Status = {
            Hunger = 0,
            Thirst = 40,
            Stress = 30,
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
         Animation = "coffee",
 Prop = {
           name = "p_teacup",
        },
    },
consumable_royale_burger = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0.00,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
consumable_honeycomb_mix = {
        Status = {
            Hunger = 35,
            Thirst = 0,
            Stress = 35,
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
        Animation = "eat",

    },
consumable_gummy_bears = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
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
        Animation = "eat",

    },
consumable_jim_jerky = {
        Status = {
            Hunger = 40,
            Thirst = 0,
            Stress = 30,
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
        Animation = "eat",

    },
consumable_american_lemonade = {
        Status = {
            Hunger = 0,
            Thirst = 60,
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
        Animation = "drink",

    },
consumable_ultra_hydration = {
        Status = {
            Hunger = 0,
            Thirst = 45,
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
        Animation = "drink",

    },
consumable_chicken_noodle = {
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
         Animation = "stew",
 Prop = {
            name = "p_bowl04x_stew",
        }
    },
consumable_bella_stash = {
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
        Animation = "eat",
    },
consumable_exile_token = {
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
        OuterHealthGold = 30.0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },
         Func = function()
            Config.Effects.high(60)
        end,

    },
consumable_manda_mess = {
        Status = {
            Hunger = 35,
            Thirst = 0,
            Stress = 35,
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
        Animation = "eat",
Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
consumable_fried_steak = {
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
        Animation = "stew",
        Prop = {
            name = "p_gravybowl01x",
        }
    },
consumable_cherry_blast = {
        Status = {
            Hunger = 0,
            Thirst = 60,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0.00,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
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
        }
    },
consumable_candy_treat = {
        Status = {
            Hunger = 60,
            Thirst = 0,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0.00,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
    },
consumable_last_drop = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0.00,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
 consumable_chopped_cheese = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0.00,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
    },
consumable_moon_whiskey = {
        Status = {
            Hunger = 0,
            Thirst = 40,
            Stress = 30,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30.00,
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
    },
consumable_moon_burger = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0.00,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
consumable_get_right = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
potion_consumable_starlight = {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 0,
            Metabolism = -2000, -- Healthy,
        },
        Stamina = 50,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
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
potion_consumable_mire_mender = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 0,
            Metabolism = 2000, -- Healthy,
        },
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
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
potion_consumable_death_whistle = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 20,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
potion_consumable_blossomdew = {
             Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 30,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 20,
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
        }, Func = function()
            Config.Effects.high(60)
        end,
    },
potion_consumable_moonstar = {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 60,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 20,
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
consumable_trappers_dew = {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 50,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
consumable_blue_flames = {
        Status = {
            Hunger = 10,
            Thirst = 0,
            Stress = 60,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 30.0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },
        Func = function()
            Config.Effects.high(60)
        end,
    },
consumable_devils_lettuce = {
        Status = {
            Hunger = 10,
            Thirst = 0,
            Stress = 60,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 30.0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },
        Func = function()
            Config.Effects.high(60)
        end,
    },
consumable_cowpoke_fizz = {
        Status = {
            Hunger = 0,
            Thirst = 60,
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
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
    },
consumable_hemlock_kiss  = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 0,
        Stamina = 4,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
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
consumable_frost_eggnog = {
        Status = {
            Hunger = 0,
            Thirst = 45,
            Stress = 25,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
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
consumable_fallen_angel = {
        Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
consumable_clam_slam = {
        Status = {
            Hunger = 0,
            Thirst = 60,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
consumable_horsemeat_sandwich = {
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
        Animation = "eat",
    },
consumable_rainbow_juice = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
         Animation = "drink",
    },
consumable_pippa_chicken = {
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
        Animation = "eat",
    },
consumable_peace_punch = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
         Animation = "drink",
    },
consumable_sanguine_sip = {
        Status = {
            Hunger = 0,
            Thirst = 40,
            Stress = 30,
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
         Animation = "drink",
    },
consumable_garden_fries = {
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_pecks_stack = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
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
       Animation = "eat",
Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_alibi_cheesecake = {
        Status = {
            Hunger = 60,
            Thirst = 0,
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
       Animation = "eat",
Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_strawberry_shake = {
        Status = {
            Hunger = 5,
            Thirst = 45,
            Stress = 0,
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
consumable_joe_half_half = {
        Status = {
            Hunger = 0,
            Thirst = 60,
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
       Animation = "coffee",
 Prop = {
           name = "p_teacup",
        }
    },
consumable_scarlet_temptation = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
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
consumable_rango_reposado = {
        Status = {
            Hunger = 0,
            Thirst = 5,
            Stress = 0,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 95,
        Stamina = 5,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
consumable_tiramisu = {
        Status = {
            Hunger = 45,
            Thirst = 0,
            Stress = 25,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
consumable_beef_chili = {
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
            name = "p_beefstew01x",
        }
    },
consumable_lamb_fry = {
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
            name = "p_beefstew01x",
        }
    },
consumable_mad_maddox = {
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
consumable_bog_water = {
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
        OuterHealth = 30.0,
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
consumable_steak_n_potatoes = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
    consumable_whiskey_barrel = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 30,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 30.0,
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
consumable_bourbon_flask = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 50,
        Stamina = 2,
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
            coords = {x = 0.01999999999999, y = -0.01999999999999, z = 0.10},
            rot = {x = 0.0, y = 180.0, z = 180.0}
        },
    },
consumable_big_dam_brew = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 0,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 30.0,
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
consumable_cloud_nine_liqueur = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 0,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 50,
        Stamina = 5,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
consumable_kangaroo_hop_pot = {
        Status = {
            Hunger = 60,
            Thirst = 10,
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
            name = "p_beefstew01x",
        }
    },
consumable_black_angel_lobster = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
    },
consumable_black_heart = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
    },
consumable_casanova = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 10,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
         Animation = "drink",
    },
consumable_fatman_tini = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 10,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
         Animation = "drink",
    },
consumable_six_shooter = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 50,
        Stamina = 2,
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
            coords = {x = 0.01999999999999, y = -0.01999999999999, z = 0.10},
            rot = {x = 0.0, y = 180.0, z = 180.0}
        },
    },
consumable_bennys_steak = {
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_gator_sandwich = {
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_gator_pho = {
        Status = {
            Hunger = 50,
            Thirst = 20,
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
consumable_home_gumbo = {
        Status = {
            Hunger = 60,
            Thirst = 10,
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
            name = "p_beefstew01x",
        }
    },
consumable_mint_julep= {
        Status = {
            Hunger = 0,
            Thirst = 60,
            Stress = 10,
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
        Animation = "coffee",
        Prop = {
           name = "consumable_mint_julep",
        },
    },
consumable_sneakys_juice= {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 50,
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
        ItemReturn = "emptywaterbottle" -- or "glassbottle" if you want to be more generic
    },
consumable_southern_sweet_tea = {
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

consumable_creek_lite_apple = {
        Status = {
            Hunger = 0,
            Thirst = 40,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        AlcoholLevel = 40,
        Stamina = 2,
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
            coords = {x = 0.01999999999999, y = -0.01999999999999, z = 0.10},
            rot = {x = 0.0, y = 180.0, z = 180.0}
        },
    },
consumable_starter_tots = {
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_double_smash_burger = {
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_brisket_fries = {
        Status = {
            Hunger = 70,
            Thirst = 0,
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
    },
consumable_dear_malta = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 0,
            Metabolism = math.random(-10, 10),
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
            name = "p_bottlebeer01a",
            bone = "SKEL_R_Finger12",
            coords = {x = 0.01999999999999, y = -0.01999999999999, z = 0.10},
            rot = {x = 0.0, y = 180.0, z = 180.0}
        },
    },
consumable_trippa_snippa = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
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
consumable_dirty_diva= {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 0,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        AlcoholLevel = 80,
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0.0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0.0,
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
consumable_devadent_vip = {
        Status = {
            Hunger = 0,
            Thirst = 30,
            Stress = 10,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        AlcoholLevel = 60,
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0.0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0.0,
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
consumable_sharpshooter = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 10,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        AlcoholLevel = 40,
        Stamina = 2,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0.0,
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
consumable_boots_shoey = {
        Status = {
            Hunger = 0,
            Thirst = 25,
            Stress = 10,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        AlcoholLevel = 65,
        Stamina = 2,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0.0,
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
consumable_velvet_crown = {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 20,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        AlcoholLevel = 60,
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0.0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0.0,
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
consumable_sneakys_sausage = {
        Status = {
            Hunger = 60,
            Thirst = 0,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
consumable_silver_bullet = {
        Status = {
            Hunger = 0,
            Thirst = 65,
            Stress = 5,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
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
consumable_draft_horse = {
        Status = {
            Hunger = 0,
            Thirst = 65,
            Stress = 5,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
consumable_draft_horse_cheesecurds = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
consumable_johns_uppercut = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
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
consumable_totors_loaded_tater = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
consumable_hawk_tuah_ale = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 30,
        Stamina = 3,
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
            coords = {x = 0.01999999999999, y = -0.01999999999999, z = 0.10},
            rot = {x = 0.0, y = 180.0, z = 180.0}
        },
    },
consumable_circus_cake = {
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_ringmaster_gumbo = {
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
consumable_we_all_float = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
    },
consumable_boots_buttery_buns = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 0,
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
consumable_velvet_crab_cakes = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
consumable_bulldog_ale = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(0, 10),
        },
        AlcoholLevel = 30,
        Stamina = 3,
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
            coords = {x = 0.01999999999999, y = -0.01999999999999, z = 0.10},
            rot = {x = 0.0, y = 180.0, z = 180.0}
        },
    },
consumable_yeast_beef = {
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
        Animation = "food",
    },
consumable_strawberries_cream = {
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
        Animation = "food",
    },
consumable_flirtini  = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 60,
        Stamina = 0,
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
consumable_duttons_dirty_cream  = {
        Status = {
            Hunger = 0,
            Thirst = 40,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 60,
        Stamina = 0,
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
    consumable_dirty_glizzy = {
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
        Animation = "food",
    },

    consumable_aarons_backout_shot = {
        Status = {
            Hunger = 0,
            Thirst = 40,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 50,
        Stamina = 0,
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
    consumable_velvets_spotted_dick = {
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
        Animation = "eat",
    },
    consumable_montana_meal = {
        Status = {
            Hunger = 40,
            Thirst = 0,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_rusty_nail = {
        Status = {
            Hunger = 0,
            Thirst = 40,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
 AlcoholLevel = 30,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_long_johnson = {
        Status = {
            Hunger = 50,
            Thirst = 5,
            Stress = 15,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_montana_madness = {
        Status = {
            Hunger = 5,
            Thirst = 60,
            Stress = 5,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_gator_tail_bites = {
        Status = {
            Hunger = 60,
            Thirst = 5,
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
            name = "p_gravybowl01x",
        }
    },

    consumable_lemon_cream_pie = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_clover_charm_cookie = {
        Status = {
            Hunger = 100,
            Thirst = 100,
            Stress = 100,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 100.0,
        OuterHealth = 100.0,
        InnerHealthGold = 100.0,
        OuterHealthGold = 100.0,
    },
    consumable_charmios = {
        Status = {
            Hunger = 100,
            Thirst = 0,
            Stress = 100,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_lucky_foam_brew = {
        Status = {
            Hunger = 0,
            Thirst = 100,
            Stress = 100,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
     consumable_johnnys_peanut_butter_milkshake = {
        Status = {
            Hunger = 5,
            Thirst = 60,
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
        OuterHealthGold = 30.0,
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
    consumable_rootbeer_float = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
    consumable_rhodes_wiener = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 0,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
               }
    },
    consumable_bethscreamydelights = {
        Status = {
            Hunger = 50,
            Thirst = 5,
            Stress = 15,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    consumable_creamy_strudel = {
        Status = {
            Hunger = 35,
            Thirst = 0,
            Stress = 35,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    consumable_chickenkabob = {
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
    consumable_fizzypop = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 00,
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
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
    },
    consumable_fruitpunch = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },
    },
    consumable_mozzeralla = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_conductorscoldbrew = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
    consumable_sourrockcandy = {
        Status = {
            Hunger = 60,
            Thirst = 0,
            Stress = 10,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_peanuts = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 0,
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

    consumable_lemonchicken = {
        Status = {
            Hunger = 50,
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
    consumable_mariespickles = {
        Status = {
            Hunger = 50,
            Thirst = 5,
            Stress = 15,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_theren = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 30,
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
    },
    consumable_larrysloadedfries = {
        Status = {
            Hunger = 50,
            Thirst = 10,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
    consumable_apple_spritz = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
    consumable_turkeyleg = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_cricketts_special = {
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
    consumable_trailblend = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_beecookie = {
        Status = {
            Hunger = 40,
            Thirst = 0,
            Stress = 30,
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
    consumable_ice_pack_whiskey = {
        Status = {
            Hunger = 0,
            Thirst = 10,
            Stress = 0,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 90.0,
        Stamina = 0,
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
    consumable_bscherrypop = {
        Status = {
            Hunger = 0,
            Thirst = 65,
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
        Animation = "drink",
        Prop = {
                   name = "p_water01x",
               },
    },
    consumable_enchiladaspecial = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
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
    consumable_hottoddy = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
                z = 180.0,
            }
        },

    },
    consumable_popcorn = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 0,
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
    consumable_rock_candy = {
        Status = {
            Hunger = 10,
            Thirst = 0,
            Stress = 60,
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
    consumable_strawberrymocktail = {
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
    consumable_chickendinner = {
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
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 30.0,
        Animation = "stew",
        Prop = {
            name = "p_beefstew01x",
        }
    },
    consumable_salmondinner = {
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
    consumable_bethsmilkshake = {
        Status = {
            Hunger = 20,
            Thirst = 40,
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
    consumable_applejuice = {
        Status = {
            Hunger = 0,
            Thirst = 60,
            Stress = 10,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        AlcoholLevel = 0,
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
     consumable_tbone_steak = {
        Status = {
            Hunger = 50,
            Thirst = 5,
            Stress = 15,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
               }
    },
    consumable_orangejuice = {
        Status = {
            Hunger = 0,
            Thirst = 60,
            Stress = 10,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        AlcoholLevel = 0,
        Stamina = 2,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
        InnerHealth = 30.0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0.0,
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
    consumable_bullfrogpie = {
        Status = {
            Hunger = 50,
            Thirst = 10,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
     consumable_weedpizza_slice = {
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
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },
        Func = function()
            Config.Effects.high(60)
        end,
    },
     consumable_purple_powder = {
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
        OuterHealthGold = 30.0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },
         Func = function()
            Config.Effects.high(60)
        end,

    },
    consumable_wasps_trip = {
        Status = {
            Hunger = 40,
            Thirst = 0,
            Stress = 30,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 30.0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },
         Func = function()
            Config.Effects.high(60)
        end,

    },
    consumable_crusaders_concoction = {
             Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 30.0,
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
        }, Func = function()
            Config.Effects.high(60)
        end,
    },
    consumable_quicksilver_liquid_silver = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 30.0,
        Animation = "syringe",
        Prop = {
            name = "p_syringe01x",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },
        Func = function()
            Config.Effects.high(60)
        end,
    },
    consumable_wasp_venom = {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 20,
            Metabolism = math.random(-10, 10),
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 30.0,
        Animation = "syringe",
        Prop = {
            name = "p_syringe01x",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },
        Func = function()
            Config.Effects.high(60)
        end,
    },
     consumable_silvercap_mycothique = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
        Func = function()
            Config.Effects.high(60)
        end,
    },
    consumable_carrot_cake = {
        Status = {
            Hunger = 35,
            Thirst = 0,
            Stress = 5,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    consumable_spring_cupcake = {
        Status = {
            Hunger = 35,
            Thirst = 0,
            Stress = 5,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    consumable_good_donut = {
        Status = {
            Hunger = 35,
            Thirst = 0,
            Stress = 5,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    consumable_petal_cookie = {
        Status = {
            Hunger = 35,
            Thirst = 0,
            Stress = 5,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    consumable_citrus_splash = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 5,
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
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },

    },
    consumable_lavender_latte = {
        Status = {
            Hunger = 0,
            Thirst = 35,
            Stress = 5,
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
        Animation = "drink",
        Prop = {
            name = "p_water01x",
        },

    },
    consumable_feral_shrooms = {
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
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },
        Func = function()
            Config.Effects.high(60)
        end,
    },
    consumable_kabob = {
        Status = {
            Hunger = 30,
            Thirst = 30,
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
    consumable_broskystew = {
        Status = {
            Hunger = 40,
            Thirst = 30,
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
            name = "p_beefstew01x",
        }
    },
    consumable_venisonstew = {
        Status = {
            Hunger = 30,
            Thirst = 30,
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
            name = "p_beefstew01x",
        }
    },
    consumable_wangbang = {
        Status = {
            Hunger = 0,
            Thirst = 20,
            Stress = 10,
            Metabolism = 250, -- Fatty,
        },
        AlcoholLevel = 70,
        Stamina = 0,
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
    consumable_wangjuice = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        AlcoholLevel = 0,
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
    consumable_moonlittea = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        AlcoholLevel = 0,
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
    consumable_adobo = {
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
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "stew",
        Prop = {
            name = "p_beefstew01x",
        }
    },
    consumable_mojito = {
        Status = {
            Hunger = 0,
            Thirst = 60,
            Stress = 0,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        AlcoholLevel = 40,
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 30,
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
    consumable_sweetesttea = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        Stamina = 2,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
    consumable_lemonade = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
            Metabolism = math.random(-10, 0), -- Healthy
        },
        Stamina = 2,
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
    },
    consumable_cookiedoe = {
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
    consumable_melonsoda = {
        Status = {
            Hunger = 0,
            Thirst = 70,
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
    consumable_honeytea = {
        Status = {
            Hunger = 0,
            Thirst = 60,
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
        OuterStaminaGold = 0,
        InnerHealth = 0,
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
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
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
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
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
    consumable_grandslam = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 00,
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
    consumable_stickybuns = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
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
    consumable_blushberry = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(0, 10),
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
    consumable_weddingcake_slice = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
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
    consumable_sweetheart_latte = {
        Status = {
            Hunger = 0,
            Thirst = 70,
            Stress = 0,
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
        Animation = "coffee"
    },
    consumable_berrybrat = {
        Status = {
            Hunger = 70,
            Thirst = 0,
            Stress = 0,
            Metabolism = math.random(0, 10),
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
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
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
    consumable_bethbrownie = {
        Status = {
            Hunger = 60,
            Thirst = 5,
            Stress = 5,
            Metabolism = math.random(1, 80), -- Fatty
        },
        Stamina = 2,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 30.0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }
    },
    consumable_darlashake = {
        Status = {
            Hunger = 10,
            Thirst = 50,
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
            Hunger = 60,
            Thirst = 10,
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
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
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
    consumable_crimsoneclipse = {
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
            name = "p_cs_shotglass01x",
            bone = "SKEL_R_HAND",
            coords = {x = 0.08, y = 0.02, z = -0.05},
            rot = {x = -75.0, y = 0.0, z = 0.0}
        },

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
    consumable_ramensramen = {
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
    consumable_marge_kisses = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
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
        consumable_enriques_fruitycake= {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
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
    pho_saki = {
        Status = {
            Hunger = 0,
            Thirst = -10,
            Stress = 0,
            Metabolism = -10,
        },
        AlcoholLevel = 100,
        Stamina = 10,
        InnerStaminaGold = 0.0,
        OuterStaminaGold = 0.0,
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
            Metabolism =  math.random(20, 30),
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
    consumable_horchata = {
        Status = {
            Hunger = 0,
            Thirst = 40,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 50,
        Stamina = 5,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "drink",
        Prop = {
            name = "p_cs_whiskeygls01x",
        },
    },
    consumable_tacos = {
        Status = {
            Hunger = 60,
            Thirst = 0,
            Stress = 10,
            Metabolism =  math.random(20, 30),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_mommawangstamales = {
        Status = {
            Hunger = 55,
            Thirst = 15,
            Stress = 0,
            Metabolism =  math.random(20, 30),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },

-- SEASONAL FALL ITEMS

consumable_pumpkin_loaf = {
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
        OuterHealth = 30,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_rocky_road_bark = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_orchard_warmer = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
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
        Animation = "coffee",
        Prop = {
           name = "p_teacup",
        }
    },
consumable_rocky_road = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },
consumable_hot_butter_rum = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 20,
            Metabolism = math.random(-80, -40), -- Healthy
        },
        AlcoholLevel = 30,
        Stamina = 10,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "coffee",
        Prop = {
            name = "p_teacup",
        }
    },
consumable_harvest_hug_soup = {
        Status = {
            Hunger = 50,
            Thirst = 10,
            Stress = 10,
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
consumable_grandmas_dinner = {
        Status = {
            Hunger = 50,
            Thirst = 0,
            Stress = 20,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 0,
        OuterStaminaGold = 0,
        InnerHealth = 0,
        OuterHealth = 30,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        }

    },

--- HOLIDAY ITEMS FOR SALE
    consumable_xmas_fruitcake = {
        Status = {
            Hunger = 50,
            Thirst = 10,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },

    },
    consumable_ham = {
        Status = {
            Hunger = 50,
            Thirst = 10,
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
        Animation = "eat",
        Prop = {
            name = "p_pie01x_slice",
            coords = {x = 0.06, y = 0.07, z = -0.07},
            rot = {x = 165.0, y = 0.0, z = 0.0}
        },

    },
    consumable_wintertini  = {
        Status = {
            Hunger = 50,
            Thirst = 10,
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
            },
        },

    },
    consumable_eggnog   = {
        Status = {
            Hunger = 50,
            Thirst = 10,
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
    consumable_berrymerry   = {
        Status = {
            Hunger = 50,
            Thirst = 10,
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
        },

    },
    consumable_snowman = {
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
    consumable_xmas_crack  = {
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
    consumable_milk_cookies   = {
        Status = {
            Hunger = 25,
            Thirst = 40,
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
    consumable_pepermintbark    = {
        Status = {
            Hunger = 28,
            Thirst = 0,
            Stress = 10,
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
    consumable_xmas_wreath    = {
        Status = {
            Hunger = 30,
            Thirst = 0,
            Stress = 10,
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
    consumable_candycane    = {
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
    consumable_evergreen_ice    = {
        Status = {
            Hunger = 0,
            Thirst = 60,
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
    consumable_gingerbread_santa    = {
        Status = {
            Hunger = 35,
            Thirst = 0,
            Stress = 20,
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
    consumable_christmasshake   = {
        Status = {
            Hunger = 0,
            Thirst = 60,
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
        consumable_hot_cocoa   = {
        Status = {
            Hunger = 0,
            Thirst = 50,
            Stress = 10,
            Metabolism =  math.random(-10, 10),
        },
        AlcoholLevel = 0,
        Stamina = 0,
        InnerStaminaGold = 100.0,
        OuterStaminaGold = 100.0,
        InnerHealth = 0,
        OuterHealth = 30.0,
        InnerHealthGold = 0,
        OuterHealthGold = 0,
    },
    consumable_rhubarb_spritz = {
            Status = {
                Hunger = 0,
                Thirst = 50,
                Stress = 20,
                Metabolism =  math.random(-10, 10),
            },
            AlcoholLevel = 0,
            Stamina = 0,
            InnerStaminaGold = 100.0,
            OuterStaminaGold = 100.0,
            InnerHealth = 0,
            OuterHealth = .0,
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
                },
            },
        },


}

-- Usable items that when used give you different items.
Config.ItemToSplit = {
    -- Example Vanilla Cake gives you 5 sponge cakes and 1 beer box.
    vanillacake = {consumable_spongecake = {count = 5, label = "Sponge Cake"}, beerbox = {count = 1, label = "Beer Box"}},
    cigar_hamishbox = {cigar_hamishs_stoagie = {count = 5, label = "Hamish's Stoagies"}},
    consumable_weedpizza = {consumable_weedpizza_slice = {count = 4, label = "JB's High-Gherita Pizza"}},
    cigar_blackhill_box = {cigar_blackhill = {count = 5, label = "Black Hill Cigar"}},
    cigarette_howlers_carton = {cigarette_howlers_pack = {count = 4, label = "Grandaddy Howlers Pack"}},
    cigarette_howlers_pack = {cigarette_howlers = {count = 10, label = "Grandaddy Howlers Pack"}},
    cigarette_raven_bones_pack = {cigarette_raven_bones = {count = 10, label = "Raven's Bones Pack"}},
    cigar_purple_raindrop_box = {cigar_purpleraindrop = {count = 5, label = "Purple Raindrop Cigar"}},
    consumable_weddingcake = {consumable_weddingcake_slice = {count = 8, label = "Rosey Ever After Slice"}},
    cigarbox_sugarplum_puff = {cigar_sugarplum_puff = {count = 5, label = "Sugarplum Puff"}},
    cigarette_razz_matazz_pack = {cigarette_razz_matazz = {count = 10, label = "Little Razz Matazz Cigarette"}},
    cigarbox_grizz_green_apple = {cigar_grizz_green_apple = {count = 5, label = "Grizz's Green Apple Cigar"}},
    cigarbox_blue_dream = {cigar_blue_dream = {count = 5, label = "Lana's Blue Dream"}},
    cigarbox_cherrybomb = {cigar_cherrybomb = {count = 5, label = "Cherry Bomb"}},
    cigarbox_calebs_remedy = {cigar_calebs_remedy = {count = 5, label = "Caleb's Remedy"}},
    cigarbox_hot_fudge = {cigar_hot_fudge = {count = 5, label = "Hot Fudge Cigar"}},
    cigarbox_ls = {cigar_larrys_loaded = {count = 5, label = "Larry's Loaded Cigar"}},
    ammo_box_1  = {ammorepeaterexpress = {count = 2, label = "Express Repeater Ammo"}},
    ammo_box_2  = {ammorevolverexpress = {count = 2, label = "Express Revolver Ammo"}},
    ammo_box_3  = {ammorifleexpress =    {count = 2, label = "Express Rifle Ammo"}},




}

Config.Effects = {
    high = function(time)
        Wait(1000)
        AnimpostfxPlay('PlayerWakeUpDrunk')
        AnimpostfxPlay('playerdrugshalluc01')
        Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), true, 1.0) -- SetPedDrunkness
        Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, 100)	-- SetAttributeCoreValue
        Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 0, 1000.0, true)	-- EnableAttributeCoreOverpower
        SetTimecycleModifier("PlayerDrunk01")
        SetTimecycleModifier("LensDistDrunk")
        SetEntityMotionBlur(PlayerPedId(), true)
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.35)
        Wait(1500)
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.25)
        Wait(1500)
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.15)
        Wait(1500)
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.05)
        Citizen.Wait(time * 1000)
        AnimpostfxPlay('PlayerWakeUpDrunk')
        AnimpostfxStop('playerdrugshalluc01')
        Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), false, 0.0) -- SetPedDrunkness
        ClearTimecycleModifier()
    end,
    vintageEye = function(time)
        Wait(1000)
        AnimpostfxPlay("EagleEye")
        Wait(1000)
        AnimpostfxPlay("PhotoMode_FilterVintage02")
        SetTimecycleModifier("EagleEyeDark")
        SetTimecycleModifierStrength(0.5)
        SetEntityMotionBlur(PlayerPedId(), true)
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.35)
        Wait(1500)
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.25)
        Wait(1500)
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.15)
        Wait(1500)
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.05)
        Citizen.Wait(time * 1000)
        AnimpostfxStop("EagleEye")
        AnimpostfxStop("PhotoMode_FilterVintage02")
        ClearTimecycleModifier()
    end,
    clear = function()
        AnimpostfxStop('PlayerWakeUpDrunk')
        AnimpostfxStop('playerdrugshalluc01')
        Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), false, 0.0) -- SetPedDrunkness
        ClearTimecycleModifier()
        SetEntityMotionBlur(PlayerPedId(), false)
        for _, v in pairs(Animpostfx) do
            AnimpostfxClearEffect(v)
        end
        ShakeGameplayCam("SMALL_EXPLOSION_SHAKE", 0.05)
    end,
}
