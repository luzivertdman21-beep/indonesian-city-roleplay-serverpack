USE `icrp`;

INSERT INTO `jobs` (`name`, `label`, `type`, `salary`, `is_police`, `is_ems`, `is_mechanic`) VALUES
('police', 'Polisi', 'government', 3000, 1, 0, 0),
('ambulance', 'EMS', 'government', 2800, 0, 1, 0),
('mechanic', 'Mekanik', 'government', 2600, 0, 0, 1),
('government', 'Pemerintah', 'government', 2500, 0, 0, 0),
('taxi', 'Taxi', 'civilian', 2200, 0, 0, 0),
('towing', 'Towing', 'civilian', 2400, 0, 0, 0),
('trucker', 'Trucker', 'civilian', 2300, 0, 0, 0),
('bus', 'Bus', 'civilian', 2100, 0, 0, 0),
('farmer', 'Petani', 'civilian', 2000, 0, 0, 0),
('fisherman', 'Nelayan', 'civilian', 2000, 0, 0, 0),
('miner', 'Penambang', 'civilian', 2200, 0, 0, 0),
('garbage', 'Tukang Sampah', 'civilian', 2000, 0, 0, 0),
('delivery', 'Kurir', 'civilian', 1800, 0, 0, 0),
('unemployed', 'Tidak Bekerja', 'civilian', 0, 0, 0, 0)
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`), `type` = VALUES(`type`), `salary` = VALUES(`salary`);

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `permissions`) VALUES
('police', 0, 'cadet', 'Cadet', 3000, '{"can_arrest":1,"can_impound":0}'),
('police', 1, 'officer', 'Officer', 3500, '{"can_arrest":1,"can_impound":1}'),
('police', 2, 'sergeant', 'Sersan', 4200, '{"can_arrest":1,"can_impound":1,"can_escort":1}'),
('police', 3, 'lieutenant', 'Letnan', 5000, '{"can_arrest":1,"can_impound":1,"can_escort":1,"can_promote":1}'),
('ambulance', 0, 'intern', 'Intern', 2800, '{"can_revive":1}'),
('ambulance', 1, 'paramedic', 'Paramedis', 3500, '{"can_revive":1,"can_heal":1}'),
('ambulance', 2, 'doctor', 'Dokter', 4300, '{"can_revive":1,"can_heal":1,"can_approve_bill":1}'),
('mechanic', 0, 'apprentice', 'Magang', 2600, '{"can_repair":1}'),
('mechanic', 1, 'technician', 'Teknisi', 3200, '{"can_repair":1,"can_tune":1}'),
('mechanic', 2, 'chief', 'Kepala', 3900, '{"can_repair":1,"can_tune":1,"can_manage":1}')
ON DUPLICATE KEY UPDATE `label` = VALUES(`label`), `salary` = VALUES(`salary`);

INSERT INTO `society` (`job_name`, `money`, `label`) VALUES
('police', 5000, 'Police Society'),
('ambulance', 4500, 'EMS Society'),
('mechanic', 4200, 'Mechanic Society')
ON DUPLICATE KEY UPDATE `money` = VALUES(`money`), `label` = VALUES(`label`);
