local ESX = exports['es_extended']:getSharedObject()
local dutyState = { onDuty = false }

local function notify(message)
  if ESX and ESX.ShowNotification then
    ESX.ShowNotification(message)
  else
    TriggerEvent('chat:addMessage', { args = { 'Pekerjaan', message } })
  end
end

RegisterNetEvent('icrp_jobs:dutyChanged', function(state)
  dutyState = state or { onDuty = false }
  if dutyState.message then notify(dutyState.message) end
  TriggerEvent('icrp_jobs:client:dutyChanged', dutyState)
end)

RegisterNetEvent('icrp_jobs:notify', notify)

RegisterNetEvent('icrp_jobs:serviceCount', function(jobName, count)
  TriggerEvent('icrp_jobs:client:serviceCount', jobName, count)
end)

RegisterCommand('duty', function()
  TriggerServerEvent('icrp_jobs:toggleDuty')
end, false)

RegisterNetEvent('esx:playerLoaded', function()
  ESX.TriggerServerCallback('icrp_jobs:getDutyState', function(state)
    dutyState = state or { onDuty = false }
    TriggerEvent('icrp_jobs:client:dutyChanged', dutyState)
  end)
end)

RegisterNetEvent('esx:setJob', function()
  dutyState = { onDuty = false }
  TriggerEvent('icrp_jobs:client:dutyChanged', dutyState)
end)

exports('IsOnDuty', function()
  return dutyState.onDuty == true
end)
