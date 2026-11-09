RegisterNetEvent('vehicle_manager:server:registerVehicle')
AddEventHandler('vehicle_manager:server:registerVehicle', function(source, plate, model)
  local data = {
    plate = plate,
    model = model,
    owner = source,
    stored = true,
    fuel = 100,
    engine_health = 1000,
    body_health = 1000
  }

  print(('[vehicle_manager] Registered vehicle plate=%s model=%s owner=%s'):format(plate, model, source))
  TriggerClientEvent('vehicle_manager:client:confirmation', source, data)
end)
