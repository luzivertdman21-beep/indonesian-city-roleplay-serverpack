-- Import into the same database used by ESX/oxmysql.
CREATE TABLE IF NOT EXISTS `icrp_transactions` (
  `id` BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(24) NOT NULL,
  `actor_identifier` VARCHAR(80) NOT NULL,
  `target_identifier` VARCHAR(80) DEFAULT NULL,
  `amount` BIGINT UNSIGNED NOT NULL,
  `description` VARCHAR(255) DEFAULT NULL,
  `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_icrp_transactions_actor_id` (`actor_identifier`, `id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
