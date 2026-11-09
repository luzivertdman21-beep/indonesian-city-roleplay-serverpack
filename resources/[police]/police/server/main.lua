RegisterNetEvent('police:server:showLicenseCheck')
AddEventHandler('police:server:showLicenseCheck', function(source, targetId)
  TriggerClientEvent('police:client:showLicenseCheck', targetId, source)
end)

RegisterNetEvent('police:server:toggleWanted')
AddEventHandler('police:server:toggleWanted', function(source, targetId, isWanted)
  local target = tonumber(targetId)
  TriggerClientEvent('police:client:syncWanted', target, isWanted)
end)

print('[police] Police module loaded.')
