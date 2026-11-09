RegisterNetEvent('mechanic:server:repairVehicle')
AddEventHandler('mechanic:server:repairVehicle', function(source, vehicle)
  TriggerClientEvent('mechanic:client:repairVehicle', source, vehicle)
end)

RegisterNetEvent('mechanic:server:tuneVehicle')
AddEventHandler('mechanic:server:tuneVehicle', function(source, vehicle)
  TriggerClientEvent('mechanic:client:tuneVehicle', source, vehicle)
end)

print('[mechanic] Mechanic module loaded.')
