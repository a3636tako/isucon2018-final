
CREATE TABLE `orders` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` varchar(4) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `amount` bigint(20) NOT NULL,
  `price` bigint(20) NOT NULL,
  `closed_at` datetime(6) DEFAULT NULL,
  `trade_id` bigint(20) DEFAULT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`,`created_at`),
  KEY `type_closed_at_idx` (`type`,`closed_at`),
  KEY `user_id_idx` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=716911 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


CREATE TABLE `setting` (
  `name` varbinary(191) NOT NULL,
  `val` varchar(255) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `trade` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `amount` bigint(20) NOT NULL,
  `price` bigint(20) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`,`created_at`)
) ENGINE=InnoDB AUTO_INCREMENT=271305 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci


CREATE TABLE `user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `bank_id` varbinary(191) NOT NULL,
  `name` varchar(128) NOT NULL,
  `password` varbinary(191) NOT NULL,
  `created_at` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `bank_id` (`bank_id`)
) ENGINE=InnoDB AUTO_INCREMENT=13694 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


CREATE TABLE `candle` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `time` datetime NOT NULL,
  `time_str` char(20), NOT NULL,
  `open` bigint(20) NOT NULL,
  `close` bigint(20) NOT NULL,
  `high` bigint(20) NOT NULL,
  `low` bigint(20) NOT NULL
  PRIMARY KEY (`id`),
  UNIQUE KEY `time_str_idx` (`time_str`),
  KEY `time_idx` (`time`)
)