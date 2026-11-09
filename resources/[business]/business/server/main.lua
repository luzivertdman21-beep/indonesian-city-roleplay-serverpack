RegisterNetEvent('business:server:createBusiness')
AddEventHandler('business:server:createBusiness', function(source, name, type)
  print(('[business] Business %s of type %s created by %s'):format(name, type, source))
end)
