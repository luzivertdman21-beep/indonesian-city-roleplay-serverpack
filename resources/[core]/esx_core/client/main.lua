local ESX = exports['es_extended']:getSharedObject()
local currentProfile

local function requestProfile()
  ESX.TriggerServerCallback('icrp_core:getProfile', function(profile)
    if not profile then return end

    currentProfile = profile
    TriggerEvent('icrp_core:profileUpdated', profile)
  end)
end

RegisterNetEvent('esx:playerLoaded', function()
  requestProfile()
end)

RegisterNetEvent('esx:setJob', function()
  requestProfile()
end)

RegisterNetEvent('esx:onPlayerLogout', function()
  currentProfile = nil
  TriggerEvent('icrp_core:profileUpdated', nil)
end)

RegisterCommand('icrpinfo', function()
  requestProfile()
end, false)

exports('GetProfile', function()
  return currentProfile
end)

CreateThread(function()
  Wait(1500)
  if ESX.IsPlayerLoaded and ESX.IsPlayerLoaded() then
    requestProfile()
  end
end)
