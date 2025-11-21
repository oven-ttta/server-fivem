Config = {}
Config.Locale = 'th'

Config.DrawDistance = 10.0
Config.MarkerSize = {x = 1.5, y = 1.5, z = 1.0}
Config.MarkerColor = {r = 50, g = 50, b = 204}
Config.MarkerType = 1

Config.EnablePlayerManagement = true
Config.EnableArmory = true
Config.EnableVehicles = true
Config.EnableLicenses = true

Config.MaxInService = -1
Config.EnableESXService = false

-- ระบบจับกุม
Config.HandcuffTimer = 10 * 60000 -- 10 นาที

-- ค่าปรับและเวลาคุก
Config.Fines = {
    {label = 'ขับรถเกินความเร็ว', price = 500},
    {label = 'ขับรถฝ่าไฟแดง', price = 800},
    {label = 'ทำร้ายร่างกาย', price = 5000},
    {label = 'มีอาวุธผิดกฎหมาย', price = 15000},
    {label = 'พยายามฆาตกรรม', price = 50000},
    {label = 'ลักทรัพย์', price = 10000},
    {label = 'ปล้นร้านค้า', price = 25000},
    {label = 'ปล้นธนาคาร', price = 100000},
    {label = 'ค้ายาเสพติด', price = 50000},
    {label = 'ขับรถโดยประมาท', price = 3000}
}

-- สถานีตำรวจ
Config.PoliceStations = {
    LSPD = {
        Blip = {
            Sprite = 60,
            Display = 4,
            Scale = 1.2,
            Color = 29
        },

        -- ตำแหน่งต่างๆ
        Cloakrooms = {
            vector3(452.6, -992.8, 30.6)
        },

        Armories = {
            vector3(451.7, -980.1, 30.6)
        },

        Vehicles = {
            {
                Spawner = vector3(454.6, -1017.4, 28.4),
                SpawnPoints = {
                    {coords = vector3(438.4, -1018.3, 27.7), heading = 90.0, radius = 6.0},
                    {coords = vector3(441.0, -1024.2, 28.3), heading = 90.0, radius = 6.0},
                    {coords = vector3(453.5, -1022.2, 28.0), heading = 90.0, radius = 6.0}
                }
            }
        },

        Helicopters = {
            {
                Spawner = vector3(461.1, -981.5, 43.6),
                SpawnPoints = {
                    {coords = vector3(449.5, -981.2, 43.6), heading = 92.6, radius = 10.0}
                }
            }
        },

        BossActions = {
            vector3(460.0, -985.7, 30.7)
        }
    }
}

-- รถตำรวจ
Config.AuthorizedVehicles = {
    {model = 'police', label = 'รถตำรวจ', price = 1},
    {model = 'police2', label = 'รถตำรวจ SUV', price = 1},
    {model = 'police3', label = 'รถตำรวจ Interceptor', price = 1},
    {model = 'policeb', label = 'มอเตอร์ไซค์ตำรวจ', price = 1},
    {model = 'policet', label = 'รถห้วงรถตำรวจ', price = 1},
    {model = 'sheriff', label = 'รถนายอำเภอ', price = 1},
    {model = 'polmav', label = 'เฮลิคอปเตอร์ตำรวจ', price = 1}
}

-- อาวุธตำรวจ
Config.AuthorizedWeapons = {
    recruit = {
        {weapon = 'WEAPON_NIGHTSTICK', price = 0},
        {weapon = 'WEAPON_FLASHLIGHT', price = 0},
        {weapon = 'WEAPON_STUNGUN', price = 0}
    },

    officer = {
        {weapon = 'WEAPON_NIGHTSTICK', price = 0},
        {weapon = 'WEAPON_FLASHLIGHT', price = 0},
        {weapon = 'WEAPON_STUNGUN', price = 0},
        {weapon = 'WEAPON_PISTOL', components = {0, 0, 1000, 4000, nil}, price = 0},
        {weapon = 'WEAPON_COMBATPISTOL', price = 0}
    },

    sergeant = {
        {weapon = 'WEAPON_NIGHTSTICK', price = 0},
        {weapon = 'WEAPON_FLASHLIGHT', price = 0},
        {weapon = 'WEAPON_STUNGUN', price = 0},
        {weapon = 'WEAPON_PISTOL', price = 0},
        {weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_CARBINERIFLE', price = 0},
        {weapon = 'WEAPON_PUMPSHOTGUN', price = 0}
    },

    lieutenant = {
        {weapon = 'WEAPON_NIGHTSTICK', price = 0},
        {weapon = 'WEAPON_FLASHLIGHT', price = 0},
        {weapon = 'WEAPON_STUNGUN', price = 0},
        {weapon = 'WEAPON_PISTOL', price = 0},
        {weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_CARBINERIFLE', price = 0},
        {weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
        {weapon = 'WEAPON_SNIPERRIFLE', price = 0}
    },

    boss = {
        {weapon = 'WEAPON_NIGHTSTICK', price = 0},
        {weapon = 'WEAPON_FLASHLIGHT', price = 0},
        {weapon = 'WEAPON_STUNGUN', price = 0},
        {weapon = 'WEAPON_PISTOL', price = 0},
        {weapon = 'WEAPON_COMBATPISTOL', price = 0},
        {weapon = 'WEAPON_CARBINERIFLE', price = 0},
        {weapon = 'WEAPON_PUMPSHOTGUN', price = 0},
        {weapon = 'WEAPON_SNIPERRIFLE', price = 0},
        {weapon = 'WEAPON_SPECIALCARBINE', price = 0}
    }
}
