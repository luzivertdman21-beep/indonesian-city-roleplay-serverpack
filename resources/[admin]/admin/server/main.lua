AddEventHandler('onResourceStart', function(resource)
  if resource == GetCurrentResourceName() then
    print('[admin] Admin module started.')
  end
end)

local function writeLog(adminId, targetId, action, details)
  local timestamp = os.date('%Y-%m-%d %H:%M:%S')
  print(('[admin_log] %s | admin=%s target=%s action=%s details=%s'):format(timestamp, adminId or 'system', targetId or 'none', action, details or ''))
end

RegisterCommand('settime', function(source, args)
  if source == 0 then
    SetWeatherTypeOverTime(args[1] or 'EXTRASUNNY', 1.0)
    TriggerClientEvent('chat:addMessage', -1, {
      color = {255,255,255},
      args = {'Server', 'Waktu server diubah oleh admin.'}
    })
  end
end, false)

RegisterCommand('healme', function(source)
  if source ~= 0 then
    TriggerClientEvent('esx_basicneeds:healPlayer', source)
    writeLog(source, source, 'healme', 'Self-heal triggered')
  end
end, false)

RegisterNetEvent('admin:server:logAction')
AddEventHandler('admin:server:logAction', function(adminId, targetId, action, details)
  writeLog(adminId, targetId, action, details)
end)
