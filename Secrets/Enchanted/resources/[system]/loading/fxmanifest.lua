fx_version "bodacious"
game "gta5"
lua54 "yes"

loadscreen_cursor "yes"
loadscreen_manual_shutdown "yes"
loadscreen "web-side/index.html"

server_script {
	"server-side/*"
}

files {
	"web-side/*",
	"web-side/**/*"
}

shared_scripts {
	"@vrp/config/Global.lua",
	"shared-side/*"
}