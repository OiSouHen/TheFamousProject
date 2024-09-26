fx_version 'cerulean'
game 'gta5'

author "HeyyCzer"
description "Script completo de tablet policial com sistema prisonal"

dependency "screenshot-basic" -- REQUIRED
dependency "PolyZone" -- Optional (required for zones/*.lua scripts)

lua54 'yes'

files {
	'src/nui/**',
}
ui_page 'src/nui/index.html'

shared_script {
	'@vrp/lib/utils.lua',
	"config/config.lua",
	"config/infractions.lua",
	"config/functions.lua",
	"src/shared.lua",
}

client_scripts {
	'@PolyZone/client.lua', -- only for zones/*.lua scripts

	'src/client.lua',
	'zones/escapeBlocker.lua'
}

server_scripts {
    "@vrp/config/Vehicle.lua",
	"@vrp/config/Global.lua",

	"config/license.lua",
	"config/hierarchy.lua",
	"config/webhooks.lua",
	'src/updater.lua',
	'src/server.lua',
}

escrow_ignore {
	'config/*.lua',
	'zones/*.lua',
}
