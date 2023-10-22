ESX = exports["es_extended"]:getSharedObject()
local holdingup = false
local store = ""
local blipRobbery = nil
local vetrineRotte = 0 

local vetrine = {
	{x = 147.085, y = -1048.612, z = 29.346, heading = 70.326, isOpen = false},
	{x = -626.735, y = -238.545, z = 38.057, heading = 214.907, isOpen = false},
	{x = -625.697, y = -237.877, z = 38.057, heading = 217.311, isOpen = false},
	{x = -626.825, y = -235.347, z = 38.057, heading = 33.745, isOpen = false},
	{x = -625.77, y = -234.563, z = 38.057, heading = 33.572, isOpen = false},
	{x = -627.957, y = -233.918, z = 38.057, heading = 215.214, isOpen = false},
	{x = -626.971, y = -233.134, z = 38.057, heading = 215.532, isOpen = false},
	{x = -624.433, y = -231.161, z = 38.057, heading = 305.159, isOpen = false},
	{x = -623.045, y = -232.969, z = 38.057, heading = 303.496, isOpen = false},
	{x = -620.265, y = -234.502, z = 38.057, heading = 217.504, isOpen = false},
	{x = -619.225, y = -233.677, z = 38.057, heading = 213.35, isOpen = false},
	{x = -620.025, y = -233.354, z = 38.057, heading = 34.18, isOpen = false},
	{x = -617.487, y = -230.605, z = 38.057, heading = 309.177, isOpen = false},
	{x = -618.304, y = -229.481, z = 38.057, heading = 304.243, isOpen = false},
	{x = -619.741, y = -230.32, z = 38.057, heading = 124.283, isOpen = false},
	{x = -619.686, y = -227.753, z = 38.057, heading = 305.245, isOpen = false},
	{x = -620.481, y = -226.59, z = 38.057, heading = 304.677, isOpen = false},
	{x = -621.098, y = -228.495, z = 38.057, heading = 127.046, isOpen = false},
	{x = -623.855, y = -227.051, z = 38.057, heading = 38.605, isOpen = false},
	{x = -624.977, y = -227.884, z = 38.057, heading = 48.847, isOpen = false},
	{x = -624.056, y = -228.228, z = 38.057, heading = 216.443, isOpen = false},
}


function DrawText3D(x, y, z, text, scale)
	local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())

	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 215)

	AddTextComponentString(text)
	DrawText(_x, _y)

end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

RegisterNetEvent("mt:missiontext")
AddEventHandler("mt:missiontext", function(text, time)
    ClearPrints()
    SetTextEntry_2("STRING")
    AddTextComponentString(text)
    DrawSubtitleTimed(time, 1)
end)

function loadAnimDict( dict )  
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end 

RegisterNetEvent('dn_vangelico:currentlyrobbing')
AddEventHandler('dn_vangelico:currentlyrobbing', function(robb)
	holdingup = true
	store = robb
end)

