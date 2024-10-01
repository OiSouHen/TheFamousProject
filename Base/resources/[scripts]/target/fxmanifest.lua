fx_version "bodacious"
game "gta5"
lua54 "yes"

dependencies {
    "PolyZone"
}

ui_page "web/index.html"

client_scripts {
	"@vrp/lib/Utils.lua",
	"@vrp/config/Item.lua",
	"@vrp/config/Native.lua",
	"@vrp/config/Vehicle.lua",
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"client/*"
}

server_scripts {
	"@vrp/config/Global.lua",
	"@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
	"server/*"
}

shared_scripts {
	"shared/*"
}

files {
	"web/*"
}