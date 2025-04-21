Config = {}

-- Configuration des taxes
Config.TaxRateSociety = 0.01 -- 1% pour les sociétés
Config.TaxRatePlayer = 0.10 -- 10% pour les joueurs
Config.CollectionInterval = 30000 -- 30 secondes (en millisecondes)

-- Configuration des notifications
Config.NotificationDuration = 5000 -- Durée en millisecondes
Config.NotificationTitle = 'Impôt Payé'
Config.NotificationDescription = 'Les impôts ont été prélevés des sociétés'

-- Configuration de la base de données
Config.Database = {
    societyAccount = 'society_gouvernement',
    excludedJobs = { 'unemployed' }
}
