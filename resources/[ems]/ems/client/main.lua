RegisterNetEvent('ems:client:requestRevive')
AddEventHandler('ems:client:requestRevive', function(targetId)
  TriggerServerEvent('ems:server:revivePlayer', GetPlayerServerId(PlayerId()), targetId)
end)

RegisterNetEvent('ems:client:requestHeal')
AddEventHandler('ems:client:requestHeal', function(targetId)
  TriggerServerEvent('ems:server:healPlayer', GetPlayerServerId(PlayerId()), targetId)
end)
