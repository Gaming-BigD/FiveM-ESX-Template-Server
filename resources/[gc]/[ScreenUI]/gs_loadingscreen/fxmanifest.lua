fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "GS_LOADINGSCREEN"
description "Ladebildschirm"
author "Gotham Scripts"
version "1.1.0"

files {
    'web/index.html',
    'web/style.css',
    'web/img/*.png',
    'web/img/*.jfif',
    'web/music/backgroundmusic.mp3'
}

loadscreen 'web/index.html'
loadscreen_manual_shutdown 'yes'
client_script 'client/client.lua'