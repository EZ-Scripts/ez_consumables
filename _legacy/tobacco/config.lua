Config = {}

Config.Debug = false -- Set to true to enable debug messages

Config.ExecuteStatus = function(status)
    for k, v in pairs(status) do
        if k == "Stress" then
            v = v * -1
        end
        TriggerEvent("vorpmetabolism:changeValue", k, v*10)
    end
end

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

Config.Tobacco = {
    chewingtobacco = {
        type = "Chewingtobacco",
        numOfUse = 10,
        metabolism = { -- Each time you smoke
            Stress = 5,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewingtobacco.numOfUse then
            end
        end
    },
    cigarette = {
        type = "Cigarette",
        numOfUse = 10,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 10,
            Metabolism = -10,
        },
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigarette.numOfUse then
            end
        end
    },
    chewing_snail = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_snail.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar = {
        type = "Cigar",
        numOfUse = 7,
        timePerUse = 4000,
        metabolism = { -- Each time you smoke
            Stress = 10,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 500.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 500.0, true)
            end
        end
    },
    cigar_wacky = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_wacky.numOfUse then
                Config.Effects.vintageEye(10)
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_sneaky_reserve = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_sneaky_reserve.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_razzmatazz = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_razzmatazz.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_redfield = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_redfield.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_honeygold = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_honeygold.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_orangeblossom = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_orangeblossom.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_velvet = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_velvet.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_birdwatchers = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_birdwatchers.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_goldenwatcher = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_goldenwatcher.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_jailbird = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_jailbird.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_jailbird_2 = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_jailbird_2.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_majou = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_majou.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_fish = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_fish.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_russellreserve = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_russellreserve.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    chewing_tobaccoblazing = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_tobaccoblazing.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    chewing_montana_grapeshot = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_montana_grapeshot.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    bfrp_chewing_tobacco = {
        type = "Chewingtobacco",
        numOfUse = 1,
        metabolism = { -- Each time you smoke
            Stress = 100,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.bfrp_chewing_tobacco.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    chewing_tobaccorebel = {
        type = "Chewingtobacco",
        prop = "P_CIGAR02X",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.chewing_tobaccorebel.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    chewing_johns_wintergreen = {
        type = "Chewingtobacco",
        prop = "P_CIGAR02X",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.chewing_johns_wintergreen.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    chewing_peachy_skies = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_peachy_skies.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_halloween = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 1,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 100,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_halloween.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
     seasonal_cigar_firecracker = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 2,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 50,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.seasonal_cigar_firecracker.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    bfrp_cigar = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 1,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 100,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.bfrp_cigar.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_shamrock_smoke = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 1,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 100,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_shamrock_smoke.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_purpleraindrop = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_purpleraindrop.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    joint_doobie = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.joint_doobie.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
                Config.Effects.high(60)
            end
        end
    },
     medical_nativespliff = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.medical_nativespliff.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
                Config.Effects.high(60)
            end
        end
    },
    medical_nativesmudge = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.medical_nativesmudge.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
                Config.Effects.high(60)
            end
        end
    },
    cigar_gatorwrap = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_gatorwrap.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_obsidiancrown = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_obsidiancrown.numOfUse then
                Config.Effects.vintageEye(10)
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_blackhill = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_blackhill.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },



-- ARMADILLO SMOKESHOP
    cigar_bobs_last = {
            type = "Cigar",
            prop = "P_CIGAR02X",
            numOfUse = 5,
            timePerUse = 5000,
            metabolism = { -- Each time you smoke
                Stress = 20,
            },
            disableAction = true,
            onComplete = function(uses) -- uses is the number of times used
                if uses >= Config.Tobacco.cigar_bobs_last.numOfUse then
                    local ped = PlayerPedId()
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

                end
            end
        },
    cigar_justice_sundown = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_justice_sundown.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },


