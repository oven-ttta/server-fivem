fx_version 'cerulean'
game 'gta5'

name 'admin_system'
description 'Admin System - Thai Roleplay Server'
author 'Thai RP Team'
version '1.0.0'

lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua',
    'server/commands.lua',
    'server/logs.lua'
}

client_scripts {
    'client/main.lua',
    'client/menu.lua'
}
