Config = {}
Config.Locale = 'de'

Config.RequiredCopsRob = 0 --amount of cops required to start robbery
Config.RequiredCopsSell = 0 --amount of cops required to sell jewels
Config.MinJewels = 5 
Config.MaxJewels = 20  
Config.MaxWindows = 20  --maxmimum amount of jewel windows
Config.SecBetwNextRob = 3600 --1 hour
Config.MaxJewelsSell = 20 --maximum amount of jewels that can sell
Config.PriceForOneJewel = 500 --balckmoney
Config.EnableMarker = true
Config.NeedBag = false 
Config.AllowedWeapon = 'weapon_carbinerifle'

Config.reward = 'jewels'
Config.Borsoni = {40, 41, 44, 45}

Stores = {
	["jewelry"] = {
		position = { ['x'] =-630.88055419922, ['y'] = -230.83082580566, ['z'] = 37.91714019775 },       
		nameofstore = "jewelry",
		lastrobbed = 0
	}
}



