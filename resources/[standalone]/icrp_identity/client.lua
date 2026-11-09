local function displayCard(card)
  local lines = {
    ('Nomor KTP: %s'):format(card.ktpNumber),
    ('Nama: %s %s'):format(card.firstName, card.lastName),
    ('Tanggal lahir: %s'):format(card.birthdate),
    ('Jenis kelamin: %s'):format(card.sex),
    ('Nomor telepon: %s'):format(card.phoneNumber)
  }
  TriggerEvent('chat:addMessage', {
    color = { 40, 130, 220 },
    multiline = true,
    args = { ('KTP | ID %s'):format(card.playerId), table.concat(lines, '\n') }
  })
end

RegisterNetEvent('icrp_identity:showCard', displayCard)
RegisterNetEvent('icrp_identity:notify', function(message)
  TriggerEvent('chat:addMessage', { args = { 'KTP', message } })
end)

RegisterCommand('ktp', function(_, args)
  local target = tonumber(args[1])
  TriggerServerEvent('icrp_identity:requestCard', target)
end, false)
