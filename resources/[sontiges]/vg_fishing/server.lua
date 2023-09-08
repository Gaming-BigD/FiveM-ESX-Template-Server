ESX = exports["es_extended"]:getSharedObject()

function InitializeZoneStatus()
	for k, place in pairs(Config.FishingPlace) do
		place.status		= (place.fishchance + place.turtlechance + place.sharkchance) * 10.0
		place.statusTimer	= Config.ZoneDeadTime
	end
	print("vg_fishing: All zone status initialized.")
end

InitializeZoneStatus()

ESX.RegisterUsableItem('turtlebait', function(source)
	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('vg_fishing:setbait', _source, "turtlebait")
		
		xPlayer.removeInventoryItem('turtlebait', 1)
		TriggerClientEvent('vg_fishing:message', _source, "~g~Schildkrötenköder angebracht")
	else
		TriggerClientEvent('vg_fishing:message', _source, "~r~Du hast keine Angel!")
	end
end)

ESX.RegisterUsableItem('fishbait', function(source)
	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 then
		TriggerClientEvent('vg_fishing:setbait', _source, "fishbait")
		
		xPlayer.removeInventoryItem('fishbait', 1)
		TriggerClientEvent('vg_fishing:message', _source, "~g~Fischköder angebracht")
		
	else
		TriggerClientEvent('vg_fishing:message', _source, "~r~Du hast keine Angel!")
	end
end)

ESX.RegisterUsableItem('turtle', function(source)
	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingknife').count > 0 then
		xPlayer.removeInventoryItem('turtle', 1)
		xPlayer.addInventoryItem('sharkbait', 2)
		TriggerClientEvent('vg_fishing:message', _source, "~g~Schildkröte zu Haiköder verarbeitet")
	else
		TriggerClientEvent('vg_fishing:message', _source, "~r~Du benötigst ein ein Anglermesser!")
	end
end)

ESX.RegisterUsableItem('sharkbait', function(source)
	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)
	if xPlayer.getInventoryItem('fishingrod').count > 0 and xPlayer.getInventoryItem('fishingknife').count > 0 then
		TriggerClientEvent('vg_fishing:setbait', _source, "sharkbait")
		
		xPlayer.removeInventoryItem('sharkbait', 1)
		TriggerClientEvent('vg_fishing:message', _source, "~g~Haiköder angebracht")
	else
		TriggerClientEvent('vg_fishing:message', _source, "~r~Du benötigst eine Angel und ein Anglermesser!")
	end
end)


ESX.RegisterUsableItem('fishingrod', function(source)
	local _source = source
	TriggerClientEvent('vg_fishing:fishstart', _source)
end)

ESX.RegisterUsableItem('anchor', function(source)
	local _source = source
	TriggerClientEvent('vg_fishing:anchor', _source)
end)