-- SEASONAL SMOKEHOP


    cigar_cinna_me_rollin = {
            type = "Cigar",
            prop = "P_CIGAR02X",
            numOfUse = 5,
            timePerUse = 5000,
            metabolism = { -- Each time you smoke
                Stress = 20,
            },
            disableAction = true,
            onComplete = function(uses) -- uses is the number of times used
                if uses >= Config.Tobacco.cigar_cinna_me_rollin.numOfUse then
                    local ped = PlayerPedId()
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

                end
            end
        },
    cigar_harvest_haze = {
            type = "Cigar",
            prop = "P_CIGAR02X",
            numOfUse = 5,
            timePerUse = 5000,
            metabolism = { -- Each time you smoke
                Stress = 20,
            },
            disableAction = true,
            onComplete = function(uses) -- uses is the number of times used
                if uses >= Config.Tobacco.cigar_harvest_haze.numOfUse then
                    local ped = PlayerPedId()
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

                end
            end
        },
    cigar_taffy_apple = {
            type = "Cigar",
            prop = "P_CIGAR02X",
            numOfUse = 5,
            timePerUse = 5000,
            metabolism = { -- Each time you smoke
                Stress = 20,
            },
            disableAction = true,
            onComplete = function(uses) -- uses is the number of times used
                if uses >= Config.Tobacco.cigar_taffy_apple.numOfUse then
                    local ped = PlayerPedId()
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

                end
            end
        },

        cigar_blitzenroll = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_blitzenroll.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
        cigar_santaspark = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_santaspark.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
        cigar_event_pepermint = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 2,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 50,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_event_pepermint.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
        cigar_pepermintpuffer = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_pepermintpuffer.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
        cigar_nasty = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_nasty.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_bundle_goldmoney = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 2,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 50,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_bundle_goldmoney.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_santofuego = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_santofuego.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_doctorsdream = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_doctorsdream.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_hot_fudge  = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_hot_fudge .numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_plataplomo = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_plataplomo.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_hamishs_stoagie = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_hamishs_stoagie.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
     cigar_creek_water = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_creek_water.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
     cigar_cloudnine = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_cloudnine.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_midnight_magic = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_midnight_magic.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_trooperblend = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_trooperblend.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_montana_magic = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_montana_magic.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    chewing_alabama_finecut = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_alabama_finecut.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    chewing_lip_rippa = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_lip_rippa.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_crimsonfang = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_crimsonfang.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_purplehearts = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_purplehearts.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_bkblend = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_bkblend.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_candycane = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_candycane.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    officer_cigar = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.officer_cigar.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },

    cigar_blazing = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_blazing.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    blackrifle_cigar = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.blackrifle_cigar.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    valentine_cigar = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.valentine_cigar.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_sundropkiss = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_sundropkiss.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_frontiersplash = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_frontiersplash.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_prairieblossom = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_prairieblossom.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_greenreaper = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_greenreaper.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_honeybeez = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_honeybeez.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_sweet_mercy = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_sweet_mercy.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_cottoncandy_reserve = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_cottoncandy_reserve.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_montana_bleeder = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_montana_bleeder.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    hughport_cig = {
        type = "Cigarette",
        numOfUse = 3,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 35,
            Metabolism = -20,
        },
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.hughport_cig.numOfUse then
            end
        end
    },
    cowboy_cig = {
        type = "Cigarette",
        numOfUse = 3,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 35,
            Metabolism = -20,
        },
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cowboy_cig.numOfUse then
            end
        end
    },
    cigarette_howlers = {
        type = "Cigarette",
        numOfUse = 3,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 35,
            Metabolism = -20,
        },
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigarette_howlers.numOfUse then
            end
        end
    },
    chocolate_cigar = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.chocolate_cigar.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_candys_temptation = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_candys_temptation.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
               
            end
        end
    },
    cigar_copium = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_copium.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    tobacco_tin = {
        type = "Pipe",
        numOfUse = 10,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        requiredItems = {
            {item = "pipe", count = 1},
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.tobacco_tin.numOfUse then
            end
        end
    },
     tobacco_montana_wolfcut = {
        type = "Pipe",
        numOfUse = 6,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
        Stress = 20,
        },
        requiredItems = {
            {item = "pipe_back_alley", count = 1},
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.tobacco_montana_wolfcut.numOfUse then
            end
        end
    },
    syn = {
        type = "Pipe",
        numOfUse = 6,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 20,
            Metabolism = -20,
        },
        requiredItems = {
            {item = "pipe", count = 1},
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.syn.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1500.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1500.0, true)
                Config.Effects.high(60)
            end
        end
    },
    tiny_weed = {
        type = "Pipe",
        numOfUse = 6,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 20,
            Metabolism = -20,
        },
        requiredItems = {
            {item = "twig_pipe", count = 1},
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.tiny_weed.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1500.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1500.0, true)
                Config.Effects.high(60)
            end
        end
    },
    weed_bongwater = {
        type = "Pipe",
        numOfUse = 6,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 20,
            Metabolism = -20,
        },
        requiredItems = {
            {item = "pipe_lonewolf", count = 1},
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.weed_bongwater.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1500.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1500.0, true)
                Config.Effects.high(60)
            end
        end
    },
    purple_haze = {
        type = "Pipe",
        numOfUse = 6,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 20,
            Metabolism = -20,
        },
        requiredItems = {
            {item = "haze_pipe", count = 1},
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.purple_haze.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1500.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1500.0, true)
                 Config.Effects.high(60)
            end
        end
    },
    cigar_jb_og_kush = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_jb_og_kush.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
                Config.Effects.high(60)
            end
        end
    },
    cigar_blue_thunderbolt = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_blue_thunderbolt.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_montana_sweeper = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_montana_sweeper.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    smoke_zaza = {
        type = "Pipe",
        numOfUse = 6,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 20,
            Metabolism = -20,
        },
        requiredItems = {
            {item = "pipe", count = 1},
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.smoke_zaza.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1500.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1500.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1500.0, true)
                 Config.Effects.high(60)
            end
        end
    },
    tiny_chewing = {
        type = "Chewingtobacco",
        numOfUse = 10,
        metabolism = { -- Each time you smoke
            Stress = 10,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.tiny_chewing.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },

-- Vanhorn Smokeshop
    cigar_bayou_boss = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_bayou_boss.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    chewing_black_coffee_snuff = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_black_coffee_snuff.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    chewing_pumpkin_pouches = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_pumpkin_pouches.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
     cigar_white_lotus = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_white_lotus.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
     cigar_papaya_punch = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_papaya_punch.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_sugarplum_puff = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_sugarplum_puff.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_cherrybomb = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_cherrybomb.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_blue_dream = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_blue_dream.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_dufrene_stargazer = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_dufrene_stargazer.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
                Config.Effects.high(60)
            end
        end
    },
    cigar_angel_dust = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_angel_dust.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
                Config.Effects.high(60)
            end
        end
    },

