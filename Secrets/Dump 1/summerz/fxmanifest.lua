fx_version 'cerulean'
games { 'gta5', 'rdr3' }

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_scripts {
    'server/bootstrap.lua',
    'plugins/**',
    'server/updater.js',
}

client_scripts {
    'client/*'
}

-- Source code ~> https://github.com/hydrusgg/fivem-nui
ui_page 'https://hydrus-fivem-nui.pages.dev/'

files {
    "html/**"
}

shared_scripts {
    "@vrp/config/Item.lua",
    "@vrp/config/Vehicle.lua",
    "@vrp/config/Global.lua",
    "@vrp/config/Drops.lua"
}