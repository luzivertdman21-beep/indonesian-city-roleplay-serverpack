RegisterNetEvent('logger:client:log')
AddEventHandler('logger:client:log', function(level, message)
  TriggerServerEvent('logger:server:log', level, message)
end)
