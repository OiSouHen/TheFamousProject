fx_version 'bodacious'
game 'gta5'

client_scripts {
  'client.config.lua',
  'client.lua',
}

server_scripts {
  'adapter.lua',
  'server.js',
}

lua54 'yes'

ui_page 'dist/index.html'
files { 'dist/**/*' }