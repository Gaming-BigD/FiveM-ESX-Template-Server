fx_version 'bodacious'

game 'gta5'

author 'RoadShop | https://fivem.roadshop.org'
description 'RoadPhone FiveM Phone'
version '1.0.3'

lua54 'yes'

data_file 'DLC_ITYP_REQUEST' 'stream/prop/phonesilver.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/prop/phonegreen.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/prop/phoneblack.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/prop/phonelightblue.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/prop/phonepurple.ytyp'
data_file 'DLC_ITYP_REQUEST' 'stream/prop/phonered.ytyp'

ui_page 'public/index.html'

files {
    'public/index.html',
    'public/assets/*.*',
    'public/img/*.*',
    'public/img/**/*.*',
    'public/img/**/**/*.*',
    'public/static/sounds/*.ogg',
    'public/static/sounds/ringtones/*.ogg',
    'public/static/sounds/ringtones/*.mp3',
    'public/static/sounds/clock/*.mp3',
    'public/static/sounds/*.mp3',
    'public/static/config/config.json'
}

shared_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'locales/*.lua',
    'addons/**/config.lua'
}

server_scripts {
    --'@oxmysql/lib/MySQL.lua',
    '@mysql-async/lib/MySQL.lua',
    'API.lua',
    'server/server.lua',
    'server/serverAPI/serverAPI.lua',
    'server/service.lua',
    'server/twitter.lua',
    'server/serverAPI/valet.lua',
    'server/mail_app.lua',
    'server/versioncheck.lua',
    'server/billing.lua',
    'server/bank.lua',
    'server/crypto.lua',
    'server/messages.lua',
    'server/tellonym.lua',
    'server/instagram.lua',
    'server/yellowpages.lua',
    'server/notes.lua',
    'server/airdrop.lua',
    'addons/**/server/*.lua'
}

client_scripts {
    'client/client.lua',
    'client/clientAPI.lua',
    'client/animation.lua',
    'client/music.lua',
    'client/notes.lua',
    'client/camera.lua',
    'client/instagram.lua',
    'client/tellonym.lua',
    'client/twitter.lua',
    'client/service.lua',
    'client/valet.lua',
    'client/mail.lua',
    'client/yellowpages.lua',
    'client/vehicle_names.lua',
    'client/billing.lua',
    'client/airdrop.lua',
    'addons/**/client/*.lua'
}

escrow_ignore {
    'config.lua',
    'API.lua',
    'locales/*.lua',
    'client/clientAPI.lua',
    'client/vehicle_names.lua',
    'client/camera.lua',
    'server/serverAPI/*.lua',
    'client/animation.lua',
    'addons/**/config.lua'
}

dependencies {
    '/server:5848',
    '/onesync',
    'es_extended',
    'xsound'
}

exports {
    'isFlightmode',
    'isFlashlight',
    'togglePhone',
    'isPhoneOpen',
    'getPhoneNumber',
    'sendMessage',
    'isPlayerMuted',
    'startCall'
}

server_exports {
    'addcrypto',
    'removecrypto',
    'checkcryptoamount',
    'getPlayerFromPhone',
    'getNumberFromIdentifier',
    'sendAirdrop',
    'addBankTransaction'
}
dependency '/assetpacks'