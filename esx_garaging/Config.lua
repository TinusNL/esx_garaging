--[[
  _____   _                                 _   _   _
 |_   _| (_)  _ __    _   _   ___          | \ | | | |
   | |   | | | '_ \  | | | | / __|         |  \| | | |    
   | |   | | | | | | | |_| | \__ \         | |\  | | |___ 
   |_|   |_| |_| |_|  \__,_| |___/  _____  |_| \_| |_____|
                                   |_____|
]]--

Config = {

    Translation = 'EN', -- Language used

    Laptop = {
        MoneyType = true, --True= Bank | False= Cash
        MoneyAmount = 500, --Amount you need to pay for a vehicle to be returned
    },

    MoneyType = true, --True= Bank | False= Cash

    GarageTypes = { -- Garage types that can be used
        {
            TypeName = "2Car", -- Garage type name
            TypePrice = 50000,  -- Garage type price
            TypeDoor = vector3(179.19, -1000.64, -99.0), -- Garage type dood
            TypeLaptop = vector3(172.75, -1000.15, -99.0), -- Garage type laptop
            TypeBlip = { -- Garage type blip
                BlipInfo = "2 Vehicle Garage", -- Garage type blip information
                BlipSprite = 357, -- Garage type blip sprite. (-1 to disable blip)
                BlipSize = 1.25, -- Garage type blip size
            },
            TypeLocations = { -- Garage type vehicle locations and heading
                {Pos = vector3(175.21, -1003.91, -98.99), Heading = 167.96},
                {Pos = vector3(170.80, -1004.23, -98.99), Heading = 167.96}
            }
        },
        {
            TypeName = "4Car", 
            TypePrice = 75000, 
            TypeDoor = vector3(207.09, -1018.3, -99.0),  
            TypeLaptop = vector3(205.65, -1014.29, -99.0),
            TypeBlip = {
                BlipInfo = "4 Vehicle Garage",
                BlipSprite = 357,
                BlipSize = 1.25,
            },
            TypeLocations = {
                {Pos = vector3(194.50, -1016.14, -99.0), Heading = 180.13},
                {Pos = vector3(194.57, -1022.32, -99.0), Heading = 180.13},
                {Pos = vector3(202.21, -1020.14, -99.0), Heading = 90.13},
                {Pos = vector3(202.21, -1023.32, -99.0), Heading = 90.13}
            }
        },
        {
            TypeName = "6Car", 
            TypePrice = 100000, 
            TypeDoor = vector3(206.89, -999.21, -99.0),  
            TypeLaptop = vector3(205.97, -994.91, -99.0),
            TypeBlip = {
                BlipInfo = "6 Vehicle Garage",
                BlipSprite = 357,
                BlipSize = 1.25,
            },
            TypeLocations = {
                {Pos = vector3(203.82, -1004.63, -99.0), Heading = 88.05},
                {Pos = vector3(194.16, -1004.63, -99.0), Heading = 266.42},
                {Pos = vector3(193.83, -1000.63, -99.0), Heading = 266.42},
                {Pos = vector3(202.62, -1000.63, -99.0), Heading = 88.05},
                {Pos = vector3(193.83, -997.01, -99.0), Heading = 266.42},
                {Pos = vector3(202.62, -997.01, -99.0), Heading = 88.05},
            }
        },
        {
            TypeName = "10Car", 
            TypePrice = 150000, 
            TypeDoor = vector3(240.56, -1004.88, -99.0),
            TypeLaptop = vector3(234.84, -976.43, -99.0),
            TypeBlip = {
                BlipInfo = "10 Vehicle Garage",
                BlipSprite = 357,
                BlipSize = 1.25,
            },
            TypeLocations = {
                {Pos = vector3(233.47, -982.57, -99.0), Heading = 90.1},
                {Pos = vector3(233.47, -987.57, -99.0), Heading = 90.1},
                {Pos = vector3(233.47, -992.57, -99.0), Heading = 90.1},
                {Pos = vector3(233.47, -997.57, -99.0), Heading = 90.1},
                {Pos = vector3(233.47, -1002.57, -99.0), Heading = 90.1},
                {Pos = vector3(223.55, -982.57, -99.0), Heading = 266.36},
                {Pos = vector3(223.55, -987.57, -99.0), Heading = 266.36},
                {Pos = vector3(223.55, -992.57, -99.0), Heading = 266.36},
                {Pos = vector3(223.55, -997.57, -99.0), Heading = 266.36},
                {Pos = vector3(223.55, -1002.57, -99.0), Heading = 266.36},
            }
        }
    },

    Garages = { -- Garages
        --[[ WARNING: 
                1. When adding garages add them on the bottom. When added at the top player will get a different garage.
                2. The first garage will always be given to the player without being needed to be bought!
        ]]--

        -- 2 Car
        {GarageType = "2Car", DoorPos = vector3(316.01, -684.97, 29.66), SpawnPos = vector3(323.96, -678.71, 29.31), SpawnHeading = 251.68},
        {GarageType = "2Car", DoorPos = vector3(-1248.29, -1202.9, 7.42), SpawnPos = vector3(-1252.71, -1199.34, 7.15), SpawnHeading = 100.35},
        {GarageType = "2Car", DoorPos = vector3(261.84, -1821.84, 26.87), SpawnPos = vector3(259.28, -1824.68, 26.75), SpawnHeading = 138.64},
        {GarageType = "2Car", DoorPos = vector3(641.74, 260.59, 103.3), SpawnPos = vector3(634.42, 257.27, 103.08), SpawnHeading = 58.72},
        {GarageType = "2Car", DoorPos = vector3(2461.67, 1574.74, 33.11), SpawnPos = vector3(2468.42, 1589.63, 32.72), SpawnHeading = 268.88},
        {GarageType = "2Car", DoorPos = vector3(-3156.21, 1125.83, 20.85), SpawnPos = vector3(-3157.87, 1130.5, 20.85), SpawnHeading = 351.4},
        {GarageType = "2Car", DoorPos = vector3(59.35, 2795.45, 57.88), SpawnPos = vector3(63.24, 2795.93, 57.88), SpawnHeading = 50.33},
        {GarageType = "2Car", DoorPos = vector3(1941.06, 3842.09, 35.51), SpawnPos = vector3(1947.05, 3822.86, 32.02), SpawnHeading = 111.44},
        {GarageType = "2Car", DoorPos = vector3(1698.59, 6425.62, 32.76), SpawnPos = vector3(1692.99, 6425.45, 32.62), SpawnHeading = 152.55},
        {GarageType = "2Car", DoorPos = vector3(-2206.01, 4243.17, 48.13), SpawnPos = vector3(-2210.57, 4249.03, 47.41), SpawnHeading = 37.7},

        -- 4 Car
        {GarageType = "4Car", DoorPos = vector3(-1292.21, -279.43, 38.73), SpawnPos = vector3(-1289.17, -274.55, 38.83), SpawnHeading = 32.01},
        {GarageType = "4Car", DoorPos = vector3(-773.58, -187.96, 37.28), SpawnPos = vector3(-778.43, -185.11, 36.36), SpawnHeading = 116.79},
        {GarageType = "4Car", DoorPos = vector3(-106.61, 33.28, 71.43), SpawnPos = vector3(-107.76, 39.28, 71.45), SpawnHeading = 62.78},
        {GarageType = "4Car", DoorPos = vector3(896.69, -143.82, 76.83), SpawnPos = vector3(903.06, -142.74, 76.6), SpawnHeading = 325.02},
        {GarageType = "4Car", DoorPos = vector3(2544.77, 2591.76, 37.95), SpawnPos = vector3(2542.16, 2580.89, 37.94), SpawnHeading = 76.87},
        {GarageType = "4Car", DoorPos = vector3(-1135.36, 2682.12, 18.35), SpawnPos = vector3(-1133.86, 2695.87, 18.8), SpawnHeading = 142.13},
        {GarageType = "4Car", DoorPos = vector3(1860.01, 2719.65, 45.86), SpawnPos = vector3(1859.29, 2713.12, 45.94), SpawnHeading = 113.2},
        {GarageType = "4Car", DoorPos = vector3(905.83, 3586.77, 33.4), SpawnPos = vector3(903.24, 3589.93, 33.21), SpawnHeading = 266.89},
        {GarageType = "4Car", DoorPos = vector3(-359.49, 6062.75, 31.5), SpawnPos = vector3(-357.14, 6069.01, 31.5), SpawnHeading = 44.01},

        -- 6 Car
        {GarageType = "6Car", DoorPos = vector3(116.33, -1088.08, 29.22), SpawnPos = vector3(132.49, -1081.42, 29.19), SpawnHeading = 358.79},
        {GarageType = "6Car", DoorPos = vector3(-321.0, -1389.84, 36.5), SpawnPos = vector3(-325.48, -1400.84, 31.77), SpawnHeading = 87.69},
        {GarageType = "6Car", DoorPos = vector3(215.26, -1461.28, 29.19), SpawnPos = vector3(206.13, -1463.77, 29.15), SpawnHeading = 43.93},
        {GarageType = "6Car", DoorPos = vector3(670.11, -2667.88, 6.08), SpawnPos = vector3(666.55, -2672.82, 6.08), SpawnHeading = 93.46},
        {GarageType = "6Car", DoorPos = vector3(930.42, -1807.75, 31.33), SpawnPos = vector3(936.06, -1804.52, 30.81), SpawnHeading = 265.23},
        {GarageType = "6Car", DoorPos = vector3(188.25, 1241.28, 225.6), SpawnPos = vector3(177.8, 1246.14, 224.01), SpawnHeading = 282.65},
        {GarageType = "6Car", DoorPos = vector3(1645.53, 4843.77, 42.02), SpawnPos = vector3(1641.8, 4838.72, 42.03), SpawnHeading = 94.72},
        {GarageType = "6Car", DoorPos = vector3(-228.25, 6333.4, 32.42), SpawnPos = vector3(-229.72, 6351.82, 32.31), SpawnHeading = 254.96},
        {GarageType = "6Car", DoorPos = vector3(-223.73, 6243.65, 31.49), SpawnPos = vector3(-224.11, 6250.55, 31.49), SpawnHeading = 45.55},

        -- 10 Car
        {GarageType = "10Car", DoorPos = vector3(209.56, -938.27, 24.14), SpawnPos = vector3(213.42, -941.54, 24.14), SpawnHeading = 139.46},
        {GarageType = "10Car", DoorPos = vector3(-256.03, -448.63, 25.73), SpawnPos = vector3(-257.17, -438.99, 28.11), SpawnHeading = 17.16},
        {GarageType = "10Car", DoorPos = vector3(-519.7, -615.23, 26.33), SpawnPos = vector3(-514.88, -623.21, 25.31), SpawnHeading = 270.26},
        {GarageType = "10Car", DoorPos = vector3(-1028.22, -408.55, 33.41), SpawnPos = vector3(-1032.8, -408.05, 33.27), SpawnHeading = 25.71},
        {GarageType = "10Car", DoorPos = vector3(-2348.54, 262.7, 164.51), SpawnPos = vector3(-2352.86, 267.18, 165.39), SpawnHeading = 21.35},
        {GarageType = "10Car", DoorPos = vector3(-1079.2, -2242.27, 13.22), SpawnPos = vector3(-1084.32, -2229.97, 13.25), SpawnHeading = 314.04},
        {GarageType = "10Car", DoorPos = vector3(-1453.79, -3256.19, 13.94), SpawnPos = vector3(-1460.29, -3247.52, 13.94), SpawnHeading = 324.93},
        {GarageType = "10Car", DoorPos = vector3(15.43, 6435.35, 31.43), SpawnPos = vector3(35.12, 6444.09, 31.43), SpawnHeading = 224.52},
    },

}


-- Don't Touch!
Translations = {}