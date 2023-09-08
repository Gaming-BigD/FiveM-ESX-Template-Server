Leitstelle = {}

Leitstelle.Positions = {
    {
        name = "Police",
        coords = vector3(441.0, -981.0, 29.7),
        number = 911,
        needjob = "police",
        marker = {
            drawDistance = 10.0,
            type = 25,
            size = {x = 4.0, y = 4.0, z = 4.0},
            color =  {r = 50, g = 50, b = 204}
        },
        blip = {
            active = true,
            name = "Police Control center",
            sprite = 60,
            color = 38,
            scale = 0.8,
            display = 4
        }
    },
    {
        name = "Ambulance",
        coords = vector3(298.0, -584.0, 43.0),
        number = 112,
        needjob = "ambulance",
        marker = {
            drawDistance = 10.0,
            type = 25,
            size = {x = 4.0, y = 4.0, z = 4.0},
            color =  {r = 50, g = 50, b = 204}
        },
        blip = {
            active = true,
            name = "Ambulance Control center",
            sprite = 61,
            color = 1,
            scale = 0.8,
            display = 4
        }
    }
}