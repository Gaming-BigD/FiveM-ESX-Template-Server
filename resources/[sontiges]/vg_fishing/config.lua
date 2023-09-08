Config                = {}
Config.Debug          = false --shows zones on map and some stuff in console and serverconsole

Config.Marker = {
    id          = 27,
    colour      = {r = 0, g = 255, b = 0, a = 50},
    isRotating  = false,
    radius      = 1.0,
}

--max amount of fish allowed in inventory
Config.MaxAmountFish = 120
Config.MaxAmountTurtle = 4
Config.MaxAmountShark = 2

--max weight of fish that can be catched
Config.MaxWeightFish = 6
Config.MaxWeightTurtle = 2
Config.MaxWeightShark = 1
Config.MaxWeightFishNonFishingPlace = 2 


--how many points of ~1000-3000 are gonna removed per catch until its 0 and zone gets inactive
Config.ZoneImpactValueFish      = 20.0
Config.ZoneImpactValueTurtle    = 65.0
Config.ZoneImpactValueShark     = 120.0

--how long a deactivated zone will take until its reactivated, in hours
Config.ZoneDeadTime = 24.0

Config.TimePenalty = {
	["none"]	= 1.0,
	["morning"] = 0.6,
	["day"]		= 2.0,
	["evening"] = 0.8,
	["night"]	= 1.5,
}


--------------------------------------------------------
--=====Prices of the items players can sell==========--
--------------------------------------------------------
--First amount minimum price second maximum amount (the amount player will get is random between those two numbers)
Config.FishPrice = {a = 500, b = 1500} --THIS PRICE IS FOR EVERY 5 FISH ITEMS (5 kg)
Config.TurtlePrice = {a = 2000, b = 8000} 
Config.SharkPrice = {a = 10000, b = 25000} 

--Buy:
Config.FishingrodPrice = 3500
Config.FishingknifePrice = 900
Config.FishbaitPrice = 30
Config.TurtlebaitPrice = 85

--------------------------------------------------------
--=====Locations where players can buy or sell stuff========--
--------------------------------------------------------
Config.FishingShop = {x = 1694.823, y = 3755.388, z = 33.705} --Place where players can sell their fish
Config.SellFish = {x = -1038.686, y = -1396.931, z = 4.553} --Place where players can sell their fish
Config.SellTurtle = {x = 3613.875, y = 5025.807, z = 10.347} --Place where players can sell their turtles 
Config.SellShark = {x = 3824.538, y = 4444.896, z = 1.809} --Place where players can sell their sharks

