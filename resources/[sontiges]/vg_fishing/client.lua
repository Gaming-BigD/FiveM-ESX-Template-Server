----------------------------------------------------------------------------------------------
--------------------------------------FRAMEWORK INIT------------------------------------------
----------------------------------------------------------------------------------------------

ESX = exports["es_extended"]:getSharedObject()


----------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------
local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}
-----------------------------------------------
-------------- GLOBAL VARIABLES ---------------
-----------------------------------------------
local playerPed     	= PlayerPedId()
local isInBaitShopMenu  = false
local currentBaitshop   = {}
local shopMenu
local anchored = false
local boat = nil
local fishing = false
local lastInput = 0
local pause = false
local pausetimer = 0
local correct = 0
local bait = "none"
local currentPlace = nil
local playerIsInWater = false
local anchorNotifId
local zoneStatus = true

-----------------------------------------------
-------------------- SHOP ---------------------
-----------------------------------------------
local marker = {
    {title="Angelshop", colour=2, id=498, x = 1694.823, y = 3755.388, z = 34.705, rot = 249.654, radius = 1.5},
}


function DrawFishingAreas()
	if Config.Debug == true then
		for k, place in pairs(Config.FishingPlace) do
			local blipf = AddBlipForRadius(place.x, place.y, place.z, place.r) 
			SetBlipSprite (blipf, 9)
			SetBlipColour (blipf, 1)
			SetBlipAsShortRange(blipf, true)
			SetBlipAlpha(blipf, 50)
		end
	end
end



local SellFishblip = AddBlipForCoord(Config.SellFish.x, Config.SellFish.y, Config.SellFish.z)
SetBlipSprite(SellFishblip, 68)
SetBlipColour(SellFishblip, 15)
SetBlipScale(SellFishblip, 0.8)
SetBlipAsShortRange(SellFishblip, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Fischverkauf")
EndTextCommandSetBlipName(SellFishblip)


local blipFishingShop = AddBlipForCoord(1694.8238525391, 3755.3889160156, 34.705341339111)
SetBlipSprite(blipFishingShop, 68)
SetBlipColour(blipFishingShop, 15)
SetBlipScale(blipFishingShop, 0.8)
SetBlipAsShortRange(blipFishingShop, true)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Angelshop")
EndTextCommandSetBlipName(blipFishingShop)



function ShowNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    return DrawNotification(false, false)
end

RegisterNetEvent('vg_fishing:message')
AddEventHandler('vg_fishing:message', function(text)	
	ShowNotification(text)
end, false)

			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

----------------MENU HEADER------------------

_menuPool = NativeUI.CreatePool()
 shopMenu = NativeUI.CreateMenu("Angelausrüstung", "Ausrüstung kaufen")
_menuPool:Add(shopMenu)
_menuPool:ControlDisablingEnabled(false)
_menuPool:MouseControlsEnabled(false)

----------------MENU OPEN------------------
Citizen.CreateThread(function()
    local playerID = GetPlayerServerId(PlayerId())
	GenerateShopMenu()
    Citizen.Wait(3000)
    while true do
		Citizen.Wait(0)
        _menuPool:ProcessMenus()
        if isInBaitShopMenu and IsControlJustPressed(1, 51) then
            shopMenu:Visible(not shopMenu:Visible())
        end
        if not isInBaitShopMenu then
            shopMenu:Visible(false)
        end
        if (isInBaitShopMenu == true) then
            DisplayHelpText("Drücke ~INPUT_CONTEXT~ um das Menü zu öffnen")
        end
    end
end)

----------------MENU FUNCTIONS------------------

function GenerateShopMenu()
    local ped = PlayerPedId()
    local currentWeaponHash = GetSelectedPedWeapon(ped)
	
	_menuPool:Remove()
    _menuPool = NativeUI.CreatePool()
    collectgarbage()
    
	
	 shopMenu = NativeUI.CreateMenu("Angeln", "Beschreibung")
    _menuPool:Add(shopMenu)
	
	local fishingrod = NativeUI.CreateItem("Angelrute", Config.FishingrodPrice .. " $")
    shopMenu:AddItem(fishingrod)
	
	local fishingknife = NativeUI.CreateItem("Anglermesser", Config.FishingknifePrice .. " $")
    shopMenu:AddItem(fishingknife)
	
	local bait1 = NativeUI.CreateItem("Fischköder", Config.FishbaitPrice .. " $")
    shopMenu:AddItem(bait1)
	
	local bait2 = NativeUI.CreateItem("Schildkrötenfutter", Config.TurtlebaitPrice .. " $")
    shopMenu:AddItem(bait2)

    shopMenu.OnItemSelect = function(sender, item, index)
				
		if item == fishingrod then
			TriggerServerEvent('vg_fishing:addItem', 'fishingrod', '1')
        end
		
		if item == fishingknife then
			TriggerServerEvent('vg_fishing:addItem', 'fishingknife', '1')
        end
		
		if item == bait1 then
			BuyItem('fishbait')
			--TriggerServerEvent('vg_fishing:addItem', 'fishbait', '1')
        end
		
		if item == bait2 then
			BuyItem('turtlebait')
			--TriggerServerEvent('vg_fishing:addItem', 'turtlebait', '1')
        end		
		
	end
	_menuPool:ControlDisablingEnabled(false)
	_menuPool:MouseControlsEnabled(false)
    _menuPool:RefreshIndex()
end

function BuyItem(item)
	local onScreenDisplayResult_addItem = CreateDialog("Anzahl")
	if (onScreenDisplayResult_addItem ~= nil) then
		if tonumber(onScreenDisplayResult_addItem) then
			local value = onScreenDisplayResult_addItem
			local amount = tonumber(value)
			TriggerServerEvent('vg_fishing:addItem', item, amount)
		else
			ShowNotification("Nur Zahl von 1-120 zulässig")
		end
	end
end

function CreateDialog(OnScreenDisplayTitle) --general OnScreenDisplay for KeyboardInput
	AddTextEntry('FMMC_MPM_NA', OnScreenDisplayTitle)
	DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 64)
	while (UpdateOnscreenKeyboard() == 0) do
		DisableAllControlActions(0);
		Wait(0);
	end
	if (GetOnscreenKeyboardResult()) then
		local displayResult = GetOnscreenKeyboardResult()
		return displayResult
	end
