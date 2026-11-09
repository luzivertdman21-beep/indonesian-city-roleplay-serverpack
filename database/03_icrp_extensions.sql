# Import into the configured database after the upstream ESX SQL and the existing schema/seed files.
# This file contains only additions owned by this project and does not replace ESX tables.
CREATE TABLE IF NOT EXISTS `icrp_admin_logs` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `actor_identifier` VARCHAR(80) NOT NULL,
  `target_identifier` VARCHAR(80) DEFAULT NULL,
  `action` VARCHAR(80) NOT NULL,
  `details` JSON DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_icrp_admin_logs_actor_created` (`actor_identifier`, `created_at`),
  KEY `idx_icrp_admin_logs_target_created` (`target_identifier`, `created_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `icrp_settings` (
  `setting_key` VARCHAR(100) NOT NULL,
  `setting_value` TEXT DEFAULT NULL,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
