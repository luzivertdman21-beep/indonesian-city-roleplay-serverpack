local ESX = exports['es_extended']:getSharedObject()
local dutyBySource = {}

local function getPlayerJob(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  if not xPlayer then return nil end
  return xPlayer.getJob()
end

local function countOnDuty(jobName)
  local count = 0
  for source, isOnDuty in pairs(dutyBySource) do
    if isOnDuty then
      local job = getPlayerJob(source)
      if job and job.name == jobName then count = count + 1 end
    end
  end
  return count
end

local function sendDutyState(source, isOnDuty, message)
  local job = getPlayerJob(source)
  TriggerClientEvent('icrp_jobs:dutyChanged', source, {
    onDuty = isOnDuty,
    job = job and job.name or nil,
    label = job and job.label or 'Tidak bekerja',
    message = message
  })
end

local function toggleDuty(source)
  local job = getPlayerJob(source)
  local jobConfig = job and Config.DutyJobs[job.name]

  if not jobConfig then
    TriggerClientEvent('icrp_jobs:notify', source, 'Pekerjaan Anda tidak memiliki sistem duty.')
    return
  end

  dutyBySource[source] = not dutyBySource[source]
  local isOnDuty = dutyBySource[source]
  local state = isOnDuty and 'bertugas' or 'tidak bertugas'
  sendDutyState(source, isOnDuty, ('Anda sekarang %s sebagai %s.'):format(state, jobConfig.label))

  if jobConfig.service then
    TriggerClientEvent('icrp_jobs:serviceCount', -1, job.name, countOnDuty(job.name))
  end
end

RegisterCommand(Config.DutyCommand, function(source)
  if source == 0 then
    print(('[job_manager] /%s hanya dapat digunakan oleh pemain.'):format(Config.DutyCommand))
    return
  end
  toggleDuty(source)
end, false)

RegisterNetEvent('icrp_jobs:toggleDuty', function()
  toggleDuty(source)
end)

ESX.RegisterServerCallback('icrp_jobs:getDutyState', function(source, cb)
  local job = getPlayerJob(source)
  cb({ onDuty = dutyBySource[source] == true, job = job and job.name or nil })
end)

AddEventHandler('esx:playerLoaded', function(playerId)
  local src = tonumber(playerId) or source
  dutyBySource[src] = false
end)

AddEventHandler('esx:setJob', function(playerId, newJob, oldJob)
  local src = tonumber(playerId) or source
  local wasOnDuty = dutyBySource[src] == true
  dutyBySource[src] = false

  if wasOnDuty and oldJob and Config.DutyJobs[oldJob.name] and Config.DutyJobs[oldJob.name].service then
    TriggerClientEvent('icrp_jobs:serviceCount', -1, oldJob.name, countOnDuty(oldJob.name))
  end

  if newJob and Config.DutyJobs[newJob.name] and Config.DutyJobs[newJob.name].service then
    TriggerClientEvent('icrp_jobs:serviceCount', -1, newJob.name, countOnDuty(newJob.name))
  end

  if GetPlayerName(src) then
    sendDutyState(src, false, 'Status duty direset karena pekerjaan berubah.')
  end
end)

AddEventHandler('playerDropped', function()
  local src = source
  local job = getPlayerJob(src)
  local wasOnDuty = dutyBySource[src] == true
  dutyBySource[src] = nil

  if wasOnDuty and job and Config.DutyJobs[job.name] and Config.DutyJobs[job.name].service then
    TriggerClientEvent('icrp_jobs:serviceCount', -1, job.name, countOnDuty(job.name))
  end
end)

exports('IsOnDuty', function(playerId)
  return dutyBySource[tonumber(playerId)] == true
end)

exports('GetOnDutyCount', countOnDuty)

print('[job_manager] Server-authoritative duty system loaded.')
