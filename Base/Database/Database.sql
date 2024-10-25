DROP TABLE IF EXISTS `accounts`;
CREATE TABLE IF NOT EXISTS `accounts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Whitelist` tinyint(1) NOT NULL DEFAULT 0,
  `Characters` int(10) NOT NULL DEFAULT 1,
  `Gemstone` int(20) NOT NULL DEFAULT 0,
  `Premium` int(20) NOT NULL DEFAULT 0,
  `Discord` varchar(50) NOT NULL DEFAULT '0',
  `License` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `id` (`id`),
  KEY `Discord` (`Discord`),
  KEY `License` (`License`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `banneds`;
CREATE TABLE IF NOT EXISTS `banneds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `License` varchar(50) NOT NULL,
  `Token` varchar(255) NOT NULL,
  `Time` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

DROP TABLE IF EXISTS `characters`;
CREATE TABLE IF NOT EXISTS `characters` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `License` varchar(50) DEFAULT NULL,
  `Phone` varchar(10) DEFAULT NULL,
  `Name` varchar(50) DEFAULT 'Hensa',
  `Lastname` varchar(50) DEFAULT 'Rewritten',
  `Sex` varchar(1) DEFAULT NULL,
  `Skin` varchar(50) NOT NULL DEFAULT 'mp_m_freemode_01',
  `Bank` int(20) NOT NULL DEFAULT 5000,
  `Blood` int(1) NOT NULL DEFAULT 1,
  `Prison` int(10) NOT NULL DEFAULT 0,
  `Avatar` varchar(254) NOT NULL DEFAULT 'https://source.unsplash.com/random/',
  `Likes` int(20) NOT NULL DEFAULT 0,
  `Unlikes` int(20) NOT NULL DEFAULT 0,
  `Badge` int(3) NOT NULL DEFAULT 0,
  `Created` int(20) NOT NULL DEFAULT 0,
  `Login` int(20) NOT NULL DEFAULT 0,
  `Deleted` int(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `license` (`License`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `entitydata`;
CREATE TABLE IF NOT EXISTS `entitydata` (
  `Name` varchar(100) NOT NULL,
  `Information` longtext DEFAULT NULL,
  PRIMARY KEY (`Name`),
  KEY `Information` (`Name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `entitydata` (`Name`, `Information`) VALUES ('Permissions:Admin', '{\"1\":1}');

DROP TABLE IF EXISTS `playerdata`;
CREATE TABLE IF NOT EXISTS `playerdata` (
  `Passport` int(10) NOT NULL,
  `Name` varchar(100) NOT NULL,
  `Information` longtext DEFAULT NULL,
  PRIMARY KEY (`Passport`,`Name`),
  KEY `Passport` (`Passport`),
  KEY `Information` (`Name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `chests`;
CREATE TABLE IF NOT EXISTS `chests` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Weight` int(10) NOT NULL DEFAULT 500,
  `Slots` int(20) NOT NULL DEFAULT 50,
  `Permission` varchar(50) NOT NULL DEFAULT 'Admin',
  `Premium` int(20) NOT NULL DEFAULT 0,
  `Bank` int(20) NOT NULL DEFAULT 0,
  `Logs` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `police_courses`;
CREATE TABLE IF NOT EXISTS `police_courses` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Passport` int(20) DEFAULT 0,
  `Police` int(20) DEFAULT 0,
  `Type` varchar(255) DEFAULT 'Segurança',
  `Date` varchar(255) DEFAULT '00/00/0000',
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `police_messages`;
CREATE TABLE IF NOT EXISTS `police_messages` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) DEFAULT 'Individuo Indigente',
  `Message` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `police_prisons`;
CREATE TABLE IF NOT EXISTS `police_prisons` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Passport` int(20) DEFAULT 1,
  `Police` int(20) NOT NULL DEFAULT 0,
  `Crimes` longtext DEFAULT NULL,
  `Notes` longtext DEFAULT NULL,
  `Fines` int(20) DEFAULT 0,
  `Services` int(20) DEFAULT 0,
  `Date` varchar(255) NOT NULL DEFAULT '00/00/0000 ás 00:00',
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `police_wanted`;
CREATE TABLE IF NOT EXISTS `police_wanted` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Passport` int(20) DEFAULT 1,
  `Police` int(20) NOT NULL DEFAULT 0,
  `Crime` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `propertys`;
CREATE TABLE IF NOT EXISTS `propertys` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(20) NOT NULL DEFAULT 'Homes0001',
  `Interior` varchar(20) NOT NULL DEFAULT 'Middle',
  `Item` int(3) NOT NULL DEFAULT 3,
  `Tax` int(20) NOT NULL DEFAULT 0,
  `Passport` int(11) NOT NULL DEFAULT 0,
  `Serial` varchar(10) NOT NULL,
  `Vault` int(6) NOT NULL DEFAULT 1,
  `Fridge` int(6) NOT NULL DEFAULT 1,
  `Garage` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `id` (`id`),
  KEY `Passport` (`Passport`),
  KEY `Name` (`Name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `races`;
CREATE TABLE IF NOT EXISTS `races` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `Race` int(5) NOT NULL DEFAULT 0,
  `Passport` int(10) NOT NULL DEFAULT 0,
  `Vehicle` varchar(50) NOT NULL DEFAULT 'Hensa',
  `Points` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `Race` (`Race`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `vehicles`;
CREATE TABLE IF NOT EXISTS `vehicles` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `Passport` int(10) NOT NULL DEFAULT 0,
  `Vehicle` varchar(100) DEFAULT NULL,
  `Tax` int(20) NOT NULL DEFAULT 0,
  `Plate` varchar(10) DEFAULT NULL,
  `Weight` int(9) NOT NULL DEFAULT 0,
  `Rental` int(20) NOT NULL DEFAULT 0,
  `Arrest` int(20) NOT NULL DEFAULT 0,
  `Block` tinyint(1) NOT NULL DEFAULT 0,
  `Dismantle` int(20) NOT NULL DEFAULT 0,
  `Engine` int(4) NOT NULL DEFAULT 1000,
  `Body` int(4) NOT NULL DEFAULT 1000,
  `Health` int(4) NOT NULL DEFAULT 1000,
  `Fuel` int(3) NOT NULL DEFAULT 100,
  `Nitro` int(5) NOT NULL DEFAULT 0,
  `Work` varchar(5) NOT NULL DEFAULT 'false',
  `Mode` varchar(9) NOT NULL DEFAULT 'normal',
  `Doors` longtext NOT NULL,
  `Windows` longtext NOT NULL,
  `Tyres` longtext NOT NULL,
  `Brakes` longtext NOT NULL,
  `Drift` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `Vehicle` (`Vehicle`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `warehouse`;
CREATE TABLE IF NOT EXISTS `warehouse` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `Name` varchar(50) NOT NULL,
  `Weight` int(20) NOT NULL DEFAULT 50,
  `Password` varchar(50) NOT NULL,
  `Passport` int(10) NOT NULL DEFAULT 0,
  `Tax` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `fines`;
CREATE TABLE IF NOT EXISTS `fines` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Passport` int(10) NOT NULL DEFAULT 0,
  `Name` varchar(50) NOT NULL,
  `Date` varchar(50) NOT NULL,
  `Hour` varchar(50) NOT NULL,
  `Price` int(20) NOT NULL,
  `Message` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `investments`;
CREATE TABLE IF NOT EXISTS `investments` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `Passport` int(10) NOT NULL DEFAULT 0,
  `Liquid` int(20) NOT NULL DEFAULT 0,
  `Monthly` int(20) NOT NULL DEFAULT 0,
  `Deposit` int(20) NOT NULL DEFAULT 0,
  `Last` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `invoices`;
CREATE TABLE IF NOT EXISTS `invoices` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `Passport` int(10) NOT NULL DEFAULT 0,
  `Received` int(10) NOT NULL DEFAULT 0,
  `Type` varchar(50) NOT NULL,
  `Reason` longtext NOT NULL,
  `Holder` varchar(50) NOT NULL,
  `Price` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `taxs`;
CREATE TABLE IF NOT EXISTS `taxs` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `Passport` int(10) NOT NULL DEFAULT 0,
  `Name` varchar(50) NOT NULL,
  `Date` varchar(50) NOT NULL,
  `Hour` varchar(50) NOT NULL,
  `Price` int(20) NOT NULL,
  `Message` longtext DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

DROP TABLE IF EXISTS `transactions`;
CREATE TABLE IF NOT EXISTS `transactions` (
  `id` int(20) NOT NULL AUTO_INCREMENT,
  `Passport` int(10) NOT NULL DEFAULT 0,
  `Type` varchar(50) NOT NULL,
  `Date` varchar(50) NOT NULL,
  `Price` int(20) NOT NULL,
  `Balance` int(20) NOT NULL,
  `Timeset` int(20) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `Passport` (`Passport`),
  KEY `id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;