RegisterNetEvent('dn_vangelico:killblip')
AddEventHandler('dn_vangelico:killblip', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('dn_vangelico:setblip')
AddEventHandler('dn_vangelico:setblip', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('dn_vangelico:toofarlocal')
AddEventHandler('dn_vangelico:toofarlocal', function(robb)
	holdingup = false
	--ESX.ShowNotification(_U('robbery_cancelled'))
	exports["dn_notify"]:notify('Notification', _U('robbery_cancelled'), 'error', 5000)
	robbingName = ""
	incircle = false
end)


RegisterNetEvent('dn_vangelico:robberycomplete')
AddEventHandler('dn_vangelico:robberycomplete', function(robb)
	holdingup = false
	--ESX.ShowNotification(_U('robbery_complete'))
	exports["dn_notify"]:notify('Notification', _U('robbery_complete'), 'success', 5000)
	store = ""
	incircle = false
end)

Citizen.CreateThread(function()
	for k,v in pairs(Stores)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 439)
		SetBlipScale(blip, 0.8)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('shop_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)

animazione = false
incircle = false
soundid = GetSoundId()

function drawTxt(x, y, scale, text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextScale(0.64, 0.64)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
    DrawText(0.155, 0.935)
end

local borsa = nil

Citizen.CreateThread(function()
	while true do
	  Citizen.Wait(1000)
	  TriggerEvent('skinchanger:getSkin', function(skin)
		borsa = skin['bags_1']
	  end)
	  Citizen.Wait(1000)
	end
end)

lib.registerContext({
	id = 'start_rob',
	title = 'Start Robbery',
	options = {
		{
			title = 'Start Robbery',
			description = 'To Start Robbery',
			icon = 'fa-solid fa-gem',
			onSelect = function()
				startrob()
			end,
		}
	}
})

exports.ox_target:addBoxZone({
	coords = vector3(Stores["jewelry"].position.x,Stores["jewelry"].position.y,Stores["jewelry"].position.z),
	size = vec3(1, 1, 4),
	rotation = 98.0,
	debug = false,
	options = {
		{
		name = 'Start Rob',
		onSelect = function()
			lib.showContext('start_rob')
		end,
		icon = 'fa-solid fa-gem',
		label = 'start robbery',
		},
	}
})

function startrob()
		local pos = GetEntityCoords(GetPlayerPed(-1), true)

		for k,v in pairs(Stores)do
			local pos2 = v.position

			if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 15.0)then
				if not holdingup then

					if(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						exports['ps-ui']:Scrambler(function(success)
							if success then
								if Config.NeedBag then
							    	if borsa == 40 or borsa == 41 or borsa == 44 or borsa == 45 then
							        	ESX.TriggerServerCallback('dn_vangelico:conteggio', function(CopsConnected)
								        	if CopsConnected >= Config.RequiredCopsRob then
							                	TriggerServerEvent('dn_vangelico:rob', k)
									        	PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", pos2.x, pos2.y, pos2.z)
								        	else
									        --TriggerEvent('esx:showNotification', _U('min_two_police') .. Config.RequiredCopsRob .. _U('min_two_police2'))
											exports["dn_notify"]:notify('Notification', _U('min_two_police') .. Config.RequiredCopsRob .. _U('min_two_police2'), 'error', 5000)
								        	end
							        	end)		
						        	else
							        	TriggerEvent('esx:showNotification', _U('need_bag'))
									end
								else
									ESX.TriggerServerCallback('dn_vangelico:conteggio', function(CopsConnected)
										if CopsConnected >= Config.RequiredCopsRob then
											TriggerServerEvent('dn_vangelico:rob', k)
											PlaySoundFromCoord(soundid, "VEHICLES_HORNS_AMBULANCE_WARNING", pos2.x, pos2.y, pos2.z)
										else
											--TriggerEvent('esx:showNotification', _U('min_two_police') .. Config.RequiredCopsRob .. _U('min_two_police2'))
											exports["dn_notify"]:notify('Notification', _U('min_two_police') .. Config.RequiredCopsRob .. _U('min_two_police2'), 'error', 5000)
										end
									end)	
								end	
							else
								exports["dn_notify"]:notify('Notification', 'Failed to hack the machine', 'error', 5000)
							end
						end, "numeric", 30, 0) 

					elseif(Vdist(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end		
				end
			end
		end
end 



Citizen.CreateThread(function()
      
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		if holdingup then
			drawTxt(0.3, 1.4, 0.45, _U('smash_case') .. ' :~r~ ' .. vetrineRotte .. '/' .. Config.MaxWindows, 185, 185, 185, 255)

			for i,v in pairs(vetrine) do 
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 10.0) and not v.isOpen and Config.EnableMarker then 
					DrawMarker(20, v.x, v.y, v.z, 0, 0, 0, 0, 0, 0, 0.6, 0.6, 0.6, 0, 255, 255, 200, 1, 1, 0, 0)
				end
				if(GetDistanceBetweenCoords(pos, v.x, v.y, v.z, true) < 0.75) and not v.isOpen then 
					DrawText3D(v.x, v.y, v.z, '~w~[~g~E~w~] ' .. _U('press_to_collect'), 0.6)
					if IsControlJustPressed(0, 38) then

					  	if GetSelectedPedWeapon(GetPlayerPed(-1))	== GetHashKey(Config.AllowedWeapon) then
							animazione = true
					    	SetEntityCoords(GetPlayerPed(-1), v.x, v.y, v.z-0.95)
					    	SetEntityHeading(GetPlayerPed(-1), v.heading)
							v.isOpen = true 
							PlaySoundFromCoord(-1, "Glass_Smash", v.x, v.y, v.z, "", 0, 0, 0)
					    	if not HasNamedPtfxAssetLoaded("scr_jewelheist") then
					    	RequestNamedPtfxAsset("scr_jewelheist")
					    	end
					    	while not HasNamedPtfxAssetLoaded("scr_jewelheist") do
					    	Citizen.Wait(0)
					    	end
					    	SetPtfxAssetNextCall("scr_jewelheist")
					    	StartParticleFxLoopedAtCoord("scr_jewel_cab_smash", v.x, v.y, v.z, 0.0, 0.0, 0.0, 1.0, false, false, false, false)
					    	loadAnimDict( "missheist_jewel" ) 
							TaskPlayAnim(GetPlayerPed(-1), "missheist_jewel", "smash_case", 8.0, 1.0, -1, 2, 0, 0, 0, 0 ) 
							TriggerEvent("mt:missiontext", _U('collectinprogress'), 3000)
					    	--DisplayHelpText(_U('collectinprogress'))
					    	DrawSubtitleTimed(5000, 1)
					    	Citizen.Wait(5000)
					    	ClearPedTasksImmediately(GetPlayerPed(-1))
					    	TriggerServerEvent('dn_vangelico:gioielli')
					    	PlaySound(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", 0, 0, 1)
					    	vetrineRotte = vetrineRotte+1
					    	animazione = false

							if vetrineRotte == Config.MaxWindows then 
							    for i,v in pairs(vetrine) do 
									v.isOpen = false
									vetrineRotte = 0
								end
								TriggerServerEvent('dn_vangelico:endrob', store)
							   -- ESX.ShowNotification(_U('lester'))
							   exports["dn_notify"]:notify('Notification',_U('lester'), 'error', 5000)
							    holdingup = false
							    StopSound(soundid)
							end
					 	else
							--print("no weapon")
							exports["dn_notify"]:notify('Notification','you dont have carbonrifle in hand', 'error', 5000)
						end
					end
				end	
			end

			local pos2 = Stores[store].position

			if (GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), -622.566, -230.183, 38.057, true) > 11.5 ) then
				TriggerServerEvent('dn_vangelico:toofar', store)
				holdingup = false
				for i,v in pairs(vetrine) do 
					v.isOpen = false
					vetrineRotte = 0
				end
				StopSound(soundid)
			end

		end

		

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
      
	while true do
		Wait(1)
		if animazione == true then
			if not IsEntityPlayingAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 3) then
				TaskPlayAnim(PlayerPedId(), 'missheist_jewel', 'smash_case', 8.0, 8.0, -1, 17, 1, false, false, false)
			end
		end
	end
end)

RegisterNetEvent("lester:createBlip")
AddEventHandler("lester:createBlip", function(type, x, y, z)
	local blip = AddBlipForCoord(x, y, z)
	SetBlipSprite(blip, type)
	SetBlipColour(blip, 1)
	SetBlipScale(blip, 0.8)
	SetBlipAsShortRange(blip, true)
	if(type == 77)then
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Lester")
		EndTextCommandSetBlipName(blip)
	end
end)

blip = false


lib.registerContext({
	id = 'sellJewels',
	title = 'Sell Jewels',
	options = {
		{
			title = 'Sell Jewels',
			description = 'To Sell Jewels',
			icon = 'fa-solid fa-gem',
			onSelect = function()
				sellJewels()
			end,
		}
	}
})

exports.ox_target:addBoxZone({
	coords = vec3(707.17572021484,-967.28253173828,30.531572341919),
	size = vec3(1, 1, 4),
	rotation = 98.0,
	debug = false,
	options = {
		{
		name = 'Sell Jewels',
		onSelect = function()
			lib.showContext('sellJewels')
		end,
		icon = 'fa-solid fa-gem',
		label = 'Sell Jewels',
		},
	}
})
function sellJewels()
local playerPed = PlayerPedId()
local coords    = GetEntityCoords(playerPed)
		ESX.TriggerServerCallback('dn_vangelico:getItemAmount', function(quantity)
		if quantity >= Config.MaxJewelsSell then
			ESX.TriggerServerCallback('dn_vangelico:conteggio', function(CopsConnected)
				if CopsConnected >= Config.RequiredCopsSell then
					FreezeEntityPosition(playerPed, true)
					TriggerEvent('mt:missiontext', _U('goldsell'), 10000)
					Wait(10000)
					FreezeEntityPosition(playerPed, false)
					TriggerServerEvent('lester:vendita')
					blip = false
				else
					blip = false
					--TriggerEvent('esx:showNotification', _U('copsforsell') .. Config.RequiredCopsSell .. _U('copsforsell2'))
					exports["dn_notify"]:notify('Notification',  _U('copsforsell') .. Config.RequiredCopsSell .. _U('copsforsell2'), 'error', 5000)
				end
			end)
		else
			blip = false
			--TriggerEvent('esx:showNotification', _U('notenoughgold'))
			exports["dn_notify"]:notify('Notification', _U('notenoughgold'), 'error', 5000)
		end
	end, 'jewels')
end		

