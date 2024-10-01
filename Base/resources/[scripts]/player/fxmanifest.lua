fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@vrp/config/Global.lua",
	"@vrp/config/Native.lua",
	"@vrp/config/Item.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/Utils.lua",
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
	"web/**"
}