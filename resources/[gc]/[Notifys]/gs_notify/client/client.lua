function Notify(bool, message)
	SendNUIMessage({
		type = "sendnotification",
		status = bool,
	})

	SendNUIMessage({action = 'message', value = message})
end

RegisterNetEvent("gs_notification:notify")
AddEventHandler("gs_notification:notify", function(message, duration)
	PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
	Notify(false) 
	Notify(not display, message) 
	
	Citizen.Wait(duration)
	Notify(false)
end)

