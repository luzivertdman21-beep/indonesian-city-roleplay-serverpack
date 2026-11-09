RegisterNetEvent('ems:server:revivePlayer')
AddEventHandler('ems:server:revivePlayer', function(source, targetId)
  TriggerClientEvent('esx_ambulancejob:revive', targetId)
end)

RegisterNetEvent('ems:server:healPlayer')
AddEventHandler('ems:server:healPlayer', function(source, targetId)
  TriggerClientEvent('esx_ambulancejob:heal', targetId)
end)

print('[ems] EMS module loaded.')
