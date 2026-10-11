--[[ HOW IT FITS TOGETHER
    Every consumable lives in the database and is managed in game with /manageconsumables. Nothing in here needs touching
    to add or change one.

    Consumables  An inventory item that does something when used: fills hunger / thirst, heals, adds alcohol,
                 starts an effect, gives items back (an empty bottle, or the contents of a pack).
    Effects      Screen effects, wobble, camera shake and blur that last a while (a high, a vision filter...).
                 Made in the Effects tab and picked per consumable. Admins can preview them on themselves.

    First start: the tables are created on their own. To bring over the old config run  ez_consumables_migrate
    once from the server console (see README.md).
]]
Config = {}
Config.Debug = false

Config.AdminCommand = "manageconsumables"
Config.AdminGroups = {["admin"] = true, ["superadmin"] = true, ["owner"] = true}

Config.ItemImage = "nui://vorp_inventory/html/img/items/%s.png" -- %s = item name
Config.PageSize = 25 -- Rows per page in the /manageconsumables lists

Config.DefaultEffectTime = 60 -- Seconds an effect lasts when neither the consumable nor the effect sets a time
Config.PreviewKey = "INPUT_FRONTEND_CANCEL" -- Stops an admin preview (Backspace)

-- Types a consumable can be. Used to filter the admin list and for the message the player gets
--   used = what the player is told, %s = item label
--   gives = true: the player is also told each item they got (packs, boxes)
Config.Kinds = {
    {key = "food", label = "Food", used = "You ate %s"},
    {key = "drink", label = "Drink", used = "You drank %s"},
    {key = "medicine", label = "Medicine", used = "You used %s"},
    {key = "tobacco", label = "Tobacco", used = "You smoked %s"},
    {key = "drug", label = "Drug", used = "You took %s"},
    {key = "pack", label = "Pack", used = "You opened %s", gives = true},
    {key = "other", label = "Other", used = "You used %s"},
}
Config.DefaultKind = "food"

--[[ What the player does when they use a consumable. Picked per consumable in /manageconsumables.
    Each one is ONE of
      dict / name (+ female = {dict, name})   an animation that plays for `duration` ms
      interaction = "..."                     a game item interaction (the hash name). Admins can type their own
      scripted = "coffee" | "stew"            sip / spoon interactions written in client/animations.lua
      smoke = "cigar" | "cigarette" | "pipe" | "chew"
                                              held and used a puff at a time with prompts (client/smoking.lua).
                                              Consumables with these get a number of puffs and a time per puff;
                                              useTime is the default time per puff, blockWeapons stops fighting meanwhile
      none = true                             nothing, the consumable works straight away
    prop = the default prop. A consumable can change any part of it (model, bone, offset, rotation)
]]
Config.Animations = {
    interaction = {
        label = "Quick bite",
        interaction = "EAT_MULTI_BITE_FOOD_SPHERE_D8-2_SANDWICH_QUICK_LEFT_HAND",
        duration = 3000,
    },
    drink = {
        label = "Drink from a bottle",
        dict = "amb_rest_drunk@world_human_drinking@male_a@idle_a", name = "idle_a",
        female = {dict = "amb_rest_drunk@world_human_drinking@female_a@idle_b", name = "idle_b"},
        duration = 5300,
        prop = {model = "p_glenswhisky01x", bone = "SKEL_R_HAND", offset = {x = 0.08, y = -0.04, z = -0.05}, rotation = {x = -75.0, y = 0.0, z = 0.0}},
    },
    eat = {
        label = "Eat from the hand",
        dict = "mech_inventory@clothing@bandana", name = "NECK_2_FACE_RH",
        duration = 5300,
        prop = {bone = "SKEL_R_HAND", offset = {x = 0.08, y = -0.04, z = -0.05}, rotation = {x = -75.0, y = 0.0, z = 0.0}},
    },
    bandage = {
        label = "Bandage",
        dict = "mini_games@story@mob4@heal_jules@bandage@arthur", name = "tourniquet_slow",
        duration = 6000,
        prop = {model = "p_cs_bandage01x", bone = "SKEL_L_HAND", offset = {x = 0.10, y = 0.0, z = 0.03}, rotation = {x = 0.0, y = -60.0, z = -90.0}},
    },
    syringe = {
        label = "Syringe",
        dict = "mech_inventory@item@stimulants@inject@quick", name = "quick_stimulant_inject_lhand",
        duration = 2000,
        prop = {model = "mp007_p_mp_syringe01x_1", bone = "SKEL_L_HAND", offset = {x = 0.10, y = 0.0, z = 0.03}, rotation = {x = 0.0, y = -80.0, z = -90.0}},
    },
    coffee = {
        label = "Sip from a mug",
        scripted = "coffee",
        duration = 60000, -- the most it can take, the player stops sipping sooner
        prop = {model = "p_mugcoffee01x"},
    },
    stew = {
        label = "Eat from a bowl",
        scripted = "stew",
        duration = 60000,
        prop = {model = "p_bowl04x_stew"},
    },
    cigar = {
        label = "Smoke a cigar",
        smoke = "cigar",
        useTime = 5000,
        blockWeapons = true,
        prop = {model = "p_cigar01x", bone = "SKEL_R_Finger12", offset = {x = 0.01, y = -0.005, z = 0.0155}, rotation = {x = 0.024, y = 300.0, z = -40.0}},
    },
    cigarette = {
        label = "Smoke a cigarette",
        smoke = "cigarette",
        useTime = 8500,
        prop = {model = "p_cigarette01x"}, -- moved between mouth and hand by the animation
    },
    pipe = {
        label = "Smoke a pipe",
        smoke = "pipe",
        useTime = 8500,
        blockWeapons = true,
        prop = {model = "p_pipe01x", bone = "SKEL_R_Finger13", offset = {x = 0.005, y = -0.045, z = 0.0}, rotation = {x = -170.0, y = 10.0, z = -15.0}},
    },
    chew = {
        label = "Chew tobacco",
        smoke = "chew",
        prop = {model = "s_tobaccotin01x"}, -- the tin, only out while taking a pinch. Each chew lasts as long as its animation
    },
    none = {
        label = "Nothing",
        none = true,
    },
}

