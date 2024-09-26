fx_version "bodacious"
game "gta5"
lua54 "yes"

version "6.0.0"
author "ImagicTheCat"

hensa "yes"
creator "yes"

client_scripts {
	"lib/Utils.lua",
	"config/Native.lua",

	"client/active.lua",
	"client/base.lua",
	"client/gui.lua",
	"client/hits.lua",
	"client/iplloader.lua",
	"client/local.lua",
	"client/noclip.lua",
	"client/objects.lua",
	"client/playanim.lua",
	"client/player.lua",
	"client/vehicles.lua"
}

server_scripts {
	"lib/Utils.lua",

	"modules/vrp.lua",
	"modules/core.lua",
	"modules/prepare.lua",
	"modules/webhooks.lua"
}

files {
	"lib/*",
	"config/*",
	"config/**/*"
}

shared_scripts {
	"config/Global.lua",
	"config/Groups.lua",
	"config/Influences.lua",
	"config/Item.lua",
	"config/License.lua",
	"config/Native.lua",
	"config/Rewards.lua",
	"config/Vehicle.lua",
	"config/Drops.lua"
}