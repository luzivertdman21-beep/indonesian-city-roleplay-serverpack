local function writeLog(level, message)
  print(('[logger] [%s] %s'):format(level, message))
end

AddEventHandler('onResourceStart', function(resource)
  if resource == GetCurrentResourceName() then
    writeLog('INFO', 'Logger activated.')
  end
end)

RegisterNetEvent('logger:server:log')
AddEventHandler('logger:server:log', function(level, message)
  writeLog(level or 'INFO', message or 'No message provided')
end)
