fx_version "cerulean"
game "gta5"
lua54 "yes"

version "2.1.1"

shared_script {
    "config/*.lua",
    "shared/**/*.lua"
}

client_script {
    "@vrp/lib/Utils.lua",
    "client/**/*.lua"
}

server_scripts {
	"@vrp/lib/Utils.lua",
    "@oxmysql/lib/MySQL.lua",
    "server/**/*.lua",
}

files {
    "ui/dist/**/*",
    "ui/components.js",
    "config/**/*"
}

ui_page "ui/dist/index.html"

dependencies {
    "loaf_lib",
    "oxmysql"
}

escrow_ignore {
    "config/**/*",

    "client/apps/framework/**/*.lua",
    "server/apps/framework/**/*.lua",
    "shared/*.lua",

    "client/custom/**/*.lua",
    "server/custom/**/*.lua",

    "client/misc/debug.lua",
    "server/misc/debug.lua",

    "server/misc/functions.lua",
    "server/misc/databaseChecker/*.lua",

    "server/apiKeys.lua",

    "client/apps/default/weather.lua"
}

dependency '/assetpacks'