ESX = nil
local IsDead = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNUICallback("button", function(data)
    SendNUIMessage({action = 'hidebutton'})

    -- Hier deinen Dispatch trigger einfügen!
    TriggerEvent('gs_notification:notify', 'Du hast einen Krankenwagen angefordert!', 6000)

 
    SetNuiFocus(false, false)
end)


function RemoveItemsAfterRPDeath()
	TriggerServerEvent('gs_deathui:setDeathStatus', false)



	Citizen.CreateThread(function()
		Citizen.Wait(10)
		ESX.TriggerServerCallback('gs_deathui:removeItemsAfterRPDeath', function()
			ESX.SetPlayerData('loadout', {})

		end)
	end)
end


function respawn()


	-- Hier noch einfügen was entfernt werden soll!
	RemoveItemsAfterRPDeath()


    SetDisplay(false, false)
	SetEntityCoordsNoOffset(PlayerPedId(), GlobalState.RespawnCoords, false, false, false, true)
    NetworkResurrectLocalPlayer(GlobalState.RespawnCoords, GlobalState.RespawnHeading, true, false)
	SetPlayerInvincible(PlayerPedId(), false)
	ClearPedBloodDamage(PlayerPedId())
end

