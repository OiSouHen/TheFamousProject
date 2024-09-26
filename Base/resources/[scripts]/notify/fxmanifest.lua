fx_version "bodacious"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@vrp/config/Native.lua",
	"@PolyZone/client.lua",
	"@vrp/lib/Utils.lua",
	"client/*"
}

files {
	"web/*",
	"web/**/*"
}

shared_scripts {
	"shared/*"
}