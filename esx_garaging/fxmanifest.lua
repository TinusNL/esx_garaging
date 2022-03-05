fx_version 'adamant'

game 'gta5'

author 'Tinus_NL'
description 'Realistic Vehicle Garage Managing!'

client_scripts {
	-- Configuration
	'Config.lua',
	-- Translations
	'Translations/*.lua',
	-- Code
	'Client/Main.lua',
}

server_scripts {
	-- Configuration
	'Config.lua',
	-- Translations
	'Translations/*.lua',
	-- Database
	'@mysql-async/lib/MySQL.lua',
	-- Code
	'Server/Main.lua',
}

dependencies {
	'esx_vehicleshop',
	'esx_lscustom'
}