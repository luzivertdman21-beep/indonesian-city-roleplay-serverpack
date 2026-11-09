RegisterNetEvent('phone:server:sendSMS')
AddEventHandler('phone:server:sendSMS', function(source, number, message)
  print(('[phone] SMS to %s from %s: %s'):format(number, source, message))
end)
