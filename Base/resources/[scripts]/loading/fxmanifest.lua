fx_version "bodacious"
game "gta5"
lua54 "yes"

loadscreen "web/index.html"
loadscreen_cursor "yes"
loadscreen_manual_shutdown "yes"

client_scripts {
	"client/*"
}

files {
	"web/*",
	"web/**/*"
}

shared_scripts {
	"@vrp/config/Global.lua",
	"shared/*"
}