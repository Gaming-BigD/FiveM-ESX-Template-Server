local isneu = false
local inMenu = false
local cooldown = 0
ESX = nil


Citizen.CreateThread(function()
	while ESX == nil do
    if Config.SharedObject == "trigger" then
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    else
      return nil
    end
    if Config.SharedObject == "export" then
      ESX = exports["es_extended"]:getSharedObject()
    else
      return nil
    end
		Citizen.Wait(0)
	end
end)

RegisterNetEvent("gs:Regelwerkmenu") 
AddEventHandler("gs:Regelwerkmenu", function(neu)
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
