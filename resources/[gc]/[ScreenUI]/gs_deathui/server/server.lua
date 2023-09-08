ESX = nil 
QS = nil
local playersHealing, deadPlayers = {}, {}

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterCommand('revive', 'admin', function(xPlayer, args, showError)
	args.playerId.triggerEvent('gs_deathui:revive')
end, true, {help = "Revive", validate = true, arguments = {
	{name = 'playerId', help = 'The player id', type = 'player'}
}})

ESX.RegisterServerCallback('gs_deathui:removeItemsAfterRPDeath', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
	local qPlayer = QS.GetPlayerFromId(source)

    if Config.RemoveCashAfterRPDeath then
        if xPlayer.getMoney() > 0 then
            xPlayer.removeMoney(xPlayer.getMoney())
        end

        if xPlayer.getAccount('black_money').money > 0 then
            xPlayer.removeAccountMoney('black_money', xPlayer.getAccount('black_money').money)
        end
    end
    
    if Config.RemoveItemsAfterRPDeath then 
        qPlayer.ClearInventoryItems()
    end

    if Config.RemoveWeaponsAfterRPDeath then 
        qPlayer.ClearInventoryWeapons()
    end

    cb()
end)

	local playerLoadout = {}
	if GlobalState.RemoveWeaponsAfterRPDeath then
		for i=1, #xPlayer.loadout, 1 do
			xPlayer.removeWeapon(xPlayer.loadout[i].name)
		end
	else -- save weapons & restore em' since spawnmanager removes them
		for i=1, #xPlayer.loadout, 1 do
			table.insert(playerLoadout, xPlayer.loadout[i])
		end

		-- give back wepaons after a couple of seconds
		Citizen.CreateThread(function()
			Citizen.Wait(5000)
			for i=1, #playerLoadout, 1 do
				if playerLoadout[i].label ~= nil then
					xPlayer.addWeapon(playerLoadout[i].name, playerLoadout[i].ammo)
				end
			end
		end)
	end

	cb()
end)

RegisterNetEvent('gs_deathui:removeItem')
AddEventHandler('gs_deathui:removeItem', function(item)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem(item, 1)

	if item == 'bandage' then
		xPlayer.showNotification(_U('used_bandage'))
	elseif item == 'medikit' then
		xPlayer.showNotification(_U('used_medikit'))
	end
end)