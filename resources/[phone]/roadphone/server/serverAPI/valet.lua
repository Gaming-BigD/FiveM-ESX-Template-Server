ESX.RegisterServerCallback("roadphone:valet:getCars", function(source, cb)

    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return;
    end

    MySQL.Async.fetchAll("SELECT * FROM " .. Config.OwnedVehiclesTable .. " WHERE `owner` = @identifier and type = @type", {
        ['@identifier'] = xPlayer.identifier,
        ['@type'] = "car"
    }, function(result)
        local cachedvehicles = {}

        for i = 1, #result do

            local Garage = "None"
            local State = _U('valet_state_default')

            table.insert(cachedvehicles, {
                plate = result[i].plate,
                vehicle = json.decode(result[i].vehicle),
                garage = Garage,
                state = State
            })

        end

        cb(cachedvehicles)

    end)

end)

ESX.RegisterServerCallback('roadphone:valet:loadVehicle', function(source, cb, plate)

    local valetCheck = valetServerSideCheck(plate)

    if valetCheck ~= false then
        cb(false, valetCheck)
        return;
    end

    MySQL.Async.fetchAll('SELECT * FROM ' .. Config.OwnedVehiclesTable .. ' WHERE `plate` = @plate', {
        ['@plate'] = plate
    }, function(vehicle)
        cb(vehicle)
    end)
end)

ESX.RegisterServerCallback('roadphone:valet:checkMoney', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then
        return;
    end

    if xPlayer.getAccount('bank').money > Config.ValetDeliveryPrice then
        xPlayer.removeAccountMoney('bank', Config.ValetDeliveryPrice)

        local number = getNumberFromIdentifier(xPlayer.identifier)

        TriggerEvent("roadphone:addBankTransfer", number, 0,  _U('valet_car_delivered'), Config.ValetDeliveryPrice)

        TriggerClientEvent("roadphone:sendNotification", source, {
            apptitle = "APP_VALET_NAME",
            title = "APP_VALET_CAR_ONTHEWAY",
            img = "/public/img/Apps/valet.jpg"
        })

        discordLog("9807270", "Valet", xPlayer.getName() .. ' ' .. _U('valet_car_delivered_2', Config.ValetDeliveryPrice), 'RoadPhone - Valet', nil, Cfg.ValetWebhook)
        cb(true)
        return;
    else
        TriggerClientEvent("roadphone:sendNotification", source, {
            apptitle = "APP_VALET_NAME",
            title = "APP_VALET_NOTENOUGHMONEY",
            img = "/public/img/Apps/valet.jpg"
        })

        cb(false)
        return;
    end

end)

RegisterServerEvent("roadphone:valetCarSetOutside")
AddEventHandler("roadphone:valetCarSetOutside", function(plate)
    
    if Config.cdGarages then
        MySQL.Async.execute('UPDATE '..Config.OwnedVehiclesTable..' SET `in_garage` = @in_garage WHERE `plate` = @plate', {
          ['@plate'] = plate,
          ['@in_garage'] = 0,
        })
        return
    end

    MySQL.Async.execute("UPDATE " .. Config.OwnedVehiclesTable .. " SET `stored` = @stored WHERE `plate` = @plate", {
        ["@plate"] = plate,
        ["@stored"] = 0
    })
end)
