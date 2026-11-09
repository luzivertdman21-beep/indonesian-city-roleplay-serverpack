local inventory = {}

RegisterNetEvent('inventory:server:getInventory')
AddEventHandler('inventory:server:getInventory', function(source, ownerType, ownerId)
  local rows = MySQL.querySync('SELECT * FROM inventory WHERE owner_type = @ownerType AND owner_id = @ownerId', {
    ['@ownerType'] = ownerType,
    ['@ownerId'] = ownerId
  }) or {}

  TriggerClientEvent('inventory:client:sync', source, rows)
end)

RegisterNetEvent('inventory:server:addItem')
AddEventHandler('inventory:server:addItem', function(source, ownerType, ownerId, item, count, metadata)
  local db = exports['oxmysql']
  db:insert('inventory', {
    owner_type = ownerType,
    owner_id = ownerId,
    item = item,
    count = count or 1,
    metadata = metadata or '{}'
  })

  TriggerClientEvent('inventory:client:sync', source, { { item = item, count = count or 1, metadata = metadata or '{}' } })
end)
