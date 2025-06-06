-- ESX est initialisé par es_extended via imports.lua
ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local function collectTaxes()
    -- Prélever les taxes sur les sociétés
    MySQL.Async.fetchAll('SELECT * FROM addon_account WHERE name LIKE @name', {
        ['@name'] = 'society_%'
    }, function(accounts)
        if accounts then
            for _, account in ipairs(accounts) do
                if account.name ~= Config.Database.societyAccount then
                    MySQL.Async.fetchScalar('SELECT money FROM addon_account_data WHERE account_name = @account', {
                        ['@account'] = account.name
                    }, function(money)
                        if money then
                            local tax = math.floor(money * Config.TaxRateSociety)
                            
                            if tax > 0 then
                                -- Prélever l'argent de la société
                                MySQL.Async.execute('UPDATE addon_account_data SET money = money - @tax WHERE account_name = @account', {
                                    ['@tax'] = tax,
                                    ['@account'] = account.name
                                })
                                
                                -- Ajouter l'argent au compte du gouvernement
                                MySQL.Async.execute('UPDATE addon_account_data SET money = money + @tax WHERE account_name = @account', {
                                    ['@tax'] = tax,
                                    ['@account'] = Config.Database.societyAccount
                                })
                                
                                -- Notifier les joueurs de la société
                                MySQL.Async.fetchAll('SELECT identifier FROM users WHERE job = @job', {
                                    ['@job'] = account.name
                                }, function(players)
                                    for _, player in ipairs(players) do
                                        local xPlayer = ESX.GetPlayerFromIdentifier(player.identifier)
                                        if xPlayer then
                                            TriggerClientEvent('esx_gouvernement:notifyTaxCollection', xPlayer.source, tax)
                                        end
                                    end
                                end)
                            end
                        end
                    end)
                end
            end
        end
    end)

    -- Prélever les taxes sur les joueurs
    local players = ESX.GetPlayers()
    print(('[esx_gouvernement] collectTaxes - players count: %s'):format(#players))
    for _, playerId in ipairs(players) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then print(('[esx_gouvernement] player %s job=%s'):format(xPlayer.getName(), xPlayer.job.name)) end
        if xPlayer and not table.contains(Config.Database.excludedJobs, xPlayer.job.name) then
            local bankAmount = xPlayer.getAccount('bank').money
            print(('[esx_gouvernement] %s bank=%s'):format(xPlayer.getName(), bankAmount))
            if bankAmount > 0 then
                local tax = math.floor(bankAmount * Config.TaxRatePlayer)
                print(('[esx_gouvernement] tax=%s for %s'):format(tax, xPlayer.getName()))
                
                if tax > 0 then
                    -- Prélever l'argent
                    print(('[esx_gouvernement] removing %s from %s'):format(tax, xPlayer.getName()))
                    xPlayer.removeAccountMoney('bank', tax)
                    
                    -- Ajouter l'argent au compte du gouvernement
                    MySQL.Async.execute('UPDATE addon_account_data SET money = money + @tax WHERE account_name = @account', {
                        ['@tax'] = tax,
                        ['@account'] = Config.Database.societyAccount
                    })
                    
                    -- Notifier le joueur comme pour les sociétés et log serveur
                    TriggerClientEvent('esx_gouvernement:notifyTaxCollection', xPlayer.source, tax)
                    print(('[Gouvernement] %s a été prélevé de %s$ de taxes'):format(xPlayer.getName(), tax))
                end
            end
        end
    end
end

-- Créer un timer pour collecter les taxes
CreateThread(function()
    while true do
        collectTaxes()
        Wait(Config.CollectionInterval)
    end
end)

-- Fonction utilitaire pour vérifier si une valeur est dans un tableau
function table.contains(table, element)
    for _, value in pairs(table) do
        if value == element then
            return true
        end
    end
    return false
end

-- Événement pour gérer les notifications de prélèvement des taxes
RegisterNetEvent('esx_gouvernement:notifyTaxCollection', function(source, amount)
    TriggerClientEvent('esx_gouvernement:showTaxNotification', source, amount)
end)
