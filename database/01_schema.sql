CREATE DATABASE IF NOT EXISTS `icrp` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `icrp`;

CREATE TABLE IF NOT EXISTS `users` (
  `identifier` varchar(60) NOT NULL,
  `license` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `money` double DEFAULT 0,
  `bank` double DEFAULT 0,
  `permission_level` varchar(50) DEFAULT 'user',
  `last_seen` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `characters` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(50) NOT NULL,
  `birthdate` date DEFAULT NULL,
  `sex` enum('male','female','other') DEFAULT 'male',
  `phone_number` varchar(20) DEFAULT NULL,
  `ktp_number` varchar(30) DEFAULT NULL,
  `job` varchar(50) DEFAULT 'unemployed',
  `job_grade` int DEFAULT 0,
  `cash` double DEFAULT 0,
  `bank` double DEFAULT 0,
  `hunger` int DEFAULT 100,
  `thirst` int DEFAULT 100,
  `is_dead` tinyint(1) DEFAULT 0,
  `spawn_x` float DEFAULT 0,
  `spawn_y` float DEFAULT 0,
  `spawn_z` float DEFAULT 0,
  `last_position` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_characters_identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(100) NOT NULL,
  `type` varchar(50) DEFAULT 'civilian',
  `salary` double DEFAULT 0,
  `is_police` tinyint(1) DEFAULT 0,
  `is_ems` tinyint(1) DEFAULT 0,
  `is_mechanic` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `job_grades` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `grade` int NOT NULL,
  `name` varchar(60) NOT NULL,
  `label` varchar(80) NOT NULL,
  `salary` double DEFAULT 0,
  `permissions` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_job_grades_job` (`job_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `owned_vehicles` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `plate` varchar(20) NOT NULL,
  `vehicle_model` varchar(80) NOT NULL,
  `vehicle_name` varchar(80) DEFAULT NULL,
  `pos_x` float DEFAULT 0,
  `pos_y` float DEFAULT 0,
  `pos_z` float DEFAULT 0,
  `heading` float DEFAULT 0,
  `stored` tinyint(1) DEFAULT 1,
  `garage` varchar(50) DEFAULT 'garage',
  `fuel` double DEFAULT 100,
  `engine_health` double DEFAULT 1000,
  `body_health` double DEFAULT 1000,
  `keys` int DEFAULT 1,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_plate` (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `owned_properties` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `property_name` varchar(100) NOT NULL,
  `property_type` varchar(50) DEFAULT 'house',
  `price` double DEFAULT 0,
  `coords` longtext DEFAULT NULL,
  `is_rented` tinyint(1) DEFAULT 0,
  `tenant_identifier` varchar(60) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `businesses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_identifier` varchar(60) DEFAULT NULL,
  `name` varchar(120) NOT NULL,
  `type` varchar(50) NOT NULL,
  `coords` longtext DEFAULT NULL,
  `money` double DEFAULT 0,
  `stock` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `inventory` (
  `id` int NOT NULL AUTO_INCREMENT,
  `owner_type` varchar(30) NOT NULL,
  `owner_id` varchar(60) NOT NULL,
  `item` varchar(100) NOT NULL,
  `count` int DEFAULT 0,
  `metadata` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_inventory_owner` (`owner_type`,`owner_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `banking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `account_name` varchar(80) DEFAULT 'Main Account',
  `bank_name` varchar(60) DEFAULT 'Bank Indonesia',
  `balance` double DEFAULT 0,
  `last_transaction` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_banking_identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `society` (
  `id` int NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) NOT NULL,
  `money` double DEFAULT 0,
  `label` varchar(120) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_society_job` (`job_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_contacts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone_number` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `phone_messages` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `target_identifier` varchar(60) DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `licenses` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `license_type` varchar(60) NOT NULL,
  `label` varchar(80) DEFAULT NULL,
  `acquired` tinyint(1) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_licenses_identifier` (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `police_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `officer_identifier` varchar(60) DEFAULT NULL,
  `description` text NOT NULL,
  `status` varchar(50) DEFAULT 'open',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `ems_records` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `medic_identifier` varchar(60) DEFAULT NULL,
  `description` text NOT NULL,
  `status` varchar(50) DEFAULT 'treated',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `admin_logs` (
  `id` int NOT NULL AUTO_INCREMENT,
  `admin_identifier` varchar(60) NOT NULL,
  `target_identifier` varchar(60) DEFAULT NULL,
  `action` varchar(120) NOT NULL,
  `details` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `player_notes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `note` text NOT NULL,
  `author_identifier` varchar(60) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `server_settings` (
  `key` varchar(100) NOT NULL,
  `value` longtext DEFAULT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
