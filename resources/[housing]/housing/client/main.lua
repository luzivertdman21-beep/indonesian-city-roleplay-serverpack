RegisterNetEvent('housing:client:buy')
AddEventHandler('housing:client:buy', function(propertyName)
  TriggerServerEvent('housing:server:buyHouse', GetPlayerServerId(PlayerId()), propertyName)
end)
