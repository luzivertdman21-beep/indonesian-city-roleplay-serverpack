fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name 'job_manager'
description 'Server-authoritative duty state for ESX jobs in Indonesian City Roleplay'
author 'Indonesian City Roleplay'
version '0.2.0'

shared_scripts {
  'config.lua'
}

client_scripts {
  'client.lua'
}

server_scripts {
  'server.lua'
}

dependencies {
  'es_extended',
  'esx_core'
}
