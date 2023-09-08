
-- ====================================================================================
--                                    RoadToSix 
-- ====================================================================================


ESX.RegisterServerCallback('roadphone:getItemAmount', function(source, cb)

    local hasItem = nil

    if Config.NeedItem then
        if #Config.Items == 0 then
            cb(nil)
            return
        end
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return; end
        for i = 1, #Config.Items, 1 do

            if Config.oxInventory then
                local items = exports.ox_inventory:GetItemCount(source, Config.Items[i])

                if items then
                    cb(Config.Items[i])
                    return
                end
            end

            local items = xPlayer.getInventoryItem(Config.Items[i])
            if not items then
                print("Error: Item " .. Config.Items[i] .. " not found in database. Please add this item in your database.")
                cb(nil)
                return
            end
            if items.count > 0 then
                hasItem = items.name
                cb(hasItem)
                return
            end
        end
        cb(nil)
    else
        cb(true)
    end
end)

ESX.RegisterServerCallback('roadphone:getRadioAmount', function(source, cb)
    if Config.RadioNeedItem then
        if #Config.RadioItems == 0 then
            cb(nil)
            return
        end
        local xPlayer = ESX.GetPlayerFromId(source)
        if not xPlayer then return; end
        for i = 1, #Config.RadioItems, 1 do
            if Config.oxInventory then
                local items = exports.ox_inventory:GetItemCount(source, Config.RadioItems[i])

                if items then
                    cb(true)
                    return
                end
            end

            local items = xPlayer.getInventoryItem(Config.RadioItems[i])
            if not items then
                print("Error: Item " .. Config.RadioItems[i] .. " not found in database. Please add this item in your database.")
                cb(nil)
                return
            end
            if items.count > 0 then
                cb(true)
                return
            end
        end
        cb(nil)
    else
        cb(true)
    end
end)

function getPhoneRandomNumber()
    local numBase = math.random(1000000, 9999999)
    return string.format("%07d", numBase)
end


CreateThread(function()
    for i = 1, #Config.Items do
        ESX.RegisterUsableItem(Config.Items[i], function(source)
            TriggerClientEvent('roadphone:use', source)
        end)
    end
end)

RegisterCommand('fixphone', function(source)
    TriggerEvent('roadphone:playerLoad', source)
end)


function GetPlayerFromPhone(number)
    local identifier = MySQL.Sync.fetchScalar('SELECT identifier FROM ' .. Config.UserTable .. ' WHERE phone_number = @phone_number', {['@phone_number'] = number})

    return ESX.GetPlayerFromIdentifier(identifier)
end

function getJobName(identifier)

    local xPlayer = ESX.GetPlayerFromIdentifier(identifier)

    return xPlayer.job.name

end

function getNumberFromIdentifier(identifier)

    local phone_number = MySQL.Sync.fetchScalar('SELECT phone_number FROM ' .. Config.UserTable .. ' WHERE identifier = @identifier', {['@identifier'] = identifier})

    return phone_number

end

function getIdentifierFromNumber(number)

    local identifier = MySQL.Sync.fetchScalar('SELECT identifier FROM ' .. Config.UserTable .. ' WHERE phone_number = @phone_number', {['@phone_number'] = number})

    return identifier

end

function getNameFromIdentifier(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.firstname, users.lastname FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] then
        return result[1]['firstname'] .. ' ' .. result[1]['lastname']
    end

    return nil
end


