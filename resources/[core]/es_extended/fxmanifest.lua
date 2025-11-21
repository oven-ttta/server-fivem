fx_version 'cerulean'
game 'gta5'

name 'ES Extended Core'
description 'ESX Framework - Thai Roleplay Server'
author 'ESX Team / Modified for Thai Server'
version '1.9.4'

lua54 'yes'

shared_scripts {
    '@mysql-async/lib/MySQL.lua',
    'locale.lua',
    'locales/th.lua',
    'config.lua',
    'config.weapons.lua'
}

server_scripts {
    'server/common.lua',
    'server/classes/player.lua',
    'server/classes/overrides.lua',
    'server/functions.lua',
    'server/paycheck.lua',
    'server/main.lua',
    'server/commands.lua',
    'common/modules/math.lua',
    'common/modules/table.lua',
    'common/functions.lua'
}

client_scripts {
    'client/common.lua',
    'client/entityiter.lua',
    'client/functions.lua',
    'client/wrapper.lua',
    'client/main.lua',
    'common/modules/math.lua',
    'common/modules/table.lua',
    'common/functions.lua'
}

dependencies {
    'mysql-async',
    'spawnmanager',
    'skinchanger'
}
