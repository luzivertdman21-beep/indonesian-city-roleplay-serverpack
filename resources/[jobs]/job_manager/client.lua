RegisterNetEvent('job_manager:client:requestJobs')
AddEventHandler('job_manager:client:requestJobs', function()
  TriggerServerEvent('job_manager:server:getJobs', GetPlayerServerId(PlayerId()))
end)
