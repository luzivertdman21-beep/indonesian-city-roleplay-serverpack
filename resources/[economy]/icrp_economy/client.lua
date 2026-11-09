local ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('icrp_economy:notify', function(message)
  if ESX and ESX.ShowNotification then
    ESX.ShowNotification(message)
  else
    TriggerEvent('chat:addMessage', { args = { 'Bank', message } })
  end
end)

RegisterCommand('mutasi', function()
  ESX.TriggerServerCallback('icrp_economy:getHistory', function(rows)
    if not rows or #rows == 0 then
      TriggerEvent('chat:addMessage', { args = { 'Bank', 'Belum ada transaksi.' } })
      return
    end
    TriggerEvent('chat:addMessage', { args = { 'Bank', 'Transaksi terakhir:' } })
    for _, row in ipairs(rows) do
      TriggerEvent('chat:addMessage', {
        args = { 'Bank', ('%s | %s | %s'):format(row.type, row.amount, row.description or '-') }
      })
    end
  end)
end, false)
