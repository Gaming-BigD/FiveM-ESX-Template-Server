fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "gs_deathscreen"
description "Deathscreen"
author "GothamScripts"
version "1.0.1"

client_scripts {
    'client/*.lua',
    'shared/*.lua',
}

ui_page "web/index.html"

files {
    'web/index.html',
    'web/script.js',
    'web/style.css',
    'web/img/*.png',
}

dependencies {
	'es_extended'
}

escrow_ignore{

	'shared/config.lua',
	'client/shared.lua'
}