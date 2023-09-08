fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "GS_EINREISEV2"
description "EINREISE V2"
author "Gotham Scripts"
version "1.2.0"

-- files {
    -- 'web/index.html',
    -- 'web/style.css',
    -- 'web/script.js',
    -- 'web/img/*.png',
    -- 'web/img/*.jfif',
    -- 'web/music/backgroundmusic.mp3',
-- }

server_script{
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server.lua',
}


ui_page "web/index.html"

client_script{
    'config.lua',
    'client.lua',
}

escrow_ignore{
    'config.lua',
}