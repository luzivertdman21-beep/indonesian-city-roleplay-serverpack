RegisterNetEvent('mechanic:client:requestRepair')
AddEventHandler('mechanic:client:requestRepair', function(vehicle)
  TriggerServerEvent('mechanic:server:repairVehicle', GetPlayerServerId(PlayerId()), vehicle)
end)

RegisterNetEvent('mechanic:client:requestTune')
AddEventHandler('mechanic:client:requestTune', function(vehicle)
  TriggerServerEvent('mechanic:server:tuneVehicle', GetPlayerServerId(PlayerId()), vehicle)
end)
