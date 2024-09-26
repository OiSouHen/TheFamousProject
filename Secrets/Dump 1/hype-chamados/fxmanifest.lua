fx_version "cerulean"
lua54 'yes'
game "gta5"

title "Hype - Chamados (Aplicativo LB Phone)"
description "Pensado e desenvolvido por Azevedo."
author "Azevedo - azvd.dev"

server_script {
    "@vrp/lib/Utils.lua",
    "src/_server.lua",
}

client_script {
    "@vrp/lib/Utils.lua",
    "src/_client.lua"
}

shared_script {
    "@vrp/lib/Utils.lua",
    "config/*.lua"
}

files {
    "ui/dist/*",
    "ui/dist/**/*"
}

escrow_ignore {
    'config/*',
    'ui/dist/*',
    'ui/dist/**/*'
}

ui_page "ui/dist/index.html"
-- ui_page "http://localhost:3000"

dependency '/assetpacks'
dependency 'lb-phone'