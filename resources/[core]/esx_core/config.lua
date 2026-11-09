Config = {}

Config.Locale = 'id'
Config.ServerName = 'Indonesian City Roleplay'
Config.DefaultSpawn = { x = -1036.0, y = -2731.0, z = 20.0 }
Config.MaxCharacters = 3
Config.Debug = true
Config.Economy = {
  cashStart = 1000,
  bankStart = 2500,
  salaryInterval = 600000,
}

Config.JobSystem = {
  enabled = true,
  defaultJob = 'unemployed',
  jobs = {
    'police',
    'ambulance',
    'mechanic',
    'government',
    'taxi',
    'towing',
    'delivery',
    'garbage',
    'bus',
    'miner',
    'farmer',
    'fisherman',
    'unemployed'
  }
}

Config.Admin = {
  keyOpen = 0x760A9C6F,
  groups = {'superadmin', 'admin', 'moderator', 'support'}
}
