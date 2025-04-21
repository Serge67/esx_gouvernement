-- Resource manifest for ESX Gouvernement
fx_version 'cerulean'
game 'gta5'

author 'ESX Framework'
description 'Système de gouvernement et de taxes ESX'
version '1.0.0'

shared_scripts {
    '@es_extended/imports.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'server/main.lua'
}

lua54 'yes'
