fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page "web/index.html"

client_scripts {
	"@vrp/config/Native.lua",
	"@vrp/lib/Utils.lua",
	"client/*"
}

files {
	"web/index.html",
	"web/images/*.png",
	"web/sounds/*.mp3",
	"web/sounds/*.wav",
}