RegisterNetEvent('phone:client:send')
AddEventHandler('phone:client:send', function(number, message)
  TriggerServerEvent('phone:server:sendSMS', GetPlayerServerId(PlayerId()), number, message)
end)
