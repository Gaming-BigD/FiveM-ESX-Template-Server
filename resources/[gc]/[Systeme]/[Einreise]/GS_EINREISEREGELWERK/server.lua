ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source)
    local _source = source
    local xPlayerz = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local steamname = GetPlayerName(_source)
        MySQL.Async.fetchAll('SELECT neu FROM users WHERE identifier = @identifier', {['@identifier'] = xPlayerz.identifier}, function(result)
            if result[1] then
                local resultfrommysql = json.encode(result[1].neu)
                local resultfrommysql2 = result[1].neu
                if resultfrommysql2 == "1" then
                    for i=1, #xPlayers, 1 do
                        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
                        if xPlayer.getGroup() == "einreise" or xPlayer.getGroup() == "teamleitung" or xPlayer.getGroup() == "mod" or xPlayer.getGroup() == "projektmangager" or xPlayer.getGroup() == "frakleitung" or xPlayer.getGroup() == "supporter" or xPlayer.getGroup() == "admin" or xPlayer.getGroup() == "superadmin" or xPlayer.getGroup() == "owner" then
							TriggerClientEvent('okokNotify:Alert', xPlayer.source, "EINREISE", "Ein neuer Spieler ist in der Einreise", 2550, 'info')
							TriggerClientEvent('notifications', xPlayer.source, "#ff0000", "Neuer Spieler in der Einreise: " .. steamname .. " | ID: " .. source)
                        end
                    end
                    TriggerClientEvent("gs:isneu", _source, true)
                elseif result[1].neu == "0" then
                    TriggerClientEvent("gs:isneu", _source, false)
                end
            end
        end)
end)

