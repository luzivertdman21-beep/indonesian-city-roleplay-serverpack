Config = Config or {}

-- Only jobs listed here can toggle duty. Job assignment and grades remain managed by ESX.
Config.DutyJobs = {
  police = { label = 'Polisi', service = true },
  ambulance = { label = 'EMS', service = true },
  mechanic = { label = 'Mekanik', service = true },
  government = { label = 'Pemerintah', service = true },
  taxi = { label = 'Taksi', service = false },
  towing = { label = 'Towing', service = false },
  delivery = { label = 'Kurir', service = false },
  garbage = { label = 'Petugas Kebersihan', service = false },
  bus = { label = 'Sopir Bus', service = false },
  miner = { label = 'Penambang', service = false },
  farmer = { label = 'Petani', service = false },
  fisherman = { label = 'Nelayan', service = false }
}

Config.DutyCommand = 'duty'