RegisterServerEvent('vg_fishing:removeItem')
AddEventHandler('vg_fishing:removeItem', function(item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local ItemQuantity = xPlayer.getInventoryItem(item).count
	
	if ItemQuantity <= 0 then
		TriggerClientEvent('vg_fishing:message', source, 'Du hast nicht genug ' .. item)
	else   
		xPlayer.removeInventoryItem(item, count)
	end
end)

RegisterServerEvent('vg_fishing:addItem')
AddEventHandler('vg_fishing:addItem', function(item, count)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local ItemQuantity = xPlayer.getInventoryItem(item).count
	
	if item == "fishingrod" then
		if ItemQuantity >= 2 then
			TriggerClientEvent('vg_fishing:message', source, '~r~Du kannst nicht mehr tragen')	
		else 
			BuyItem(xPlayer, Config.FishingrodPrice, item, count)
		end
	elseif item == "fishingknife" then
		if ItemQuantity >= 1 then
			TriggerClientEvent('vg_fishing:message', source, '~r~Du kannst nicht mehr tragen')	
		else 
			BuyItem(xPlayer, Config.FishingknifePrice, item, count)
		end
	elseif item == "fishbait" then
		if ItemQuantity >= 100 then
			TriggerClientEvent('vg_fishing:message', source, '~r~Du kannst nicht mehr tragen')	
		else 
			BuyItem(xPlayer, Config.FishbaitPrice, item, count)
		end
	elseif item == "turtlebait" then
		if ItemQuantity >= 100 then
			TriggerClientEvent('vg_fishing:message', source, '~r~Du kannst nicht mehr tragen')	
		else 
			BuyItem(xPlayer, Config.TurtlebaitPrice, item, count)
		end
	end
end)


RegisterNetEvent('vg_fishing:catch')
AddEventHandler('vg_fishing:catch', function(bait, currentPlace, hasFriend)
	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)

	Citizen.CreateThread(function()
		TriggerClientEvent('vg_fishing:playSound', _source, "fishing_reelin")
		Citizen.Wait(13000)
		
		math.randomseed(os.time())
		local rand = math.random(1, 100)
		local fishWeightNonFishingPlace = math.random(1, Config.MaxWeightFishNonFishingPlace)
		local fishWeight = math.random(1, Config.MaxWeightFish)
		local turtleWeight = math.random(1, Config.MaxWeightTurtle)
		local sharkWeight = math.random(1, Config.MaxWeightShark)

		if currentPlace == Config.FishingNonePlace then
			if (bait == 'fishbait' and rand <= currentPlace.fishchance) then
				addCatchedFish(_source, xPlayer, "fish", fishWeightNonFishingPlace, Config.MaxAmountFish)

			elseif (bait == 'turtlebait' and rand <= currentPlace.turtlechance) then
				addCatchedFish(_source, xPlayer, "turtle", turtleWeight, Config.MaxAmountTurtle)

			elseif (bait == 'sharkbait' and rand <= currentPlace.sharkchance) then
				if hasFriend == true then
					addCatchedFish(_source, xPlayer, "shark", sharkWeight, Config.MaxAmountShark)
				else
					TriggerClientEvent('vg_fishing:setbait', _source, "none")
					TriggerClientEvent('vg_fishing:break', _source)
					xPlayer.removeInventoryItem("fishingrod", 1)
					TriggerClientEvent('vg_fishing:message', _source, "~r~Der Hai war zu schwer für dich alleine, Angel verloren!")
				end
			else
				TriggerClientEvent('vg_fishing:message', _source, "~r~Fisch hat sich vom Haken gelöst")
			end
		else
			if (bait == 'fishbait' and rand <= currentPlace.fishchance) then
				addCatchedFish(_source, xPlayer, "fish", fishWeight, Config.MaxAmountFish)
				SetZoneStatus(currentPlace, Config.ZoneImpactValueFish)
			elseif (bait == 'turtlebait' and rand <= currentPlace.turtlechance) then
				addCatchedFish(_source, xPlayer, "turtle", turtleWeight, Config.MaxAmountTurtle)
				SetZoneStatus(currentPlace, Config.ZoneImpactValueTurtle)
			elseif (bait == 'sharkbait' and rand <= currentPlace.sharkchance) then
				addCatchedFish(_source, xPlayer, "shark", sharkWeight, Config.MaxAmountShark)
				SetZoneStatus(currentPlace, Config.ZoneImpactValueShark)
			else
				TriggerClientEvent('vg_fishing:message', _source, "~r~Fisch hat sich vom Haken gelöst")
			end
		end
		
		CheckBaitLeft(_source, xPlayer, bait)
	end)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3600000)
		
		for k, place in pairs(Config.FishingPlace) do
			if place.active == false then
				place.statusTimer = place.statusTimer - 1

				if place.statusTimer <= 0 then
					place.active = true
					TriggerClientEvent('vg_fishing:cl_ZoneActiveSync', -1, place, true)
				end

			end
		end
	end
end)

function SetZoneStatus(zone, impactValue)
	for k, place in pairs(Config.FishingPlace) do
		if place.name == zone.name then
			place.status = place.status - impactValue
			print(place.name .. " status: " .. place.status)
			if place.status <= 0.0 then
				place.active = false
				TriggerClientEvent('vg_fishing:cl_ZoneActiveSync', -1, place, false)
			end

			break
		end
	end
end

