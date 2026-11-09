fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'esx_core'
description 'ESX Legacy integration layer for Indonesian City Roleplay'
author 'Indonesian City Roleplay'
version '0.2.0'

shared_scripts {
  'config.lua'
}

client_scripts {
  'client/main.lua'
}

server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server/main.lua'
}

dependencies {
  'es_extended',
  'oxmysql'
}
