fx_version "bodacious"
game "gta5"
lua54 "yes"

version "6.0.0"
author "ImagicTheCat"

hensa "yes"
creator "yes"

client_scripts {
	"lib/Utils.lua",

	"config/Drops.lua",
	"config/Global.lua",
	"config/Groups.lua",
	"config/Item.lua",
	"config/License.lua",
	"config/Native.lua",
	"config/Vehicle.lua",

	"client/local.lua",
	"client/active.lua",

	"client/base.lua",
	"client/gui.lua",
	"client/iplloader.lua",
	"client/noclip.lua",
	"client/objects.lua",
	"client/playanim.lua",
	"client/player.lua",
	"client/vehicles.lua"
}

server_scripts {
	"lib/Utils.lua",

	"config/Drops.lua",
	"config/Global.lua",
	"config/Groups.lua",
	"config/Item.lua",
	"config/License.lua",
	"config/Native.lua",
	"config/Vehicle.lua",

	"modules/vrp.lua",
	"modules/core.lua",
	"modules/prepare.lua"
}

files {
	"lib/*",
	"config/*",
	"config/**/*",
	"config/**/**/*"
}