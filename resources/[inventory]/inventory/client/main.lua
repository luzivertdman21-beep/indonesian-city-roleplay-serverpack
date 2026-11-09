RegisterNetEvent('inventory:client:ready')
AddEventHandler('inventory:client:ready', function()
  TriggerServerEvent('inventory:server:getInventory', 'player', tostring(GetPlayerServerId(PlayerId())))
end)

Citizen.CreateThread(function()
  while true do
    Wait(1000)
    -- placeholder idle loop for inventory module
  end
end)
