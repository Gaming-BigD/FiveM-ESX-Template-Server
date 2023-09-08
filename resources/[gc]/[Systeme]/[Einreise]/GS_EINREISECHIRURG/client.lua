SX                           = nil
local GUI                     = {}
GUI.Time                      = 0
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasPayed                = false

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)



function OpenShopMenu()

	HasPayed = false

	TriggerEvent('esx_skin:openRestrictedMenu', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shop_confirm',
			{
				title = "Bist du damit zufrieden?",
				align = 'top-left',
				elements = {
					{label = "Ja", value = 'yes'},
					{label = "NEIN", value = 'no'},
				}
			},
			function(data, menu)

				menu.close()

				if data.current.value == 'yes' then

					ESX.TriggerServerCallback('esx_plasticsurgery:checkMoney', function(hasEnoughMoney)

						if hasEnoughMoney then

							TriggerEvent('skinchanger:getSkin', function(skin)
								TriggerServerEvent('esx_skin:save', skin)
							end)

							TriggerServerEvent('esx_plasticsurgery:pay')

							HasPayed = true
						else

							TriggerEvent('esx_skin:getLastSkin', function(skin)
								TriggerEvent('skinchanger:loadSkin', skin)
							end)

							ESX.ShowNotification("ERROR")
						
						end

					end)

				end

				if data.current.value == 'no' then

					TriggerEvent('esx_skin:getLastSkin', function(skin)
						TriggerEvent('skinchanger:loadSkin', skin)
					end)

				end

				CurrentAction     = 'shop_menu'
				
				CurrentActionData = {}

			end,
			function(data, menu)

				menu.close()

				CurrentAction     = 'shop_menu'
				
				CurrentActionData = {}

			end
		)

	end, function(data, menu)

			menu.close()

			CurrentAction     = 'shop_menu'

			CurrentActionData = {}

	end, {
		'sex',
		'face',
		'age_1',
		'age_2',
		'beard_1',
		'beard_2',
		'beard_3',
		'beard_4',
		'hair_1',
		'hair_2',
        'eye_color',
        'eye_squint',
		'hair_color_1',
		'hair_color_2',
		'eyebrows_1',
		'eyebrows_2',
		'eyebrows_3',
		'eyebrows_4',
		'ears_1',
		'ears_2',
        'chest_1',
        'chest_2',
        'chest_3',
        'tshirt_1',
        'tshirt_2',
        'torso_1',
        'torso_2',
        'arms',
        'arms_2',
        'pants_1',
        'pants_2',
        'shoes_1',
        'shoes_2',
        'mask_1',
        'mask_2',
        'chain_1',
        'chain_2',
        'helmet_1',
        'helmet_2',
        'glasses_1',
        'glasses_2',
        'watches_1',
        'watches_2',
        'bracelets_1',
        'bracelets_2',
        'bags_1',
        'bags_2',

        
	})

end

AddEventHandler('esx_plasticsurgery:hasEnteredMarker', function(zone)
	CurrentAction     = 'shop_menu'
	
	CurrentActionData = {}
end)

AddEventHandler('esx_plasticsurgery:hasExitedMarker', function(zone)
	
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil

	if not HasPayed then

		TriggerEvent('esx_skin:getLastSkin', function(skin)
			TriggerEvent('skinchanger:loadSkin', skin)
		end)

	end

end)




-- client.lua
function CreateNPC(type,model,anim,dict,pos,help,key,range,start,finish)
    Citizen.CreateThread(function()
      -- Define variables
      local hash = GetHashKey(model)
      local talking = false
  
      -- Loads model
      RequestModel(hash)
      while not HasModelLoaded(hash) do
        Wait(1)
      end
  
      -- Loads animation
      RequestAnimDict(anim)
      while not HasAnimDictLoaded(anim) do
        Wait(1)
      end
  
  
      local ped = CreatePed(type, hash, pos.x, pos.y, pos.z, pos.h, false, true)
      SetEntityHeading(ped, pos.h)
      FreezeEntityPosition(ped, true)
      SetEntityInvincible(ped, true)
      SetBlockingOfNonTemporaryEvents(ped, true)
      TaskPlayAnim(ped,anim,dict, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
      
      while true do
        Citizen.Wait(0)
        local your = GetEntityCoords(GetPlayerPed(-1), false)
        if(Vdist(pos.x, pos.y, pos.z, your.x, your.y, your.z) < range)then
          SetTextComponentFormat("STRING")
          AddTextComponentString(help)
          DisplayHelpTextFromStringLabel(0, 0, 1, -1)
          if(IsControlJustReleased(key[1], key[2]))then
            if not talking then
              talking = true
              start()
            else
              talking = false
              finish()
            end
          end
        end
      end
    end)
  end
  
  
  
  CreateNPC(4,Config.NPCModell,"mini@strip_club@idles@bouncer@base","base",Config.NPCPosition,Config.HelpNotify,{1,38},3,
    function()
      Citizen.Wait(10)
      OpenShopMenu() 
      PlaySoundFrontend(-1, Config.NpcSoundOpenMain, Config.NpcSoundOpenSound, 1)
    end,
    function()
      Citizen.Wait(10)
      ESX.UI.Menu.CloseAll()
    end)
