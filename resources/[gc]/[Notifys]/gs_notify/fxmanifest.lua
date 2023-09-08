fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "GS_Notify"
description "Notify"
author "GothamScripts"
version "1.0.0"

client_scripts {
    'client/*.lua',
}

ui_page "web/index.html"

files {
    'web/index.html',
    'web/script.js',
    'web/style.css',
}

escrow_ignore{

	'client/commands.lua'

}