ESX = exports["es_extended"]:getSharedObject()
local rob = false
local robbers = {}
PlayersCrafting    = {}
local CopsConnected  = 0


function get3DDistance(x1, y1, z1, x2, y2, z2)
	return math.sqrt(math.pow(x1 - x2, 2) + math.pow(y1 - y2, 2) + math.pow(z1 - z2, 2))
end

function CountCops()

	local xPlayers = ESX.GetPlayers()

	CopsConnected = 0

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
			CopsConnected = CopsConnected + 1
		end
	end

	SetTimeout(120 * 1000, CountCops)
end

CountCops()

RegisterServerEvent('dn_vangelico:toofar')
AddEventHandler('dn_vangelico:toofar', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			--TriggerClientEvent('esx:showNotification', xPlayers[i], _U('robbery_cancelled_at') .. Stores[robb].nameofstore)
			TriggerClientEvent("dn_notify:notify", source, 'Notification', _U('robbery_cancelled_at') .. Stores[robb].nameofstore, 'myNotification', 10000)
			TriggerClientEvent('dn_vangelico:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('dn_vangelico:toofarlocal', source)
		robbers[source] = nil
		--TriggerClientEvent('esx:showNotification', source, _U('robbery_has_cancelled') .. Stores[robb].nameofstore)
		TriggerClientEvent("dn_notify:notify", source, 'Notification', _U('robbery_has_cancelled') .. Stores[robb].nameofstore, 'myNotification', 10000)
	end
end)

RegisterServerEvent('dn_vangelico:endrob')
AddEventHandler('dn_vangelico:endrob', function(robb)
	local source = source
	local xPlayers = ESX.GetPlayers()
	rob = false
	for i=1, #xPlayers, 1 do
 		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
 		if xPlayer.job.name == 'police' then
			--TriggerClientEvent('esx:showNotification', xPlayers[i], _U('end'))
			TriggerClientEvent("dn_notify:notify", source, 'Notification',_U('end'), 'myNotification', 10000)
			TriggerClientEvent('dn_vangelico:killblip', xPlayers[i])
		end
	end
	if(robbers[source])then
		TriggerClientEvent('dn_vangelico:robberycomplete', source)
		robbers[source] = nil
		--TriggerClientEvent('esx:showNotification', source, _U('robbery_has_ended') .. Stores[robb].nameofstore)
		TriggerClientEvent("dn_notify:notify", source, 'Notification', _U('robbery_has_ended') .. Stores[robb].nameofstore, 'myNotification', 10000)
	end
end)

RegisterServerEvent('dn_vangelico:rob')
AddEventHandler('dn_vangelico:rob', function(robb)

	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	if Stores[robb] then

		local store = Stores[robb]

		if (os.time() - store.lastrobbed) < Config.SecBetwNextRob and store.lastrobbed ~= 0 then

            TriggerClientEvent('dn_vangelico:togliblip', source)
			--TriggerClientEvent('esx:showNotification', source, _U('already_robbed') .. (Config.SecBetwNextRob - (os.time() - store.lastrobbed)) .. _U('seconds'))
			TriggerClientEvent("dn_notify:notify", source, 'Notification', _U('already_robbed') .. (Config.SecBetwNextRob - (os.time() - store.lastrobbed)) .. _U('seconds'), 'myNotification', 10000)
			return
		end

		if rob == false then

			rob = true
			for i=1, #xPlayers, 1 do
				local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
				if xPlayer.job.name == 'police' then
					--TriggerClientEvent('esx:showNotification', xPlayers[i], _U('rob_in_prog') .. store.nameofstore)
					TriggerClientEvent("dn_notify:notify", source, 'Notification', _U('rob_in_prog'), 'myNotification', 10000)
					TriggerClientEvent('dn_vangelico:setblip', xPlayers[i], Stores[robb].position)
				end
			end

			--TriggerClientEvent('esx:showNotification', source, _U('started_to_rob') .. store.nameofstore .. _U('do_not_move'))
			--TriggerClientEvent('esx:showNotification', source, _U('alarm_triggered'))
			--TriggerClientEvent('esx:showNotification', source, _U('hold_pos'))
			TriggerClientEvent("dn_notify:notify", source, 'Notification',_U('started_to_rob') .. store.nameofstore .. _U('do_not_move'), 'myNotification', 10000)
			TriggerClientEvent("dn_notify:notify", source, 'Notification',_U('alarm_triggered'), 'myNotification', 10000)
			TriggerClientEvent("dn_notify:notify", source, 'Notification',  _U('hold_pos'), 'myNotification', 10000)
			TriggerClientEvent('dn_vangelico:currentlyrobbing', source, robb)
            CancelEvent()
			Stores[robb].lastrobbed = os.time()
		else
			--TriggerClientEvent('esx:showNotification', source, _U('robbery_already'))
			TriggerClientEvent("dn_notify:notify", source, 'Notification',  _U('robbery_already'), 'myNotification', 10000)
		end
	end
end)

RegisterServerEvent('dn_vangelico:gioielli')
AddEventHandler('dn_vangelico:gioielli', function()

	local xPlayer = ESX.GetPlayerFromId(source)

	xPlayer.addInventoryItem(Config.reward, math.random(Config.MinJewels, Config.MaxJewels))
end)

RegisterServerEvent('lester:vendita')
AddEventHandler('lester:vendita', function()

	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local reward = math.floor(Config.PriceForOneJewel * Config.MaxJewelsSell)

	xPlayer.removeInventoryItem(Config.reward, Config.MaxJewelsSell)
	xPlayer.addAccountMoney('black_money', reward)
end)

ESX.RegisterServerCallback('dn_vangelico:conteggio', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb(CopsConnected)
end)

ESX.RegisterServerCallback('dn_vangelico:getItemAmount', function(source, cb, item)
	local xPlayer = ESX.GetPlayerFromId(source)
	local quantity = xPlayer.getInventoryItem(Config.reward).count

	cb(quantity)
end)


