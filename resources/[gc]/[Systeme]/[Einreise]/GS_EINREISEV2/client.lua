local isneu = false
local inMenu = false
local cooldown = 0
ESX = nil

local keys={}
keys[34]="A"
keys[29]="B"
keys[26]="C"
keys[30]="D"
keys[46]="E"
keys[49]="F"
keys[47]="G"
keys[74]="H"


keys[311]="K"
keys[7]="L"
keys[244]="M"
keys[249]="N"

keys[199]="P"
keys[44]="Q"
keys[45]="R"
keys[33]="S"
keys[245]="T"
keys[303]="U"
keys[0]="V"
keys[32]="W"
keys[77]="X"
keys[246]="Y"
keys[20]="Z"
keys[39]="["
keys[27]="UpArr"
keys[173]="DownArr"
keys[174]="LeftArr"
keys[175]="RightArr"
keys[19]="LAlt"
keys[168]="F7"
keys[288]="F1"
keys[289]="F2"
keys[170]="F3"
keys[166]="F5"
keys[167]="F6"
keys[56]="F9"
keys[57]="F10"
keys[344]="F11"
keys[157]="1"
keys[158]="2"
keys[160]="3"
keys[164]="4"
keys[165]="5"
keys[159]="6"
keys[161]="7"
keys[162]="8"
keys[163]="9"
keys[21]="LShift"

Citizen.CreateThread(function()
	while ESX == nil do
    if Config.SharedObject == "trigger" then
		  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    else
      return nil
    end
    if Config.SharedObject == "export" then
      ESX = exports["es_extended"]:getSharedObject()
    else
      return nil
    end
		Citizen.Wait(0)
	end
end)



RegisterNetEvent("gs:isneu") 
AddEventHandler("gs:isneu", function(neu)
    isneu = neu
end)

RegisterNetEvent("gs:flughafentp") 
AddEventHandler("gs:flughafentp", function(einreiseID)
    local ped = PlayerPedId()
    local currentPos = GetEntityCoords(ped)
    SetEntityCoords(ped, Config.EinreisepunktX, Config.EinreisepunktY, Config.EinreisepunktZ, false, false, false, true)
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        if isneu then
            local ped = PlayerPedId()
                if GetDistanceBetweenCoords(GetEntityCoords(ped), Config.EinreiseX, Config.EinreiseY, Config.EinreiseZ, true) < 250 then
                  DisableControlAction(0, 24, true) -- Attack
                  DisableControlAction(0, 257, true) -- Attack 2
                  DisableControlAction(0, 25, true) -- Aim
                  DisableControlAction(0, 263, true) -- Melee Attack 1
                  DisableControlAction(0, 22, true) -- Jump
                  DisableControlAction(0, 37, true) -- Select Weapon
                  DisableControlAction(0, 47, true)  -- Disable weapon
                  DisableControlAction(0, 264, true) -- Disable melee
                  DisableControlAction(0, 257, true) -- Disable melee
                  DisableControlAction(0, 140, true) -- Disable melee
                  DisableControlAction(0, 141, true) -- Disable melee
                  DisableControlAction(0, 142, true) -- Disable melee
                  DisableControlAction(0, 143, true) -- Disable melee
                else
                    SetEntityCoords(ped, Config.EinreiseX, Config.EinreiseY, Config.EinreiseZ, false, false, false, true)
            end
        end
    end
end)


RegisterNetEvent("gs:reinteleport")
AddEventHandler("gs:reinteleport", function(coords)
    local x, y, z = table.unpack(coords)
    SetEntityCoords(PlayerPedId(), x, y, z, false, false, false, true)
end)

Citizen.CreateThread(function()
  SetDeepOceanScaler(0.0)
end)



function showUI()
    SetNuiFocus(true, true)

    SendNUIMessage({
        type = "show",
        status = true,
    })

    inMenu = true
end

function closeUI()
    SetNuiFocus(false, false)

    SendNUIMessage({
        type = "show",
        status = false,
    })

    inMenu = false
end

RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)

    inMenu = false
end)




RegisterNUICallback("discord", function(data)
  closeUI()
  TriggerEvent('gs:discordeinreisemenu')

  
end)

RegisterNUICallback("Regelwerk", function(data)
  closeUI()
  TriggerEvent('gs:Regelwerkmenu')
end  )



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
    showUI() 
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
  end,
  function()
    closeUI()
  end)


  