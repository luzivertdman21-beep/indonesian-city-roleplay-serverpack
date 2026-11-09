local function logInfo(message)
  print(('[esx_core] %s'):format(message))
end

MySQL = MySQL or exports['oxmysql']

if not MySQL then
  logInfo('Warning: oxmysql not detected yet. Server will continue but DB calls may fail until dependency is loaded.')
end

local function getDb()
  return exports['oxmysql']
end

local function bootstrapServer()
  logInfo('Core server initialised.')
  logInfo(('Server name: %s'):format(Config.ServerName))
  logInfo(('Max characters: %s'):format(Config.MaxCharacters))
end

RegisterNetEvent('esx_core:server:ready')
AddEventHandler('esx_core:server:ready', function()
  logInfo('Received ready event from client.')
end)

RegisterNetEvent('esx_core:server:registerPlayer')
AddEventHandler('esx_core:server:registerPlayer', function(source, data)
  local playerId = tonumber(source)
  local identifier = data.identifier or ('license:%s'):format(GetPlayerIdentifiers(playerId)[1] or 'unknown')

  local result = getDb():querySync('SELECT * FROM users WHERE identifier = ?', { identifier })
  if not result or #result == 0 then
    getDb():insert('users', {
      identifier = identifier,
      name = data.name or 'Player',
      money = Config.Economy.cashStart,
      bank = Config.Economy.bankStart
    })
  end

  TriggerClientEvent('esx_core:client:welcome', playerId, {
    serverName = Config.ServerName,
    message = 'Selamat datang di Indonesian City Roleplay.'
  })
end)

RegisterCommand('icrpinfo', function(source)
  local message = ('Server: %s | Max characters: %s | Locale: %s'):format(Config.ServerName, Config.MaxCharacters, Config.Locale)
  TriggerClientEvent('chat:addMessage', source, {
    color = {255, 255, 255},
    multiline = false,
    args = { 'Server', message }
  })
end, false)

bootstrapServer()
