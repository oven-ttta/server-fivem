fx_version 'cerulean'
game 'gta5'

name 'esx_policejob'
description 'ESX Police Job - Thai Roleplay Server'
author 'ESX Team / Modified'
version '1.8.0'

lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    'config/config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}

client_scripts {
    'client/main.lua',
    'client/vehicle.lua',
    'client/job.lua'
}

dependencies {
    'es_extended',
    'esx_billing'
}
