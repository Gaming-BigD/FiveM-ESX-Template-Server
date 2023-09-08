function Notify(bool, message)
	SendNUIMessage({
		type = "sendnotification",
		status = bool,
	})

	SendNUIMessage({action = 'message', value = message})
end

RegisterNetEvent("gs_coreonAnnounce:Announce")
AddEventHandler("gs_coreonAnnounce:Announce", function(message, duration)
	PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
	Notify(false) 
	Notify(not display, message)
	Citizen.Wait(duration)
	Notify(false)
end)

