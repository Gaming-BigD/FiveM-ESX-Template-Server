fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "GS_EINREISEV2"
description "EINREISE V2"
author "Gotham Scripts"
version "1.1.0"

client_scripts{
    'config.lua',
    'client.lua'
}

server_script{
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server.lua',
    'shared/servershared.lua',
}


ui_page "web/admin.html"

files {
    'web/admin.html',
    'web/script.js',
	'web/img/*.png',
    'web/style.css',
}

escrow_ignore
{
    "config.lua",
    'shared/servershared.lua',
}