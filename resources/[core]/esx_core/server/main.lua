local ESX = exports['es_extended']:getSharedObject()

local function getAccountBalance(xPlayer, accountName)
  local account = xPlayer.getAccount(accountName)
  return account and account.money or 0
end

local function buildProfile(source)
  local xPlayer = ESX.GetPlayerFromId(source)
  if not xPlayer then
    return nil
  end

  local job = xPlayer.getJob()
  return {
    serverName = Config.ServerName,
    playerId = source,
    name = xPlayer.getName(),
    identifier = xPlayer.getIdentifier(),
    cash = xPlayer.getMoney(),
    bank = getAccountBalance(xPlayer, 'bank'),
    job = job and {
      name = job.name,
      label = job.label,
      grade = job.grade,
      gradeLabel = job.grade_label
    } or nil
  }
end

ESX.RegisterServerCallback('icrp_core:getProfile', function(source, cb)
  cb(buildProfile(source))
end)

RegisterCommand('icrpinfo', function(source)
  if source == 0 then
    print(('[icrp_core] %s | ESX integration active'):format(Config.ServerName))
    return
  end

  local profile = buildProfile(source)
  if not profile then return end

  TriggerClientEvent('chat:addMessage', source, {
    color = { 70, 160, 255 },
    multiline = false,
    args = { 'Kota', ('%s | ID %s | %s'):format(profile.serverName, profile.playerId, profile.job and profile.job.label or 'Tidak bekerja') }
  })
end, false)

AddEventHandler('onResourceStart', function(resourceName)
  if resourceName ~= GetCurrentResourceName() then return end

  MySQL.scalar('SELECT 1')
    :next(function()
      print(('[icrp_core] Database connection verified. %s'):format(Config.ServerName))
    end)
    :catch(function(err)
      print(('[icrp_core] Database check failed: %s'):format(err))
    end)
end)
