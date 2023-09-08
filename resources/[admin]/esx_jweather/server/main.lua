------------------ change this -------------------

admins = {
    'steam:110000113a27999','steam:110000106a7bacf',
}

-- Set this to false if you don't want the weather to change automatically every 10 minutes.
DynamicWeather = false

--------------------------------------------------
debugprint = false -- don't touch this unless you know what you're doing or you're being asked by Vespura to turn this on.
--------------------------------------------------







-------------------- DON'T CHANGE THIS --------------------
AvailableWeatherTypes = {
    'EXTRASUNNY', 
    'CLEAR', 
    'NEUTRAL', 
    'SMOG', 
    'FOGGY', 
    'OVERCAST', 
    'CLOUDS', 
    'CLEARING', 
    'RAIN', 
    'THUNDER', 
    'SNOW', 
    'BLIZZARD', 
    'SNOWLIGHT', 
    'XMAS', 
    'HALLOWEEN',
}
CurrentWeather = "EXTRASUNNY"
local blackout = false
local newWeatherTimer = 360

RegisterServerEvent('jweather:requestSync')
AddEventHandler('jweather:requestSync', function()
    TriggerClientEvent('jweather:updateWeather', -1, CurrentWeather, blackout)
end)

function isAllowedToChange(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if debugprint then print('admin id: ' .. id .. '\nplayer id:' .. pid) end
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterCommand('freezeweather', function(source, args)
    if source ~= 0 then
        if isAllowedToChange(source) then
            DynamicWeather = not DynamicWeather
            if not DynamicWeather then
                TriggerClientEvent('jweather:notify', source, 'Dynamisches Wetter ist nun ~r~deaktiviert~s~.')
            else
                TriggerClientEvent('jweather:notify', source, 'Dynamisches Wetter ist nun ~b~aktiviert~s~.')
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Fehler: ^1Keine Berechtigung ^2[esx_jweather]')
        end
    else
        DynamicWeather = not DynamicWeather
        if not DynamicWeather then
            print("Wetter ist nun eingefroren")
        else
            print("Wetter ist nun nicht mehr eingefroren")
        end
    end
end)

RegisterCommand('weather', function(source, args)
    if source == 0 then
        local validWeatherType = false
        if args[1] == nil then
            print("Unbekannter Befehl, Korrekt ist: /weather <wettertyp> ")
            return
        else
            for i,wtype in ipairs(AvailableWeatherTypes) do
                if wtype == string.upper(args[1]) then
                    validWeatherType = true
                end
            end
            if validWeatherType then
                print("Weather has been updated.")
                CurrentWeather = string.upper(args[1])
                newWeatherTimer = 360
                TriggerEvent('jweather:requestSync')
            else
                print("Unbekannter Wettertyp, Korrekt ist: EXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN")
            end
        end
    else
        if isAllowedToChange(source) then
            local validWeatherType = false
            if args[1] == nil then
                TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Fehler: Unbekannter Befehl, Korrekt ist: /weather <wettertyp> ')
            else
                for i,wtype in ipairs(AvailableWeatherTypes) do
                    if wtype == string.upper(args[1]) then
                        validWeatherType = true
                    end
                end
                if validWeatherType then
                    TriggerClientEvent('jweather:notify', source, 'Wetter formiert sich zu: ~y~' .. string.lower(args[1]) .. "~s~.")
                    CurrentWeather = string.upper(args[1])
                    newWeatherTimer = 360
                    TriggerEvent('jweather:requestSync')
                else
                    TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Fehler: ^1Unbekannter Wettertyp, Korrekt ist: EXTRASUNNY CLEAR NEUTRAL SMOG FOGGY OVERCAST CLOUDS CLEARING RAIN THUNDER SNOW BLIZZARD SNOWLIGHT XMAS HALLOWEEN')
                end
            end
        else
            TriggerClientEvent('chatMessage', source, '', {255,255,255}, '^8Fehler: ^1Keine Berechtigung ^2[esx_jweather]')
            print('Zugriff au Command /weather verweigert.')
        end
    end
end, false)

RegisterCommand('blackout', function(source)
    if source == 0 then
        blackout = not blackout
        if blackout then
            print("Blackout ist aktiviert.")
        else
            print("Blackout ist deaktiviert.")
        end
    else
        if isAllowedToChange(source) then
            blackout = not blackout
            if blackout then
                TriggerClientEvent('jweather:notify', source, 'Blackout ist ~b~aktiviert~s~.')
            else
                TriggerClientEvent('jweather:notify', source, 'Blackout ist ~r~deaktiviert~s~.')
            end
            TriggerEvent('jweather:requestSync')
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(300000)
        TriggerClientEvent('jweather:updateWeather', -1, CurrentWeather, blackout)
    end
end)

Citizen.CreateThread(function()
    while true do
        newWeatherTimer = newWeatherTimer - 1
        Citizen.Wait(60000)
        if newWeatherTimer == 0 then
            if DynamicWeather then
                NextWeatherStage()
            end
            newWeatherTimer = 360
        end
    end
end)

function NextWeatherStage()
    if CurrentWeather == "CLEAR" or CurrentWeather == "CLOUDS" or CurrentWeather == "EXTRASUNNY"  then
        local new = math.random(1,2)
        if new == 1 then
            CurrentWeather = "CLEARING"
        else
            CurrentWeather = "OVERCAST"
        end
    elseif CurrentWeather == "CLEARING" or CurrentWeather == "OVERCAST" then
        local new = math.random(1,6)
        if new == 1 then
            if CurrentWeather == "CLEARING" then CurrentWeather = "FOGGY" else CurrentWeather = "RAIN" end
        elseif new == 2 then
            CurrentWeather = "CLOUDS"
        elseif new == 3 then
            CurrentWeather = "CLEAR"
        elseif new == 4 then
            CurrentWeather = "EXTRASUNNY"
        elseif new == 5 then
            CurrentWeather = "SMOG"
        else
            CurrentWeather = "FOGGY"
        end
    elseif CurrentWeather == "THUNDER" or CurrentWeather == "RAIN" then
        CurrentWeather = "CLEARING"
    elseif CurrentWeather == "SMOG" or CurrentWeather == "FOGGY" then
        CurrentWeather = "CLEAR"
    end
    TriggerEvent("jweather:requestSync")
    if debugprint then
        print("[jweather] Neuer Wettertyp wurde generiert: " .. CurrentWeather .. ".\n")
        print("[jweather] Timer auf 6 Stunden gesetzt.\n")
    end
end

