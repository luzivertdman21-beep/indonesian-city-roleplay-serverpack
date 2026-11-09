RegisterNetEvent('business:client:create')
AddEventHandler('business:client:create', function(name, type)
  TriggerServerEvent('business:server:createBusiness', GetPlayerServerId(PlayerId()), name, type)
end)
