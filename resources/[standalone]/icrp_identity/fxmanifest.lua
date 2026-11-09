fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'icrp_identity'
description 'Server-validated Indonesian RP identity card display'
author 'Indonesian City Roleplay'
version '0.1.0'

shared_scripts { 'config.lua' }

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server.lua'
}

client_scripts { 'client.lua' }

dependencies { 'es_extended', 'oxmysql' }
