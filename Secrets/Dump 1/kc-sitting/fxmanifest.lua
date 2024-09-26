fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Clementinise'
name 'KC Sit Anywhere'
description 'Sit anywhere, as simple as it sounds'
github 'https://github.com/clementinise/kc-sitting'
version '1.1.1'

shared_scripts {
	'locales/*.lua',
	'config.lua'
}

client_script 'client/client.lua'

server_script 'server/server.lua'

escrow_ignore {
  'config.lua',
  'locales/*.lua'
}

fivem_checker 'yes'
dependency '/assetpacks'