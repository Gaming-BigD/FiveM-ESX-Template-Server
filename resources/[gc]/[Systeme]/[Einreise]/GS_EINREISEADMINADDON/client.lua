
ESX = nil
local anzug = 0
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("gs_adminmenu:menuopen") 
AddEventHandler("gs_adminmenu:menuopen", function(neu)
    showUI()
end)


function showUI()
    SetNuiFocus(true, true)

    SendNUIMessage({
        type = "show",
        status = true,
    })

    inMenu = true
end

function closeUI()
    SetNuiFocus(false, false)

    SendNUIMessage({
        type = "show",
        status = false,
    })

    inMenu = false
end

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)

    inMenu = false
end)

RegisterNUICallback("buttonrein", function(data)
    SetNuiFocus(false, false)

    local playerPed = PlayerPedId()
    ESX.Game.Teleport(playerPed, Config.Rein, function()
    end)

    if Config.NotifySystem == GS then
        TriggerEvent('gs_notification:notify', Config.ReinTP, 6000) 
    else
        SetNotificationTextEntry("STRING")
        AddTextComponentString(Config.ReinTP)
        DrawNotification(1)	  
    end
        
    closeUI()

    inMenu = false
end)

RegisterNUICallback("buttonraus", function(data)
    SetNuiFocus(false, false)

    local playerPed = PlayerPedId()

    ESX.Game.Teleport(playerPed, Config.Raus, function()
    end)

    if Config.NotifySystem == GS then
        TriggerEvent('gs_notification:notify', Config.RausTP, 6000) 
    else
        SetNotificationTextEntry("STRING")
        AddTextComponentString(Config.RausTP)
        DrawNotification(1)	  
    end
    
    Citizen.Wait(1)

    closeUI()

    inMenu = false
end)

--Kleidungsbutton


function setUniform(kleidung)
    local playerPed = PlayerPedId()

    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if group ~= "user" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Einreiseoutfit.male)
            end
        else
            if group ~= "user" then
                TriggerEvent("skinchanger:loadClothes", skin, Config.Einreiseoutfit.female)
            end
        end
    end)
end

RegisterNUICallback("buttonkleidung", function(data)
    local playerPed = PlayerPedId()
    SetNuiFocus(false, false)


    if anzug == 0 then
        setUniform(kleidung)
        anzug = anzug + 1
        if Config.NotifySystem == GS then
            TriggerEvent('gs_notification:notify', Config.UniformAN, 6000)
        else
            SetNotificationTextEntry("STRING")
            AddTextComponentString(Config.UniformAN)
            DrawNotification(1)	       
        end

        closeUI()
    
    elseif anzug == 1 then
        ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
            TriggerEvent('skinchanger:loadSkin', skin)
            
            print('TESTPRINT')
        end)
        anzug = anzug - 1
        closeUI()
        

        if Config.NotifySystem == GS then
            TriggerEvent('gs_notification:notify', Config.UniformAUS, 6000)
        else      
            SetNotificationTextEntry("STRING")
            AddTextComponentString(Config.UniformAUS)
            DrawNotification(1)	    
        end

    end
    inMenu = false
end)


