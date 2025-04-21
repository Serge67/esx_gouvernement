-- Notification périodique
CreateThread(function()
    while true do
        Wait(Config.CollectionInterval)
        
        -- Afficher la notification périodique
        ESX.ShowNotification(Config.NotificationTitle .. ': ' .. Config.NotificationDescription)
    end
end)

-- Gérer les notifications de prélèvement
RegisterNetEvent('esx_gouvernement:showTaxNotification', function(amount)
    ESX.ShowNotification('Prélèvement d\'Impôts: ~r~-$' .. ESX.Math.GroupDigits(amount))
end)