end


Citizen.CreateThread(function() 
	DrawFishingAreas()
    while true do
		Citizen.Wait(0)
		local playerPed = PlayerPedId()
		local playerCoords = GetEntityCoords(PlayerPedId())

		if (GetDistanceBetweenCoords(playerCoords, Config.FishingShop.x, Config.FishingShop.y, Config.FishingShop.z, true) < 50.0) then
			DrawMarker(27, Config.FishingShop.x, Config.FishingShop.y, Config.FishingShop.z+ 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.radius, Config.Marker.radius, Config.Marker.radius, Config.Marker.colour.r, Config.Marker.colour.g, Config.Marker.colour.b, Config.Marker.colour.a, false, false, 2, false, false, false, false)	
			for k,v in pairs(marker) do
				if (GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true) < v.radius/2) then		
					isInBaitShopMenu = true
					currentBaitshop = v
					break
				else
					isInBaitShopMenu = false
					currentBaitshop = {}
				end
			end
		end

		if (GetDistanceBetweenCoords(playerCoords, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) < 50.0) then
			DrawMarker(27, Config.SellFish.x, Config.SellFish.y, Config.SellFish.z+ 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.radius*1.5, Config.Marker.radius*1.5, Config.Marker.radius, Config.Marker.colour.r, Config.Marker.colour.g, Config.Marker.colour.b, Config.Marker.colour.a, false, false, 2, false, false, false, false)
		end

		if IsPedInAnyBoat(playerPed) then
			boat  = GetVehiclePedIsIn(playerPed, true)
			
			if anchored and IsVehicleEngineOn(boat) then
				ShowNotification("Anker eingeholt")
				local boatNetId = NetworkGetNetworkIdFromEntity(boat)
				TriggerServerEvent('vg_fishing:Anchor', boatNetId)
			end
		end
		if IsControlJustPressed(1, 246) and not IsPedInAnyVehicle(playerPed) and boat ~= nil then --key: Y
			local boatNetId = NetworkGetNetworkIdFromEntity(boat)
			TriggerServerEvent('vg_fishing:Anchor', boatNetId)
			if not anchored then
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.0, "Anchordown", 0.6)
			else
				TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10.0, "Anchorup", 0.6)
			end


		end

    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(600)
		if pause and fishing then
			pausetimer = pausetimer + 1
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(5)
		if fishing then
		
			BlockWeaponWheelThisFrame()
		
			if IsControlJustReleased(0, Keys['1']) then
				 input = 1
			end
			if IsControlJustReleased(0, Keys['2']) then
				input = 2
			end
			if IsControlJustReleased(0, Keys['3']) then
				input = 3
			end
			if IsControlJustReleased(0, Keys['4']) then
				input = 4
			end
			if IsControlJustReleased(0, Keys['5']) then
				input = 5
			end
			if IsControlJustReleased(0, Keys['6']) then
				input = 6
			end
			if IsControlJustReleased(0, Keys['7']) then
				input = 7
			end
			if IsControlJustReleased(0, Keys['8']) then
				input = 8
			end
			
			
			if IsControlJustReleased(0, Keys['X']) or IsControlJustReleased(0, Keys['DELETE']) then
				fishing = false
				ShowNotification("~r~Stopped fishing")
			end
			if fishing then			
				if IsEntityDead(PlayerPedId()) then
					fishing = false
					ShowNotification("~r~Stopped fishing")
				end
			end
			
			
			if pausetimer > 3 then
				input = 99
			end
			
			if pause and input ~= 0 then
				pause = false
				if input == correct then
					local player, distance = ESX.Game.GetClosestPlayer()
					local boatNetId = NetworkGetNetworkIdFromEntity(boat)
					local hasFriend = false
					if DoesEntityExist(boatNetId) and (distance ~1 and distance <=3.0) then
						hasFriend = true
					end
					TriggerServerEvent('vg_fishing:catch', bait, currentPlace, hasFriend)
				else
					ShowNotification("~r~Fisch verloren")
				end
			end
		end
		
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellFish.x, Config.SellFish.y, Config.SellFish.z, true) <= 3 then
			TriggerServerEvent('vg_fishing:startSelling', "fish")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellShark.x, Config.SellShark.y, Config.SellShark.z, true) <= 3 then
			TriggerServerEvent('vg_fishing:startSelling', "shark")
			Citizen.Wait(4000)
		end
		if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.SellTurtle.x, Config.SellTurtle.y, Config.SellTurtle.z, true) <= 3 then
			TriggerServerEvent('vg_fishing:startSelling', "turtle")
			Citizen.Wait(4000)
		end
		
	end