-- Blackwater Smokeshop
 cigar_mayholms_last_ride = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_mayholms_last_ride.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_fiddle_head = {
            type = "Cigar",
            prop = "P_CIGAR02X",
            numOfUse = 5,
            timePerUse = 5000,
            metabolism = { -- Each time you smoke
                Stress = 20,
            },
            disableAction = true,
            onComplete = function(uses) -- uses is the number of times used
                if uses >= Config.Tobacco.cigar_fiddle_head.numOfUse then
                    local ped = PlayerPedId()
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

                end
            end
        },
    cigar_succubi_smokes = {
            type = "Cigar",
            prop = "P_CIGAR02X",
            numOfUse = 5,
            timePerUse = 5000,
            metabolism = { -- Each time you smoke
                Stress = 20,
            },
            disableAction = true,
            onComplete = function(uses) -- uses is the number of times used
                if uses >= Config.Tobacco.cigar_justice_sundown.numOfUse then
                    local ped = PlayerPedId()
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

                end
            end
        },
-- Armadillo Smokeshop
    cigar_sleeping_dogs_no9 = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_sleeping_dogs_no9.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_lydia_lilac = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_lydia_lilac.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_ave_maria = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_ave_maria.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
                Config.Effects.high(60)
            end
        end
    },


-- Tumbleweed Smokeshop
    cinnamon_cigar = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cinnamon_cigar.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    chewing_tobaccojohn = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_tobaccojohn.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    williesdraw_cigar = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.williesdraw_cigar.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_grizz_green_apple = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_grizz_green_apple.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
     cigar_vanilla_creme = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_vanilla_creme.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
     cigar_vice = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_vice.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
     chewing_caleb_cure = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_caleb_cure.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigarette_caleb_remedy = {
        type = "Cigarette",
        numOfUse = 3,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 35,
            Metabolism = -10,
        },
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigarette_caleb_remedy.numOfUse then
            end
        end
    },
    cigar_calebs_remedy = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_calebs_remedy.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
cigarette_coffin_nails = {
        type = "Cigarette",
        numOfUse = 3,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 35,
            Metabolism = -10,
        },
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigarette_coffin_nails.numOfUse then
            end
        end
    },
    chewing_tobaccoblazing = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_tobaccoblazing.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },
    cigar_lovegoods_lullaby = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_lovegoods_lullaby.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_jays_reserve = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_jays_reserve.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_billys_high_roller = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_billys_high_roller.numOfUse then
                Config.Effects.vintageEye(10)
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },

-- Annesburg Smokeshop
    shroomin_chewin = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.shroomin_chewin.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
                 Config.Effects.high(60)
            end
        end
    },
    cigarette_razz_matazz = {
        type = "Cigarette",
        numOfUse = 10,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 10,
            Metabolism = -10,
        },
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigarette_razz_matazz.numOfUse then
            end
        end
    },

    -- Rhodes Smokeshop
    cigar_larrys_loaded = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_larrys_loaded.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
     cigarette_raven_bones = {
        type = "Cigarette",
        numOfUse = 10,
        timePerUse = 8500,
        metabolism = { -- Each time you smoke
            Stress = 10,
            Metabolism = -10,
        },
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigarette_raven_bones.numOfUse then
            end
        end
    },

    -- Rhodes Smokeshop
    cigar_larrys_loaded = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_larrys_loaded.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_silly_loaded = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_silly_loaded.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_poppin_cherry = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_poppin_cherry.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },
    cigar_mugshot = {
        type = "Cigar",
        prop = "P_CIGAR02X",
        numOfUse = 5,
        timePerUse = 5000,
        metabolism = { -- Each time you smoke
            Stress = 20,
        },
        disableAction = true,
        onComplete = function(uses) -- uses is the number of times used
            if uses >= Config.Tobacco.cigar_mugshot.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)

            end
        end
    },

    chewing_larrys_lip_pillow = {
        type = "Chewingtobacco",
        numOfUse = 3,
        metabolism = { -- Each time you smoke
            Stress = 35,
        },
        onComplete = function(uses) -- uses is the number of times smoked
            if uses >= Config.Tobacco.chewing_tobaccojohn.numOfUse then
                local ped = PlayerPedId()
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 1, 1000.0, true)
                Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, 0, 1000.0, true)
                Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 1000.0, true)
            end
        end
    },


}
