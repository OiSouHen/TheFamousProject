fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "web-side/ui.html"

client_scripts {
	"@vrp/config/Native.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/Utils.lua",
	"client-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}

shared_scripts {
	"@vrp/config/Item.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Global.lua",
	"@vrp/config/Drops.lua",
	"shared-side/*"
}