end)


function DefineTime()
	local timeDefined = "none"

	local hour = GetClockHours()
	if (hour >= 0 and hour <= 4) then
		timeDefined = "night"
	elseif 	(hour >= 5 and hour <= 7) then
		timeDefined = "morning"
	elseif 	(hour >= 20 and hour <= 23) then
		timeDefined = "evening"
	else
		timeDefined = "day"
	end

	return timeDefined
end

function StartFishing()
	Citizen.CreateThread(function()
		TriggerServerEvent('vg_fishing:sv_GetAllZoneActive')

		while fishing do
			Citizen.Wait(1)

			local wait = 0
			if currentPlace ~= nil then
				wait = math.random(currentPlace.FishTime.a , currentPlace.FishTime.b)
			else
				wait = math.random(Config.FishingNonePlace.FishTime.a , Config.FishingNonePlace.FishTime.b)
			end

			wait = wait * Config.TimePenalty[DefineTime()]
			
			local abgebrochen = false
			while wait > 0 do
				Citizen.Wait(100)
				wait = wait - 100

				if (not fishing) then
					abgebrochen = true
					break
				end
			end
			
			if not abgebrochen then
				pause = true
				correct = math.random(1,8)
				ShowNotification("~g~Da ist einer dran, \n ~h~drücke " .. correct .. " um ihn zu haken")
				input = 0
				pausetimer = 0
			end

		end
	end)
end

