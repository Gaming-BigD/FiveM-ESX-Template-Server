function Notify(bool, message)
	SendNUIMessage({
		type = "sendnotification",
		status = bool,
	})

	SendNUIMessage({action = 'message', value = message})
end

function Close()
	SendNUIMessage({
		action = 'close'
	})
end

RegisterNetEvent("gs_textui:Open")
AddEventHandler("gs_textui:Open", function(message)
	PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
	Notify(false) 
	Notify(not display, message)
	Notify(false)
end)


RegisterNetEvent('gs_textui:TextUIClose')
AddEventHandler('gs_textui:TextUIClose', function()
	Close()
end)