-- Prompts while smoking or chewing (RedM control names)
Config.SmokeKeys = {
    use = "INPUT_CONTEXT_RT", -- take a puff
    stop = "INPUT_CONTEXT_B", -- put it away
    stance = "INPUT_CONTEXT_Y", -- change how you stand
}
-- Controls blocked while smoking with an animation that has blockWeapons
Config.SmokeBlockedControls = {"INPUT_ATTACK", "INPUT_AIM", "INPUT_MELEE_ATTACK", "INPUT_SPECIAL_ABILITY", "INPUT_SPRINT", "INPUT_JUMP"}
Config.DefaultAnimation = "interaction"

-- Suggestions in the admin panel. Any name can be typed, these are just the known good ones
Config.Bones = {"SKEL_R_HAND", "SKEL_L_HAND", "SKEL_R_Finger12", "SKEL_R_Finger13", "SKEL_L_Finger12", "SKEL_Head"}
-- Config.ScreenEffects (screen effect names) is in shared/screeneffects.lua
Config.Timecycles = {"PlayerDrunk01", "LensDistDrunk", "EagleEyeDark"}
Config.CameraShakes = {"SMALL_EXPLOSION_SHAKE", "MEDIUM_EXPLOSION_SHAKE", "LARGE_EXPLOSION_SHAKE", "DRUNK_SHAKE", "HAND_SHAKE", "JOLT_SHAKE", "VIBRATE_SHAKE"}

-- Alcohol. Each consumable adds its alcohol level; it wears off over time
Config.Drunk = {
    Drunk = 100, -- Above this the player wobbles and sees the drunk screen effect
    PassOut = 350, -- Above this the player throws up and passes out, then wakes up just drunk
    SoberDrunk = 2, -- Seconds for one point of alcohol to wear off while drunk
    SoberTipsy = 5, -- ... and while below the drunk level
    Wobble = 0.95, -- How drunk the player walks (0 - 1)
    ScreenEffect = "PlayerDrunk01",
}

--- Changes hunger, thirst, stress and metabolism. Runs on the client.
--- Values are what a consumable gives: hunger / thirst / stress 0 - 100 (stress is relief: 10 = 10 less stress),
--- metabolism -1000 (skinny) to 1000 (fat). Swap this out for another metabolism script
--- @param status table {hunger = number, thirst = number, stress = number, metabolism = number}
Config.ApplyStatus = function(status)
    local keys = {hunger = "Hunger", thirst = "Thirst", stress = "Stress", metabolism = "Metabolism"}
    for key, value in pairs(status) do
        if value ~= 0 and keys[key] then
            if key == "stress" then value = -value end
            TriggerEvent("vorpmetabolism:changeValue", keys[key], value * 10)
        end
    end
end
