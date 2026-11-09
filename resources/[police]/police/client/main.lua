RegisterNetEvent('police:client:requestCheck')
AddEventHandler('police:client:requestCheck', function(targetId)
  TriggerServerEvent('police:server:showLicenseCheck', GetPlayerServerId(PlayerId()), targetId)
end)

RegisterNetEvent('police:client:setWanted')
AddEventHandler('police:client:setWanted', function(targetId, isWanted)
  TriggerServerEvent('police:server:toggleWanted', GetPlayerServerId(PlayerId()), targetId, isWanted)
end)
