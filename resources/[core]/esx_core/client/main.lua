local function showWelcome(data)
  print(('Loaded %s'):format(data.serverName or 'Indonesian City Roleplay'))
end

RegisterNetEvent('esx_core:client:ready')
AddEventHandler('esx_core:client:ready', function()
  TriggerServerEvent('esx_core:server:ready')
end)

Citizen.CreateThread(function()
  Wait(1000)
  TriggerServerEvent('esx_core:server:registerPlayer', {
    identifier = 'license:demo',
    name = 'Player Demo'
  })
end)

RegisterNetEvent('esx_core:client:welcome')
AddEventHandler('esx_core:client:welcome', function(data)
  showWelcome(data)
end)
