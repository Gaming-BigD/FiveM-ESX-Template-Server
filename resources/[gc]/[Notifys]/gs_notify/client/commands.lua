RegisterCommand("id", function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1)
	TriggerEvent('gs_notification:notify', "Deine ID ist die Nummer: " ..GetPlayerServerId(PlayerId()).. " ", 6000)
end)

RegisterCommand("Hilfe", function(source, args, rawCommand)
    local playerPed = GetPlayerPed(-1)
	TriggerEvent('gs_notification:notify', "Falls du Hilfe benötigst Kontaktiere uns im Discord oder benutze den Ingame Support mit /Calladmin", 6000)
end)