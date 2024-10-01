fx_version "cerulean"
game "gta5"
lua54 "yes"

ui_page {
	"web/index.html"
}

client_scripts {
	"@vrp/config/Native.lua",
	"@vrp/lib/Utils.lua",
	"client/*"
}

files {
	"web/index.html",
	"web/css/*.css",
	"web/js/*.js",
	"web/assets/audio/*.mp3",
	"web/assets/images/*.png"
}