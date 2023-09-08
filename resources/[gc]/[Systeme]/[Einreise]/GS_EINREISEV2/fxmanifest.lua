fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "GS_EINREISEV2"
description "EINREISE V2"
author "Gotham Scripts"
version "1.2.0"

client_scripts{
    'config.lua',
    'client.lua',
    'shared/clientshared.lua',
}

server_script{
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server.lua',
    'shared/servershared.lua',
}


ui_page "web/index.html"

files {
    'web/index.html',
    'web/script.js',
	'web/img/*.png',
    'web/style.css',
}

escrow_ignore
{
    "config.lua",
    "shared/clientshared.lua",
    "shared/servershared.lua"
}