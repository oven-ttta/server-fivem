Config = {}
Config.Locale = 'th'

Config.Accounts = {
    'bank',
    'black_money'
}

Config.StartingAccountMoney = {
    bank = 50000,
    black_money = 0
}

Config.StartingInventoryItems = false

Config.MaxWeight = 30
Config.PaycheckInterval = 7 * 60000
Config.EnableSociety = true

Config.EnableHud = true
Config.MaxPlayers = 32
Config.Multichar = true
Config.Identity = true

Config.RemoveWeaponDrops = true
Config.RemoveWeaponPickups = true

Config.EnableDebug = false
Config.EnableDefaultInventory = true
Config.EnableWantedLevel = false
Config.EnablePVP = true

Config.Marker = {
    Type = 1,
    Size = {x = 1.5, y = 1.5, z = 0.5},
    Color = {r = 102, g = 102, b = 204},
    DrawDistance = 100.0
}

Config.BossMarker = {
    Type = 1,
    Size = {x = 1.5, y = 1.5, z = 0.5},
    Color = {r = 204, g = 102, b = 102},
    DrawDistance = 100.0
}

Config.Blips = {
    Policejob = {
        Name = 'สถานีตำรวจ',
        Sprite = 60,
        Display = 4,
        Scale = 1.2,
        Color = 29,
        Coords = vector3(425.1, -979.5, 30.7)
    },
    Hospital = {
        Name = 'โรงพยาบาล',
        Sprite = 61,
        Display = 4,
        Scale = 1.2,
        Color = 2,
        Coords = vector3(307.7, -1433.4, 29.9)
    }
}
