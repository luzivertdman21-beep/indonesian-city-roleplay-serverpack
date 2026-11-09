local ESX = exports['es_extended']:getSharedObject()
local lastAction = {}

local function notify(source, message)
  TriggerClientEvent('icrp_economy:notify', source, message)
end

local function validAmount(raw)
  local amount = tonumber(raw)
  if not amount or amount ~= math.floor(amount) then return nil end
  if amount < Config.Economy.MinimumAmount or amount > Config.Economy.MaximumTransaction then return nil end
  return amount
end

local function getBank(xPlayer)
  local account = xPlayer.getAccount('bank')
  return account and account.money or nil
end

local function allowAction(source)
  local now = GetGameTimer()
  if lastAction[source] and now - lastAction[source] < Config.Economy.CommandCooldownMs then
    notify(source, 'Tunggu sebentar sebelum melakukan transaksi berikutnya.')
    return false
  end
  lastAction[source] = now
  return true
end

local function logTransaction(kind, actorIdentifier, targetIdentifier, amount, description)
  MySQL.insert([[
    INSERT INTO icrp_transactions (type, actor_identifier, target_identifier, amount, description)
    VALUES (?, ?, ?, ?, ?)
  ]], { kind, actorIdentifier, targetIdentifier, amount, description })
end

local function getPlayer(source)
  local player = ESX.GetPlayerFromId(source)
  if not player then notify(source, 'Data karakter belum siap.') end
  return player
end

RegisterCommand('saldo', function(source)
  if source == 0 then return end
  local player = getPlayer(source)
  if not player then return end
  local bank = getBank(player)
  if bank == nil then
    notify(source, 'Rekening bank tidak tersedia.')
    return
  end
  notify(source, ('Uang tunai: %s | Saldo bank: %s'):format(player.getMoney(), bank))
end, false)

RegisterCommand('deposit', function(source, args)
  if source == 0 then return end
  if not allowAction(source) then return end
  local player = getPlayer(source)
  local amount = validAmount(args[1])
  if not player then return end
  if not amount then notify(source, ('Jumlah harus bilangan bulat antara %s dan %s.'):format(Config.Economy.MinimumAmount, Config.Economy.MaximumTransaction)); return end
  if player.getMoney() < amount then notify(source, 'Uang tunai tidak mencukupi.'); return end
  if getBank(player) == nil then notify(source, 'Rekening bank tidak tersedia.'); return end

  player.removeMoney(amount, 'Setoran bank')
  player.addAccountMoney('bank', amount, 'Setoran bank')
  logTransaction('deposit', player.getIdentifier(), nil, amount, 'Setoran tunai ke rekening')
  notify(source, ('Setoran berhasil: %s.'):format(amount))
end, false)

RegisterCommand('withdraw', function(source, args)
  if source == 0 then return end
  if not allowAction(source) then return end
  local player = getPlayer(source)
  local amount = validAmount(args[1])
  if not player then return end
  if not amount then notify(source, ('Jumlah harus bilangan bulat antara %s dan %s.'):format(Config.Economy.MinimumAmount, Config.Economy.MaximumTransaction)); return end
  local bank = getBank(player)
  if bank == nil then notify(source, 'Rekening bank tidak tersedia.'); return end
  if bank < amount then notify(source, 'Saldo bank tidak mencukupi.'); return end

  player.removeAccountMoney('bank', amount, 'Penarikan bank')
  player.addMoney(amount, 'Penarikan bank')
  logTransaction('withdraw', player.getIdentifier(), nil, amount, 'Penarikan tunai dari rekening')
  notify(source, ('Penarikan berhasil: %s.'):format(amount))
end, false)

RegisterCommand('transfer', function(source, args)
  if source == 0 then return end
  if not allowAction(source) then return end
  local sender = getPlayer(source)
  local targetId = tonumber(args[1])
  local amount = validAmount(args[2])
  if not sender then return end
  if not targetId or targetId ~= math.floor(targetId) or targetId == source then
    notify(source, 'Gunakan /transfer ID_PEMAIN JUMLAH dan pilih pemain lain yang sedang online.')
    return
  end
  if not amount then notify(source, ('Jumlah harus bilangan bulat antara %s dan %s.'):format(Config.Economy.MinimumAmount, Config.Economy.MaximumTransaction)); return end

  local target = ESX.GetPlayerFromId(targetId)
  if not target then notify(source, 'Pemain tujuan tidak ditemukan.'); return end
  local senderBalance, targetBalance = getBank(sender), getBank(target)
  if senderBalance == nil or targetBalance == nil then notify(source, 'Rekening salah satu pemain tidak tersedia.'); return end
  if senderBalance < amount then notify(source, 'Saldo bank tidak mencukupi.'); return end

  -- No yield between balance validation and account updates: both in-memory ESX balances change together.
  sender.removeAccountMoney('bank', amount, 'Transfer pemain')
  target.addAccountMoney('bank', amount, 'Transfer pemain')
  logTransaction('transfer_out', sender.getIdentifier(), target.getIdentifier(), amount, 'Transfer ke pemain ID '..targetId)
  logTransaction('transfer_in', target.getIdentifier(), sender.getIdentifier(), amount, 'Transfer dari pemain ID '..source)
  notify(source, ('Transfer %s ke ID %s berhasil.'):format(amount, targetId))
  notify(targetId, ('Anda menerima transfer sebesar %s dari ID %s.'):format(amount, source))
end, false)

ESX.RegisterServerCallback('icrp_economy:getHistory', function(source, cb)
  local player = ESX.GetPlayerFromId(source)
  if not player then cb({}); return end

  MySQL.query([[
    SELECT type, amount, description, created_at
    FROM icrp_transactions
    WHERE actor_identifier = ?
    ORDER BY id DESC
    LIMIT ?
  ]], { player.getIdentifier(), Config.Economy.HistoryLimit }, function(rows)
    cb(rows or {})
  end)
end)

AddEventHandler('playerDropped', function()
  lastAction[source] = nil
end)

print('[icrp_economy] Bank commands ready: /saldo, /deposit, /withdraw, /transfer.')
