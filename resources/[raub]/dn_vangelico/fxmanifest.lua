fx_version 'adamant'

game 'gta5'

description 'DN Vangelico Robbery'

version '1.0.0'

client_scripts {
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'client/client.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/de.lua',
	'locales/br.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'server/server.lua'
}

lua54 'yes'

shared_script '@es_extended/imports.lua'
dependencies 'es_extended'
shared_script "@ox_lib/init.lua"
server_scripts { '@mysql-async/lib/MySQL.lua' }