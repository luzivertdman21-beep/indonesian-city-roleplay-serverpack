RegisterNetEvent('admin:client:triggerLog')
AddEventHandler('admin:client:triggerLog', function(targetId, action, details)
  TriggerServerEvent('admin:server:logAction', GetPlayerServerId(PlayerId()), targetId, action, details)
end)
