AddEventHandler('onResourceStart', function(resource)
  if resource == GetCurrentResourceName() then
    print('[job_manager] Job manager started.')
  end
end)

local defaultJobs = {
  police = { label = 'Polisi', salary = 3000 },
  ambulance = { label = 'EMS', salary = 2800 },
  mechanic = { label = 'Mekanik', salary = 2600 },
  government = { label = 'Pemerintah', salary = 2500 },
  taxi = { label = 'Taxi', salary = 2200 },
  delivery = { label = 'Kurir', salary = 1800 },
  unemployed = { label = 'Tidak Bekerja', salary = 0 }
}

RegisterNetEvent('job_manager:server:getJobs')
AddEventHandler('job_manager:server:getJobs', function(source)
  TriggerClientEvent('job_manager:client:setJobs', source, defaultJobs)
end)

RegisterNetEvent('job_manager:server:setJob')
AddEventHandler('job_manager:server:setJob', function(source, jobName)
  local job = defaultJobs[jobName] or defaultJobs.unemployed
  TriggerClientEvent('job_manager:client:jobUpdated', source, jobName, job)
end)
