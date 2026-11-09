RegisterNetEvent('vehicle_manager:client:register')
AddEventHandler('vehicle_manager:client:register', function(plate, model)
  TriggerServerEvent('vehicle_manager:server:registerVehicle', GetPlayerServerId(PlayerId()), plate, model)
end)