RegisterNetEvent('vg_fishing:break')
AddEventHandler('vg_fishing:break', function()
	fishing = false
	ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('vg_fishing:spawnPed')
AddEventHandler('vg_fishing:spawnPed', function()
	RequestModel( GetHashKey( "A_C_SharkTiger" ) )
	while ( not HasModelLoaded( GetHashKey( "A_C_SharkTiger" ) ) ) do
		Citizen.Wait( 1 )
	end
	local pos = GetEntityCoords(PlayerPedId())
	
	local ped = CreatePed(29, 0x06C3F072, pos.x, pos.y, pos.z, 90.0, true, false)
	SetEntityHealth(ped, 0)
end)

RegisterNetEvent('vg_fishing:setbait')
AddEventHandler('vg_fishing:setbait', function(_bait)
	bait = _bait
end)


RegisterNetEvent('vg_fishing:fishstart')
AddEventHandler('vg_fishing:fishstart', function()	
	local playerPed = PlayerPedId()
	local pos = GetEntityCoords(playerPed)
	local water = GetWaterHeight(pos.x, pos.y, pos.z-1, pos.z-1)
	local inWater = IsEntityInWater(playerPed)
	
	if water == 1 or inWater == 1 then
		if IsPedInAnyVehicle(playerPed) then
			ShowNotification("~y~Du brauchst ein Boot!")
		else
			for k, place in pairs(Config.FishingPlace) do
				if (Vdist(pos, place.x, place.y, place.z) <= place.r and place.active) then
					currentPlace = place
					break
				end
			end

			if currentPlace then
				if bait == "none" then
					ShowNotification("~y~Du musst einen Köder benutzen!")
				else
					ShowNotification("~g~Fishing started")
					TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_FISHING", 0, true)
					TriggerEvent('vg_fishing:playSound', "fishing_start")
					fishing = true

					StartFishing()
				end
			else
				if bait == "none" then
					ShowNotification("~y~Du musst einen Köder benutzen!")
				else
					ShowNotification("~g~Fishing started")
					TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_STAND_FISHING", 0, true)
					TriggerEvent('vg_fishing:playSound', "fishing_start")
					currentPlace = Config.FishingNonePlace
					fishing = true

					StartFishing()
				end
			end
		end
	else
		ShowNotification("~y~Du kannst an Land nicht angeln..")
	end
end, false)



RegisterNetEvent('vg_fishing:playSound')
AddEventHandler('vg_fishing:playSound', function(sound)
	local clientNetId = GetPlayerServerId(PlayerId())
	TriggerServerEvent("InteractSound_SV:PlayOnOne", clientNetId, sound, 0.5)
end)


RegisterNetEvent('vg_fishing:Anchor')
AddEventHandler('vg_fishing:Anchor', function(boatNetId)
	local boat = NetworkGetEntityFromNetworkId(boatNetId)	

	if DoesEntityExist(boat) then
		local coordsBoat = GetEntityCoords(boat)
		local coordsPlayer = GetEntityCoords(PlayerPedId())
		if (Vdist(coordsBoat.x, coordsBoat.y, coordsBoat.z, coordsPlayer.x, coordsPlayer.y, coordsPlayer.z) < 10.0) then
			if not anchored then
				SetBoatAnchor(boat, true)
				TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				Citizen.Wait(10000)
				RemoveNotification(anchorNotifId)
				anchorNotifId = ShowNotification("Anker geworfen")
				ClearPedTasks(PlayerPedId())
			else
				TaskStartScenarioInPlace(PlayerPedId(), 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
				Citizen.Wait(10000)
				SetBoatAnchor(boat, false)
				RemoveNotification(anchorNotifId)
				anchorNotifId = ShowNotification("Anker eingeholt")
				ClearPedTasks(PlayerPedId())
			end
			anchored = not anchored
		end
	end
end)

RegisterNetEvent('vg_fishing:cl_ZoneActiveSync')
AddEventHandler('vg_fishing:cl_ZoneActiveSync', function(zone, status)
	for k, place in pairs(Config.FishingPlace) do
		if place.name == zone.name then
			place.active = status
			if Config.Debug then print(zone.name .. " Active: " .. tostring(status)) end
			break
		end
	end
end)

RegisterNetEvent('vg_fishing:cl_GetAllZoneActive')
AddEventHandler('vg_fishing:cl_GetAllZoneActive', function(zones)
	for i=1, #Config.FishingPlace do
		Config.FishingPlace[i].active = zones[i].active
		if Config.Debug then print(Config.FishingPlace[i].name .. " Active: " .. tostring(zones[i].active)) end
	end
end)



-- DEBUG
Citizen.CreateThread(function()
	if (Config.Debug) then
		while true do
			Citizen.Wait(5000)
			if currentPlace ~= nil then
				print(currentPlace.name .. "active: " .. tostring(currentPlace.active))
			end
		end
	end
end)

























