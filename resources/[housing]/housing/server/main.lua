RegisterNetEvent('housing:server:buyHouse')
AddEventHandler('housing:server:buyHouse', function(source, propertyName)
  print(('[housing] Player %s purchased property %s'):format(source, propertyName))
end)
