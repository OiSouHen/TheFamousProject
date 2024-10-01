fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@vrp/config/Native.lua",
	"@vrp/lib/Utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/config/Global.lua",
	"@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
	"server/*"
}

files {
	"web/*.*"
}