--------------------------------------------------------
--====================Fishing Areas===================--
--------------------------------------------------------
-- fishchance defines the chance to lose the fish after hooking it
-- fishtime   defines the time it will take until a fish takes the lure
Config.FishingPlace = {
    {name = "AlamoSee_Flussmuendung_untenlinks", x = 292.003, y = 3734.295, z = 30.097, r = 200.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 20000, b = 44000}, active = true},
    {name = "AlamoSee_Flussmuendung_obenlinks", x = -231.863, y = 4300.354, z = 31.055, r = 50.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 20000, b = 44000}, active = true},
    {name = "AlamoSee_Flussobenlinks1", x = -590.910, y = 4428.511, z = 14.783, r = 50.0, fishchance = 75.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 35000}, active = true},
    {name = "AlamoSee_Flussobenlinks2", x = -1168.089, y = 4390.109, z = 4.694, r = 30.0, fishchance = 75.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 35000}, active = true},
    {name = "FlussmuendungMeerLinksoben", x = -1851.472, y = 4630.373, z = 0.049, r = 200.0, fishchance = 90.0, turtlechance = 75.0, sharkchance = 0.0, FishTime = {a = 25000, b = 55000}, active = true},
    {name = "Flussmitte1", x = -1526.216, y = 1512.210, z = 109.648, r = 30.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 35000}, active = true},
    {name = "Flussmitte2", x = -1537.627, y = 1694.484, z = 92.887, r = 30.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 35000}, active = true},
    {name = "Flussmitte3", x = -1434.648, y = 2001.743, z = 56.773, r = 30.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 20000, b = 44000}, active = true},
    {name = "Flussmitte4", x = -1413.223, y = 2181.142, z = 22.810, r = 30.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 20000, b = 44000}, active = true},
    {name = "Sumpf1", x = -1859.060, y = 2598.407, z = -0.079, r = 30.0, fishchance = 90.0, turtlechance = 75.0, sharkchance = 0.0, FishTime = {a = 16000, b = 35000}, active = true},
    {name = "Sumpf2", x = -1956.785, y = 2516.513, z = -0.089, r = 30.0, fishchance = 70.0, turtlechance = 90.0, sharkchance = 0.0, FishTime = {a = 16000, b = 25000}, active = true},
    {name = "Sumpf3", x = -2037.807, y = 2536.640, z = 0.0554, r = 30.0, fishchance = 65.0, turtlechance = 90.0, sharkchance = 0.0, FishTime = {a = 16000, b = 44000,}, active = true},
    {name = "Sumpf4", x = -2064.731, y = 2598.476, z = -0.023, r = 30.0, fishchance = 70.0, turtlechance = 85.0, sharkchance = 0.0, FishTime = {a = 20000, b = 44000}, active = true},
    {name = "Sumpf5", x = -2256.337, y = 2649.990, z = 0.067, r = 30.0, fishchance = 75.0, turtlechance = 85.0, sharkchance = 0.0, FishTime = {a = 20000, b = 44000}, active = true},
    {name = "Sumpf6", x = -2627.669, y = 2778.485, z = 0.063, r = 98.0, fishchance = 65.0, turtlechance = 70.0, sharkchance = 0.0, FishTime = {a = 20000, b = 44000}, active = true},
    {name = "Sumpf7Meeresmuendung", x = -2879.267, y = 2618.448, z = 0.669, r = 198.0, fishchance = 80.0, turtlechance = 70.0, sharkchance = 20.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "Sumpf8", x = -2522.945, y = 2569.472, z = -0.080, r = 100.0, fishchance = 75.0, turtlechance = 80.0, sharkchance = 0.0, FishTime = {a = 20000, b = 44000}, active = true},
    {name = "Sumpf9", x = -2176.587, y = 2582.393, z = -0.019, r = 75.0, fishchance = 75.0, turtlechance = 80.0, sharkchance = 0.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "Sumpf10", x = -1778.337, y = 2619.687, z = -0.064, r = 30.0, fishchance = 60.0, turtlechance = 85.0, sharkchance = 0.0, FishTime = {a = 20000, b = 49000}, active = true},
    {name = "SumpfFluss1", x = -1452.153, y = 2615.004, z = -0.041, r = 50.0, fishchance = 85.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 20000, b = 44000}, active = true},
    {name = "SumpfFluss2", x = -1344.037, y = 2641.458, z = 0.047, r = 50.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 49000}, active = true},
    {name = "SumpfFluss3", x = -868.065, y = 2803.000, z = 9.685, r = 50.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "SumpfFluss4", x = -232.301, y = 2999.213, z = 18.338, r = 50.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "SumpfFluss5", x = 170.121, y = 3475.726, z = 29.965, r = 50.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 49000}, active = true},
    {name = "AlamoSeeLinksMitte", x = 111.804, y = 4034.215, z = 30.054, r = 80.0, fishchance = 95.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 49000}, active = true},
    {name = "AlamoSeeLinksOben", x = 411.446, y = 4308.902, z = 30.587, r = 50.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 35000}, active = true},
    {name = "AlamoSeeObenMitte1", x = 723.126, y = 4076.757, z = 30.100, r = 50.0, fishchance = 75.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 35000, b = 49000}, active = true},
    {name = "AlamoSeeObenMitte2", x = 975.152, y = 4235.273, z = 30.116, r = 80.0, fishchance = 85.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "AlamoSeeObenMitte3", x = 1310.264, y = 4236.510, z = 29.936, r = 80.0, fishchance = 70.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 40000, b = 55000}, active = true},
    {name = "AlamoSeeRechts", x = 2354.603, y = 4562.006, z = 29.917, r = 80.0, fishchance = 60.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 40000, b = 55000}, active = true},
    {name = "AlamoSeeUnten", x = 1456.382, y = 3869.854, z = 30.674, r = 80.0, fishchance = 60.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 40000, b = 60000}, active = true},
    {name = "AlamoSeeMittigHotspot", x = 1058.927, y = 3943.494, z = 30.421, r = 80.0, fishchance = 95.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 25000}, active = true},
    {name = "Bergteich1", x = 2563.698, y = 6154.510, z = 161.161, r = 35.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 20000, b = 49000}, active = true},
    {name = "Bergteich2", x = 3097.469, y = 6023.548, z = 121.775, r = 20.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 20000, b = 49000}, active = true},
    {name = "Staudamm1Steg", x = -193.130, y = 790.042, z = 198.107, r = 50.0, fishchance = 90.0, turtlechance = 20.0, sharkchance = 0.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "Staudamm2", x = 73.537, y = 823.875, z = 196.331, r = 50.0, fishchance = 90.0, turtlechance = 25.0, sharkchance = 0.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "Staudamm3", x = 1689.472, y = -1.504, z = 160.287, r = 80.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 35000}, active = true},
    {name = "Staudamm4", x = 1870.876, y = -34.053, z = 160.344, r = 80.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 40000}, active = true},
    {name = "Staudamm5", x = 1108.466, y = -199.469, z = 53.342, r = 50.0, fishchance = 60.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "CityteichRechts", x = 1070.018, y = -711.313, z = 55.208, r = 30.0, fishchance = 60.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 35000}, active = true},
    {name = "Hafen1", x = -983.469, y = -1363.997, z = -0.086, r = 10.0, fishchance = 80.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 16000, b = 35000}, active = true},
    {name = "Hafen2", x = -1004.171, y = -1372.737, z = -0.076, r = 10.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 18000, b = 49000}, active = true},
    {name = "Hafen3", x = -995.073, y = -1789.050, z = 0.432, r = 30.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 0.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "YachtClub", x = -3107.428, y = 2.316, z = 0.167, r = 30.0, fishchance = 90.0, turtlechance = 10.0, sharkchance = 5.0, FishTime = {a = 18000, b = 25000}, active = true},
    {name = "HaieRechts", x = 2927.872, y = -1070.799, z = 0.005, r = 200.0, fishchance = 60.0, turtlechance = 20.0, sharkchance = 90.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "Meer1", x = -3746.099, y = -522.844, z = 0.959, r = 300.0, fishchance = 90.0, turtlechance = 5.0, sharkchance = 90.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "Meer2", x = -3746.064, y = 2271.647, z = -0.389, r = 250.0, fishchance = 90.0, turtlechance = 20.0, sharkchance = 90.0, FishTime = {a = 16000, b = 49000}, active = true},
    {name = "Meer3", x = -1886.529, y = -1278.618, z = -2.052, r = 100.0, fishchance = 90.0, turtlechance = 0.0, sharkchance = 10.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "Meer4", x = 2895.8693, y = 1090.668, z = -0.144, r = 300.0, fishchance = 75.0, turtlechance = 90.0, sharkchance = 20.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "Meer5", x = 3069.873, y = 4.390, z = -0.034, r = 300.0, fishchance = 80.0, turtlechance = 10.0, sharkchance = 90.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "Meer6beiJagdgebiet", x = -1908.872, y = 5245.021, z = -0.048, r = 300.0, fishchance = 90.0, turtlechance = 30.0, sharkchance = 80.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "Meer7ganzUnten", x = -3750.053, y = -4402.134, z = -0.745, r = 600.0, fishchance = 90.0, turtlechance = 20.0, sharkchance = 95.0, FishTime = {a = 40000, b = 80000}, active = true},
    {name = "MeerLinksOben", x = -124.392, y = 7807.856, z = -0.784, r = 500.0, fishchance = 90.0, turtlechance = 80.0, sharkchance = 90.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "MeerRechtsOben", x = 3645.041, y = 5227.137, z = 0.194, r = 400.0, fishchance = 90.0, turtlechance = 80.0, sharkchance = 90.0, FishTime = {a = 25000, b = 49000}, active = true},
    {name = "MeerRechtsOben", x = 3530.217, y = 8019.708, z = -2.122, r = 600.0, fishchance = 90.0, turtlechance = 80.0, sharkchance = 90.0, FishTime = {a = 25000, b = 49000}, active = true},
}
Config.FishingNonePlace = {name = "EverywhereElse", fishchance = 50.0, turtlechance = 10.0, sharkchance = 3.0, FishTime = {a = 80000, b = 150000}, active = true}

