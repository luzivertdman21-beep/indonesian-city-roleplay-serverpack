local ESX = exports['es_extended']:getSharedObject()
local lastRequest = {}

local function text(value)
  if value == nil or tostring(value) == '' then
    return Config.Identity.UnknownText
  end
  return tostring(value)
end

local function getValue(xPlayer, key)
  if xPlayer.get then
    return xPlayer.get(key)
  end
  return nil
end

local function getIdentityFields(xPlayer)
  local firstName = getValue(xPlayer, 'firstName') or getValue(xPlayer, 'firstname')
  local lastName = getValue(xPlayer, 'lastName') or getValue(xPlayer, 'lastname')
  local fullName = xPlayer.getName and xPlayer.getName() or nil

  if (not firstName or not lastName) and fullName then
    local first, rest = fullName:match('^(%S+)%s*(.*)$')
    firstName = firstName or first
    lastName = lastName or rest
  end

  local sex = getValue(xPlayer, 'sex')
  if sex == 'm' or sex == 'male' then
    sex = 'Laki-laki'
  elseif sex == 'f' or sex == 'female' then
    sex = 'Perempuan'
  end

  return {
    first_name = text(firstName),
    last_name = text(lastName),
    birthdate = text(getValue(xPlayer, 'dateofbirth') or getValue(xPlayer, 'dateOfBirth')),
    sex = text(sex),
    phone_number = text(getValue(xPlayer, 'phoneNumber') or getValue(xPlayer, 'phone_number'))
  }
end

local function ensureCard(xPlayer, cb)
  local identifier = xPlayer.getIdentifier()
  local fields = getIdentityFields(xPlayer)

  MySQL.insert([[
    INSERT INTO icrp_identity_cards (identifier, first_name, last_name, birthdate, sex, phone_number)
    VALUES (?, ?, ?, ?, ?, ?)
    ON DUPLICATE KEY UPDATE first_name = VALUES(first_name), last_name = VALUES(last_name),
      birthdate = VALUES(birthdate), sex = VALUES(sex), phone_number = VALUES(phone_number)
  ]], {
    identifier, fields.first_name, fields.last_name, fields.birthdate, fields.sex, fields.phone_number
  }, function()
    MySQL.single('SELECT id, ktp_number, first_name, last_name, birthdate, sex, phone_number FROM icrp_identity_cards WHERE identifier = ?', { identifier }, function(row)
      if not row then
        cb(nil)
        return
      end

      if row.ktp_number and row.ktp_number ~= '' then
        cb(row)
        return
      end

      local number = ('%s%08d'):format(Config.Identity.CardPrefix, row.id)
      MySQL.update('UPDATE icrp_identity_cards SET ktp_number = ? WHERE id = ? AND (ktp_number IS NULL OR ktp_number = "")', { number, row.id }, function()
        row.ktp_number = number
        cb(row)
      end)
    end)
  end)
end

local function isNearby(requester, target)
  if requester == target then return true end
  if GetPlayerRoutingBucket(requester) ~= GetPlayerRoutingBucket(target) then return false end

  local requesterPed = GetPlayerPed(requester)
  local targetPed = GetPlayerPed(target)
  if requesterPed == 0 or targetPed == 0 then return false end

  local a, b = GetEntityCoords(requesterPed), GetEntityCoords(targetPed)
  return #(a - b) <= Config.Identity.MaxDisplayDistance
end

RegisterNetEvent('icrp_identity:requestCard', function(targetId)
  local requester = source
  local now = GetGameTimer()
  if lastRequest[requester] and now - lastRequest[requester] < Config.Identity.RequestCooldownMs then
    TriggerClientEvent('icrp_identity:notify', requester, 'Tunggu sebentar sebelum meminta KTP lagi.')
    return
  end
  lastRequest[requester] = now

  local target = tonumber(targetId) or requester
  if target ~= math.floor(target) or not GetPlayerName(target) then
    TriggerClientEvent('icrp_identity:notify', requester, 'Pemain tidak ditemukan.')
    return
  end
  if not isNearby(requester, target) then
    TriggerClientEvent('icrp_identity:notify', requester, 'Pemain terlalu jauh untuk diperiksa.')
    return
  end

  local xTarget = ESX.GetPlayerFromId(target)
  if not xTarget then
    TriggerClientEvent('icrp_identity:notify', requester, 'Data karakter belum siap.')
    return
  end

  ensureCard(xTarget, function(card)
    if not card then
      TriggerClientEvent('icrp_identity:notify', requester, 'KTP gagal dimuat. Coba lagi.')
      return
    end
    TriggerClientEvent('icrp_identity:showCard', requester, {
      playerId = target,
      ktpNumber = card.ktp_number,
      firstName = card.first_name,
      lastName = card.last_name,
      birthdate = card.birthdate,
      sex = card.sex,
      phoneNumber = card.phone_number
    })
  end)
end)

AddEventHandler('playerDropped', function()
  lastRequest[source] = nil
end)

print('[icrp_identity] KTP module loaded.')
