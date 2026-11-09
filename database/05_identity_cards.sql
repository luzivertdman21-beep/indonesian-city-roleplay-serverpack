-- Import into the same database used by ESX/oxmysql.
-- KTP numbers are server-generated RP identifiers, not real Indonesian NIK numbers.
CREATE TABLE IF NOT EXISTS `icrp_identity_cards` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `identifier` VARCHAR(80) NOT NULL,
  `ktp_number` VARCHAR(24) DEFAULT NULL,
  `first_name` VARCHAR(80) NOT NULL,
  `last_name` VARCHAR(80) NOT NULL,
  `birthdate` VARCHAR(24) NOT NULL,
  `sex` VARCHAR(24) NOT NULL,
  `phone_number` VARCHAR(32) NOT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uq_icrp_identity_identifier` (`identifier`),
  UNIQUE KEY `uq_icrp_identity_ktp_number` (`ktp_number`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