function CheckBaitLeft(_source, xPlayer, bait)
	if bait ~= "none" then
		if xPlayer.getInventoryItem(bait).count > 0 then
			xPlayer.removeInventoryItem(bait, 1)
			TriggerClientEvent('vg_fishing:message', _source, "~g~Neuen Köder aufgezogen")
			TriggerClientEvent('vg_fishing:playSound', _source, "fishing_start")
			Citizen.Wait(6000)
			TriggerClientEvent('vg_fishing:setbait', _source, bait)
		else
			TriggerClientEvent('vg_fishing:setbait', _source, "none")
			TriggerClientEvent('vg_fishing:break', _source)
			TriggerClientEvent('vg_fishing:message', _source, "~r~Keine Köder mehr übrig")
		end
	else
		TriggerClientEvent('vg_fishing:message', _source, "Du musst einen neuen Köder aufziehen")
	end
end

function addCatchedFish(_source, xPlayer, catchedFish, weight, maxAmountAllowed)
	local ItemQuantity = xPlayer.getInventoryItem(catchedFish).count
	TriggerClientEvent('vg_fishing:playSound', _source, "fishing_catch")

	if ItemQuantity >= maxAmountAllowed then
		TriggerClientEvent('vg_fishing:message', _source, "~r~Du kannst nicht mehr tragen")
	else
		xPlayer.addInventoryItem(catchedFish, weight)
		TriggerClientEvent('vg_fishing:message', _source, "~b~Fisch gefangen!")
	end
end

RegisterServerEvent('vg_fishing:startSelling')
AddEventHandler('vg_fishing:startSelling', function(item)
local _source = source
local xPlayer  = ESX.GetPlayerFromId(_source)
	if item == "fish" then
		local FishQuantity = xPlayer.getInventoryItem('fish').count
		if FishQuantity <= 4 then
			TriggerClientEvent('vg_fishing:message', source, '~r~Du hast nicht genug~s~ Fisch')		
		end	
	else   
		xPlayer.removeInventoryItem('fish', 5)
		local payment = Config.FishPrice.a
		payment = math.random(Config.FishPrice.a, Config.FishPrice.b) 
		xPlayer.addMoney(payment)	
	end
	if item == "turtle" then
		local FishQuantity = xPlayer.getInventoryItem('turtle').count
		if FishQuantity <= 0 then
			TriggerClientEvent('vg_fishing:message', source, '~r~Du hast nicht genug~s~ Schildkröten')
		else   
			xPlayer.removeInventoryItem('turtle', 1)
			local payment = Config.TurtlePrice.a
			payment = math.random(Config.TurtlePrice.a, Config.TurtlePrice.b)
			xPlayer.addMoney(payment)
		end
	end
	if item == "shark" then
		local FishQuantity = xPlayer.getInventoryItem('shark').count
		if FishQuantity <= 0 then
			TriggerClientEvent('vg_fishing:message', source, '~r~Du hast nicht genug~s~ Haie')		
		else   
			xPlayer.removeInventoryItem('shark', 1)
			local payment = Config.SharkPrice.a
			payment = math.random(Config.SharkPrice.a, Config.SharkPrice.b)
			xPlayer.addMoney(payment)
		end
	end
end)

RegisterServerEvent("vg_fishing:Anchor")
AddEventHandler("vg_fishing:Anchor", function(boatNetId)
	TriggerClientEvent("vg_fishing:Anchor", -1, boatNetId)
end)

function BuyItem(xPlayer, value, item, count)
	if xPlayer.getMoney() >= value then
		xPlayer.removeMoney(value)
		xPlayer.addInventoryItem(item, count)
		TriggerClientEvent('vg_fishing:message', source, '~g~Vielen Dank für deinen Einkauf!')
	else
		TriggerClientEvent('vg_fishing:message', source, '~r~Du hast nicht genug~s~ Geld')
	end
end

-- sync the status of a fishingzone
RegisterServerEvent("vg_fishing:sv_GetAllZoneActive")
AddEventHandler("vg_fishing:sv_GetAllZoneActive", function()
	TriggerClientEvent("vg_fishing:cl_GetAllZoneActive", source, Config.FishingPlace)
end)

if (Config.Debug) then --tests the syncfunction for the first zone in the configlist
	RegisterCommand('zoneactive', function(source, args, raw)
		Config.FishingPlace[1].active = not Config.FishingPlace[1].active
		TriggerClientEvent('vg_fishing:cl_ZoneActiveSync', -1, Config.FishingPlace[1], Config.FishingPlace[1].active)
	end)
end
























