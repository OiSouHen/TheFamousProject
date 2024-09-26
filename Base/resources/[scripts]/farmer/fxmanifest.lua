fx_version "bodacious"
game "gta5"
lua54 "yes"

client_scripts {
	"@vrp/config/Native.lua",
	"@vrp/lib/Utils.lua",
	"client/*"
}

server_scripts {
	"@vrp/config/Item.lua",
	"@vrp/lib/Utils.lua",
	"server/*"
}

shared_scripts {
	"shared/*"
}