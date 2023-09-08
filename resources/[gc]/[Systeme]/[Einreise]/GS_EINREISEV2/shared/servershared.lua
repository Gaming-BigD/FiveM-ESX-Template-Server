ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterCommand("einreise", function(source, args)
    local _source = source
    local einreiseID = table.concat(args, " ")
    local xPlayer = ESX.GetPlayerFromId(_source)
    local zPlayer = ESX.GetPlayerFromId(einreiseID)
	
	local teamler = GetPlayerName(_source)
	local eingereister = GetPlayerName(einreiseID)

    if xPlayer.getGroup() == "einreise" or xPlayer.getGroup() == "teamleitung" or xPlayer.getGroup() == "support" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "projektmangager" or xPlayer.getGroup() == "frakleitung" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "owner" then
        TriggerClientEvent('okokNotify:Alert', einreiseID, "Einreise", Config.Einreisetext, 5000, 'success')

        if Config.NotifySystem == GS then
            TriggerClientEvent('gs_notification:notify', source, Config.EinreiseMessage, 6000)
        else
            
            zPlayer.showNotification(Config.EinreiseMessage, false, true, '~w~')
        end




        TriggerClientEvent('gs:flughafentp', zPlayer.source)
        TriggerClientEvent("gs:isneu", einreiseID, false) 
		
		sendEinreiselog('Einreise','Teamler: ```' .. teamler .. '(' .. source .. ')```hat folgenden Spieler eingereist:```' .. eingereister .. '```',38656)
		
        MySQL.Sync.execute("UPDATE users SET neu = 0 WHERE identifier = @identifier", {
            ['@identifier'] = zPlayer.identifier
        })
    else
        TriggerClientEvent('okokNotify:Alert', source, "Einreise", "Dazu hast du keine Berechtigung", 2500, 'error')
    end
end)


RegisterServerEvent('gs:CallNotify')
AddEventHandler('gs:CallNotify', function(message)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    for k, v in pairs(GetPlayers()) do
        local xPlayerAdmin = ESX.GetPlayerFromId(v)
        local targetGroup = xPlayerAdmin.getGroup()
        if targetGroup == "einreise" or targetGroup == "teamleitung" or targetGroup == "support" or targetGroup == "mod" or targetGroup == "projektmangager" or targetGroup == "frakleitung" or targetGroup == "supporter" or targetGroup == "admin" or targetGroup == "superadmin" or targetGroup == "owner" then
            if Config.NotifySystem == GS then
                TriggerClientEvent('gs_notification:notify', xPlayer.source, Config.Einreisehilfe, 6000)
            else
                xPlayerAdmin.showNotification(Config.Einreisehilfe, false, true, '~w~')
    
                
            end
        end
    end

end)