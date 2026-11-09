Citizen.CreateThread(function()
  while true do
    Wait(1000)
    local ped = PlayerPedId()
    local health = GetEntityHealth(ped)
    local armor = GetPedArmour(ped)
    local hunger = 100
    local thirst = 100

    -- Minimal HUD state for demonstration
    SetTextFont(0)
    SetTextScale(0.0, 0.35)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
    SetTextEntry('STRING')
    AddTextComponentString(('HP:%s | ARMOR:%s | HUNGER:%s | THIRST:%s'):format(health, armor, hunger, thirst))
    DrawText(0.02, 0.89)
  end
end)
