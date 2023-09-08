function Notify(bool, message)
	SendNUIMessage({
		type = "sendnotification",
		status = bool,
	})

	SendNUIMessage({action = 'message', value = message})
end

RegisterNetEvent("gs_warningnotification:notify")
AddEventHandler("gs_warningnotification:notify", function(message, duration)
	PlaySoundFrontend(-1, "5_Second_Timer", "DLC_HEISTS_GENERAL_FRONTEND_SOUNDS", 1)
	Notify(false) -- disable the notification that (if) is already being showed
	Notify(not display, message) -- show the new one
	Citizen.Wait(duration)
	Notify(false)
end)

RegisterCommand("testwarn", function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1)
	TriggerEvent('gs_warningnotification:notify', "Dies ist eine Testnaricht um euch zu zeigen wie es aussieht wenn jemand verwarnt werden würde! Dieses Skript ist ganz einfach in andere Skripts einzubinden!", 6000)
end)