function getNameFromIdentifierTable(identifier)
    local result = MySQL.Sync.fetchAll("SELECT users.firstname, users.lastname FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
    if result[1] then
        return {
            firstname = result[1]['firstname'],
            lastname = result[1]['lastname']
        }
    end

    return nil
end

function getPlayersByJob(job)

    if Config.ESXVersion == 'Legacy' then

        local players = {}

        local xPlayers = ESX.GetExtendedPlayers('job', job) --newer effecient way to get players by job ( only available in ESX Legacy )

        for k, v in pairs(xPlayers) do
            table.insert(players, {id = v.source})
        end

        return players
    else

        local players = {}

        for k, playerId in pairs(ESX.GetPlayers()) do
            local Player = ESX.GetPlayerFromId(playerId)

            if Player and Player.job.name == job then
                table.insert(players, {id = Player.source})
            end
        end

        return players

    end
end

AddEventHandler('esx:playerLoaded', function(playerId, xPlayer)
    Wait(5000)
    TriggerEvent("roadphone:playerLoad", playerId)
end)


RegisterNetEvent('roadphone:sendDispatch')
AddEventHandler('roadphone:sendDispatch', function(source, message, job, position, anonym)
    local sourcePlayer = tonumber(source)
    local xPlayer = ESX.GetPlayerFromId(sourcePlayer)

    if xPlayer then
        if not job or not message then
            return
        end
    
        local myPhone = getNumberFromIdentifier(xPlayer.identifier)

        local gps = 'GPS: ' .. position.x .. ', ' .. position.y

        local targetmessage = addServiceMessage(myPhone, job, "DISPATCH: " .. message, 0, 0)
        local targetmessage2 = addServiceMessage(myPhone, job, gps, 0, 0)

        local mymessage = addServiceMessage(job, myPhone, "DISPATCH: " .. message, 1, 1)
        
        local targets = getPlayersByJob(job)
    
        for _, target in pairs(targets) do
            local skipsound = false

            if(target.id == sourcePlayer) then
                skipsound = true
            end

            TriggerClientEvent("roadphone:service:receiveMessage:job", target.id, targetmessage, 0, skipsound)
            TriggerClientEvent("roadphone:service:receiveMessage:job", target.id, targetmessage2, 0, true)
        end
        
        TriggerClientEvent("roadphone:service:receiveMessage", sourcePlayer, mymessage,  1)

        discordLog("15158332", "Service", 'Number: ' .. myPhone .. '\n' .. 'Message: ' .. message .. '\n' .. 'Received Job: ' .. job, "RoadPhone", nil, Cfg.ServiceWebhook, "Service")
    end
end)


RegisterCommand(Config.TwitterVerifyCommand, function(source, args)
    local src = source
    
    if #args < 2 then
        TriggerClientEvent('roadphone:sendOffNotification', src, _U('command_required_information'))
        return
    end
    
    local auth = args[1]
    table.remove(args, 1)
    
    local label = table.concat(args, ' ')
    
    local verifyValue = auth == "true" and 1 or 0
    local query = "UPDATE `roadshop_twitter_accounts` SET `verify`= @verifyValue WHERE roadshop_twitter_accounts.username = @username"
    
    MySQL.Async.execute(query, {
        ['@verifyValue'] = verifyValue,
        ['@username'] = label
    }, function(result)
        if (result == 1) then
            local message = verifyValue == 1 and _U('twitter_verify') or _U('twitter_remove_verify')
            TriggerClientEvent('roadphone:sendOffNotification', src, message)
        else
            TriggerClientEvent('roadphone:sendOffNotification', src, _U('command_required_information'))
        end
    end)
end, true)


RegisterServerEvent("roadphone:server:call:eventnumber")
AddEventHandler("roadphone:server:call:eventnumber", function(number)

    if tostring(number) == "77777" then --CHECK WHICH NUMBER IS CALLED

        --YOUR CODE
        
    end

end)


--WEBHOOKS

function discordLog(color, name, message, footer, image, webhook, username)

    if not message then
        message = ''
    end

    if not username then username = 'RoadPhone' end

    local embed;

    if image then
        embed = {
            {
                ["color"] = color,
                ["title"] = "**" .. name .. "**",
                ["description"] = message,
                ["image"] = {url = image},
                ["footer"] = {["text"] = footer}
            }
        }
    else
        embed = {
            {
                ["color"] = color,
                ["title"] = "**" .. name .. "**",
                ["description"] = message,
                ["footer"] = {["text"] = footer}
            }
        }
    end

    if webhook == 'DISCORD WEBHOOK' then return end

    PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = username, embeds = embed}), {['Content-Type'] = 'application/json'})

end