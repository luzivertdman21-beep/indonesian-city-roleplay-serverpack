fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'icrp_economy'
description 'Validated ESX bank, cash deposit/withdrawal, transfers, and transaction history'
author 'Indonesian City Roleplay'
version '0.1.0'

shared_scripts { 'config.lua' }
client_scripts { 'client.lua' }
server_scripts {
  '@oxmysql/lib/MySQL.lua',
  'server.lua'
}

dependencies { 'es_extended', 'oxmysql' }
