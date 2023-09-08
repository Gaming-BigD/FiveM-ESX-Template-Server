ESX = exports['es_extended']:getSharedObject()

--Run the code below if ESX nil is displayed in your console and delete the code above--

--ESX = nil
--TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Config = {}

Config.RoadPad = false --Set to true if you use RoadPad / Sync with RoadPad!
Config.SimCardDLC = false --Set to true if you use RoadPhone SimCard DLC

Config.PhoneCommand = "TogglePhone"

Config.ESXName = "esx" --change if you use different ESX name
Config.ESXVersion = "Legacy" --1.1 OR Legacy
Config.ESXplayerDeathEvent = "esx:onPlayerDeath" --Trigger when the player dies
Config.ESXplayerSpawnEvent = "esx:onPlayerSpawn" --Trigger when the player is revived  
Config.ESXAddonAccount = "esx_addonaccount:getSharedAccount"
Config.ESXGetEmployees = "esx_society:getEmployees"
Config.ESXSetJob = "esx_society:setJob"

Config.Locale = 'en' --DEFAULT LUA CODE LANGUAGE

Config.Fahrenheit = false --Set to true if you want to use Fahrenheit instead of Celsius

Config.SyncFlashlight = true --Set to true if you want to sync the flashlight with other players ( may take higher client performance )

Config.Items = {
     "phone",
     "purple_phone",
     "green_phone",
     "red_phone",
     "blue_phone",
     "black_phone"
}

Config.NeedItem = true --Need Item to open the phone (true/false) / If you set this to false you can open the phone without an item and the phone props dont work!
Config.RegisterKeyMapping = true --If you set RegisterKeyMapping to false you can only close the phone with ESC.
Config.OpenKey = 'f1' --Works only with RegisterKeyMapping true / https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
Config.OpenKeyNumber = 288 --Works only with RegisterKeyMapping false / https://docs.fivem.net/docs/game-references/controls/

--CONFIGURATE YOUR VOICECHAT HERE

Config.MumbleExport = "mumble-voip" --exports["mumble-voip"]
Config.PMAVoiceExport = "pma-voice" --exports["pma-voice"]


Config.UsePmaVoice = false --We recommend: https://github.com/AvarianKnight/pma-voice
Config.UseMumbleVoip = false --OLD AND KNOWN BROKEN, Please use PMAVoice
Config.UseSaltyChat = true --Works perfect with SaltyChat 2.6
Config.UseTokoVoip = false


Config.EventNumbers = { --PLEASE READ OUR DEVELOPER DOCUMENTATION FOR MORE INFORMATION
     ['77777'] = false
}


---Commands
Config.TwitterVerifyCommand = "twitterverify"

Config.EnableInstaVerifyCommand = true
Config.InstaVerifyCommand = "instaverify"

--Addons

Config.Addons = {
     ['leitstelle'] = true
}

Config.ValetServerSideCheck = true
Config.ValetPedModel = "s_m_y_valet_01"
Config.ValetRadius = 500.0 --Radius the car spawned and drive to the player
Config.ValetDeliveryPrice = 500 --How much it costs to have your car delivered
Config.OwnedVehiclesTable = "owned_vehicles" --Change this if you use a different table name for owned vehicles


-------Crypto-------

Config.Crypto = {
     ['Bitcoin'] = true,
     ['Monero'] = true,
     ['Ethereum'] = true,
     ['Cardano'] = true,
     ['Dogecoin'] = true,
     ['Litecoin'] = true,
     ['Tether'] = true,
     ['VeChain'] = true,
     ['BNB'] = true,
     ['Solana'] = true,
     ['XRP'] = true,
     ['Shiba Inu'] = true,
     ['Bitcoin Cash'] = true,
     ['Chainlink'] = true
}


-------Radio-------

Config.RemoveFromRadioWhenDead = true
Config.RadioNeedItem = false

Config.RadioItems = {
     "radio"
}

Config.lockedRadioChannels = { --Lock Radio Channels for Jobs
     { frq = 1, jobhasaccess = {"police"}},
     { frq = 2, jobhasaccess = {"ambulance"}},
     { frq = 3, jobhasaccess = {"police", "ambulance"}}, --Multiple Jobs
}


-------Billings-------

Config.myBilling = false 
Config.okokBilling = false
Config.JaksamBilling = false
Config.bcsCompanyManager = false


Config.VisnAre = false --Set to true if you use VisnAre script
Config.cdGarages = false --Set to true if you use cdGarages script

Config.oxInventory = false --Set to true if you use ox_inventory script

Config.UsePhoneProps = true --Do you want to use custom RoadPhone props?

Config.UserTable = "users" --Change if you use different table name
Config.CarDebug = false --Debug for car spawn name ( vehicle_names.lua )