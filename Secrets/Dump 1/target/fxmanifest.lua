fx_version "bodacious"
game "gta5"
lua54 "yes"

dependencies {
    "PolyZone"
}

ui_page "web-side/index.html"

client_scripts {
	"@vrp/lib/Utils.lua",
	"@PolyZone/client.lua",
	"@PolyZone/BoxZone.lua",
	"@vrp/config/Native.lua",
	"@PolyZone/EntityZone.lua",
	"@PolyZone/CircleZone.lua",
	"@PolyZone/ComboZone.lua",
	"client-side/*"
}

server_scripts {
	"@vrp/lib/Utils.lua",
	"server-side/*"
}

files {
	"web-side/*"
}

shared_scripts {
	"@vrp/config/Item.lua",
	"@vrp/config/Vehicle.lua",
	"@vrp/config/Global.lua",
	"@vrp/config/Drops.lua",
	"shared-side/*"
}