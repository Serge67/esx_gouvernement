-- Initialiser ESX en client avant toute utilisation pour éviter le nil
ESX = nil
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Wait(0)
    end
end)

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

-- Gérer notifications envoyées par le serveur
RegisterNetEvent('esx_gouvernement:notifyTaxCollection', function(amount)
    ESX.ShowNotification('Prélèvement d\'Impôts: ~r~-$' .. ESX.Math.GroupDigits(amount))
end)
