Config = {}

-- Configuration des taxes
Config.TaxRateSociety = 0.01 -- 1% pour les sociétés
Config.TaxRatePlayer = 0.10 -- 10% pour les joueurs
Config.CollectionInterval = 3600000 -- 1 heure (en millisecondes)

-- Configuration des notifications
Config.NotificationDuration = 5000 -- Durée en millisecondes
Config.NotificationTitle = 'Impôt Payé'
Config.NotificationDescription = 'Les impôts ont été prélevés' -- synchronisé avec collectes

-- Configuration de la base de données
Config.Database = {
    societyAccount = 'society_gouvernement',
    excludedJobs = { 'unemployed' }
}
