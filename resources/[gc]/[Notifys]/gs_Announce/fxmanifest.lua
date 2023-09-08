fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "GS_Announce"
description "Announce"
author "GothamScripts"
version "1.0.0"

client_scripts {
    'client/*.lua',
}

server_scripts {
    'server/*.lua',
}

ui_page "web/index.html"

files {
    'web/index.html',
    'web/script.js',
    'web/style.css',
}