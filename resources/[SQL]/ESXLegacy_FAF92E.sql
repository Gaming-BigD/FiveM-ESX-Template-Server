-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 22. Okt 2023 um 12:23
-- Server-Version: 10.11.4-MariaDB-1~deb12u1
-- PHP-Version: 8.2.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `ESXLegacy_FAF92E`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `addon_account`
--

CREATE TABLE `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `addon_account`
--

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_cardealer', 'AutoHändler', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `addon_account_data`
--

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `addon_account_data`
--

INSERT INTO `addon_account_data` (`id`, `account_name`, `money`, `owner`) VALUES
(15, 'society_cardealer', 0, NULL);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `addon_inventory`
--

CREATE TABLE `addon_inventory` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `addon_inventory`
--

INSERT INTO `addon_inventory` (`id`, `name`, `label`, `shared`) VALUES
(10, 'society_cardealer', 'AutoHändler', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `addon_inventory_items`
--

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL,
  `inventory_name` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `cardealer_vehicles`
--

CREATE TABLE `cardealer_vehicles` (
  `id` int(11) NOT NULL,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `companies`
--

CREATE TABLE `companies` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `investRate` float DEFAULT NULL,
  `rate` varchar(10) NOT NULL DEFAULT 'stale'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `datastore`
--

CREATE TABLE `datastore` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `shared` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `datastore`
--

INSERT INTO `datastore` (`id`, `name`, `label`, `shared`) VALUES
(17, 'property', 'Property', 0),
(18, 'society_mechanic', 'Mechanic', 1),
(19, 'society_police', 'Police', 1),
(20, 'society_taxi', 'Taxi', 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `datastore_data`
--

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `owner` varchar(255) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `dn_notify`
--

CREATE TABLE `dn_notify` (
  `identifier` varchar(65) DEFAULT NULL,
  `position` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `fine_types`
--

CREATE TABLE `fine_types` (
  `id` int(11) NOT NULL,
  `label` varchar(255) DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `invest`
--

CREATE TABLE `invest` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `amount` float NOT NULL,
  `rate` float NOT NULL,
  `job` varchar(50) NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created` datetime NOT NULL DEFAULT current_timestamp(),
  `sold` datetime DEFAULT NULL,
  `soldAmount` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `items`
--

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT 1,
  `rare` tinyint(4) NOT NULL DEFAULT 0,
  `can_remove` tinyint(4) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `items`
--

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('bandage', 'Bandage', 1, 0, 1),
('icetea', 'Ice Tea', 1, 0, 1),
('jewels', 'Jewels', 1, 0, 1),
('medikit', 'Medikit', 1, 0, 1),
('metal', 'Metall', 1, 0, 1),
('phone', 'red_phone', 1, 0, 1),
('rope', 'Seil', 1, 0, 1),
('sandwich', 'Sandwich', 1, 0, 1),
('shovel', 'Schaufel', 1, 0, 1),
('wood', 'Holz', 1, 0, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `jobs`
--

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `jobs`
--

INSERT INTO `jobs` (`name`, `label`) VALUES
('cardealer', 'AutoHändler'),
('unemployed', 'Unemployed');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `job_grades`
--

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `job_grades`
--

INSERT INTO `job_grades` (`id`, `job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
(5, 'unemployed', 0, 'Unemployed', 'Unemployed', 100, '{}', '{}'),
(6, 'cardealer', 0, 'recruit', 'Pratikant', 10, '{}', '{}'),
(7, 'cardealer', 1, 'novice', 'Mitarbeiter', 25, '{}', '{}'),
(8, 'cardealer', 2, 'experienced', 'Co Chef', 40, '{}', '{}'),
(9, 'cardealer', 3, 'boss', 'Chef', 0, '{}', '{}');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `licenses`
--

CREATE TABLE `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `licenses`
--

INSERT INTO `licenses` (`type`, `label`) VALUES
('dmv', 'dmv'),
('drive', 'Drive'),
('drive_bike', 'Bike'),
('drive_truck', 'Truck'),
('weapon', 'Weapon licence');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `multichars_slots`
--

CREATE TABLE `multichars_slots` (
  `identifier` varchar(60) NOT NULL,
  `slots` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `owned_vehicles`
--

CREATE TABLE `owned_vehicles` (
  `owner` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext DEFAULT NULL,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `pickle_prisons`
--

CREATE TABLE `pickle_prisons` (
  `identifier` varchar(60) NOT NULL,
  `prison` varchar(50) DEFAULT 'default',
  `time` int(11) NOT NULL DEFAULT 0,
  `inventory` longtext NOT NULL,
  `sentence_date` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `rented_vehicles`
--

CREATE TABLE `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `ricky_admin`
--

CREATE TABLE `ricky_admin` (
  `identifier` varchar(46) NOT NULL,
  `warn` longtext DEFAULT NULL,
  `kick` longtext DEFAULT NULL,
  `ban` longtext DEFAULT NULL,
  `jail` longtext DEFAULT NULL,
  `inJail` int(11) DEFAULT 0,
  `jailCoords` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `ricky_admin`
--

INSERT INTO `ricky_admin` (`identifier`, `warn`, `kick`, `ban`, `jail`, `inJail`, `jailCoords`) VALUES
('308c2bc0e3ced73155f2a3cd75ce11136d1d3875', '[{\"date\":\"06/09/2023 13:21:30\",\"reason\":\"test\",\"name\":\"Gaming-BigD\",\"staff\":{\"name\":\"Gaming-BigD\",\"identifier\":\"308c2bc0e3ced73155f2a3cd75ce11136d1d3875\"}}]', NULL, NULL, '[{\"reason\":\"wegen dummheit\",\"date\":\"04/09/2023 14:08:20\",\"name\":\"Gaming-BigD\",\"staff\":{\"name\":\"Gaming-BigD\",\"identifier\":\"308c2bc0e3ced73155f2a3cd75ce11136d1d3875\"}}]', 0, '{\"x\":-240.1846160888672,\"y\":-984.949462890625,\"z\":29.2799072265625}');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `society_moneywash`
--

CREATE TABLE `society_moneywash` (
  `id` int(11) NOT NULL,
  `identifier` varchar(60) NOT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
  `identifier` varchar(60) NOT NULL,
  `accounts` longtext DEFAULT NULL,
  `group` varchar(50) DEFAULT 'user',
  `inventory` longtext DEFAULT NULL,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT 0,
  `loadout` longtext DEFAULT NULL,
  `metadata` longtext DEFAULT NULL,
  `position` longtext DEFAULT NULL,
  `status` longtext DEFAULT NULL,
  `skin` longtext DEFAULT NULL,
  `firstname` varchar(16) DEFAULT NULL,
  `lastname` varchar(16) DEFAULT NULL,
  `dateofbirth` varchar(10) DEFAULT NULL,
  `nationality` varchar(10) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `disabled` tinyint(1) DEFAULT 0,
  `tattoos` longtext DEFAULT NULL,
  `phone_number` varchar(20) DEFAULT NULL,
  `iban` varchar(255) DEFAULT NULL,
  `pincode` int(50) DEFAULT NULL,
  `is_dead` tinyint(1) DEFAULT 0,
  `playTime` int(255) DEFAULT 0,
  `neu` varchar(1) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Daten für Tabelle `users`
--

INSERT INTO `users` (`identifier`, `accounts`, `group`, `inventory`, `job`, `job_grade`, `loadout`, `metadata`, `position`, `status`, `skin`, `firstname`, `lastname`, `dateofbirth`, `nationality`, `sex`, `height`, `disabled`, `tattoos`, `phone_number`, `iban`, `pincode`, `is_dead`, `playTime`, `neu`) VALUES
('char1:308c2bc0e3ced73155f2a3cd75ce11136d1d3875', '{\"bank\":1523372,\"black_money\":0,\"money\":1000}', 'admin', '{\"sandwich\":10,\"phone\":1}', 'cardealer', 3, '[]', '[]', '{\"x\":441.5208740234375,\"y\":-1002.6461791992188,\"z\":30.7120361328125}', '[{\"val\":0,\"name\":\"drunk\",\"percent\":0.0},{\"val\":866400,\"name\":\"hunger\",\"percent\":86.64},{\"val\":899800,\"name\":\"thirst\",\"percent\":89.98}]', '{\"sun_1\":0,\"glasses_2\":0,\"bproof_1\":0,\"hair_color_1\":0,\"cheeks_1\":0,\"makeup_3\":0,\"arms_2\":0,\"chest_3\":0,\"blush_2\":0,\"nose_4\":0,\"makeup_2\":0,\"makeup_4\":0,\"chain_1\":0,\"age_1\":0,\"lipstick_1\":0,\"makeup_1\":0,\"lipstick_4\":0,\"nose_2\":0,\"beard_3\":0,\"eyebrows_3\":0,\"mom\":25,\"hair_color_2\":0,\"eyebrows_4\":0,\"watches_1\":-1,\"skin_md_weight\":50,\"sex\":0,\"face_md_weight\":50,\"nose_3\":0,\"bodyb_1\":-1,\"eye_squint\":0,\"nose_1\":0,\"glasses_1\":2,\"jaw_2\":0,\"eye_color\":0,\"blemishes_2\":0,\"blush_1\":0,\"nose_6\":0,\"beard_2\":\"10\",\"bracelets_1\":-1,\"bodyb_2\":0,\"eyebrows_2\":0,\"moles_2\":0,\"neck_thickness\":0,\"moles_1\":0,\"ears_2\":0,\"chain_2\":0,\"chin_4\":0,\"watches_2\":0,\"eyebrows_1\":0,\"torso_2\":0,\"torso_1\":134,\"jaw_1\":0,\"dad\":4,\"hair_1\":38,\"decals_2\":0,\"arms\":4,\"shoes_1\":2,\"hair_2\":0,\"bracelets_2\":0,\"eyebrows_5\":0,\"lip_thickness\":0,\"bodyb_4\":0,\"bodyb_3\":-1,\"chin_1\":0,\"bproof_2\":0,\"complexion_2\":0,\"pants_1\":4,\"chin_3\":0,\"lipstick_2\":0,\"nose_5\":0,\"bags_1\":0,\"mask_1\":0,\"complexion_1\":0,\"sun_2\":0,\"bags_2\":0,\"pants_2\":0,\"helmet_2\":0,\"helmet_1\":-1,\"beard_4\":0,\"decals_1\":0,\"chin_2\":0,\"cheeks_3\":0,\"tshirt_1\":15,\"beard_1\":11,\"age_2\":0,\"chest_2\":0,\"blush_3\":0,\"cheeks_2\":0,\"ears_1\":-1,\"tshirt_2\":0,\"shoes_2\":1,\"mask_2\":0,\"blemishes_1\":0,\"lipstick_3\":0,\"chest_1\":0,\"eyebrows_6\":0}', 'Jason', 'Jaeger', '02/06/1988', NULL, 'm', 175, 0, '[{\"collection\":\"mpbiker_overlays\",\"texture\":5},{\"collection\":\"mpbiker_overlays\",\"texture\":13},{\"collection\":\"mpbiker_overlays\",\"texture\":15}]', '9647949', 'OK974059', 1988, 0, 6197, '0');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `user_licenses`
--

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vehicles`
--

CREATE TABLE `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vehicle_categories`
--

CREATE TABLE `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Daten für Tabelle `vehicle_categories`
--

INSERT INTO `vehicle_categories` (`name`, `label`) VALUES
('compacts', 'Compacts'),
('coupes', 'Coupés'),
('motorcycles', 'Motos'),
('muscle', 'Muscle'),
('offroad', 'Off Road'),
('sedans', 'Sedans'),
('sports', 'Sports'),
('sportsclassics', 'Sports Classics'),
('super', 'Super'),
('suvs', 'SUVs'),
('vans', 'Vans');

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `vehicle_sold`
--

CREATE TABLE `vehicle_sold` (
  `client` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `soldby` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `addon_account`
--
ALTER TABLE `addon_account`
  ADD PRIMARY KEY (`name`);

--
-- Indizes für die Tabelle `addon_account_data`
--
ALTER TABLE `addon_account_data`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  ADD KEY `index_addon_account_data_account_name` (`account_name`);

--
-- Indizes für die Tabelle `addon_inventory`
--
ALTER TABLE `addon_inventory`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `companies`
--
ALTER TABLE `companies`
  ADD PRIMARY KEY (`name`);

--
-- Indizes für die Tabelle `datastore`
--
ALTER TABLE `datastore`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `datastore_data`
--
ALTER TABLE `datastore_data`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `dn_notify`
--
ALTER TABLE `dn_notify`
  ADD UNIQUE KEY `identifier` (`identifier`) USING HASH;

--
-- Indizes für die Tabelle `fine_types`
--
ALTER TABLE `fine_types`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `invest`
--
ALTER TABLE `invest`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `items`
--
ALTER TABLE `items`
  ADD PRIMARY KEY (`name`);

--
-- Indizes für die Tabelle `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`name`);

--
-- Indizes für die Tabelle `job_grades`
--
ALTER TABLE `job_grades`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `licenses`
--
ALTER TABLE `licenses`
  ADD PRIMARY KEY (`type`);

--
-- Indizes für die Tabelle `multichars_slots`
--
ALTER TABLE `multichars_slots`
  ADD PRIMARY KEY (`identifier`) USING BTREE,
  ADD KEY `slots` (`slots`) USING BTREE;

--
-- Indizes für die Tabelle `owned_vehicles`
--
ALTER TABLE `owned_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Indizes für die Tabelle `rented_vehicles`
--
ALTER TABLE `rented_vehicles`
  ADD PRIMARY KEY (`plate`);

--
-- Indizes für die Tabelle `ricky_admin`
--
ALTER TABLE `ricky_admin`
  ADD PRIMARY KEY (`identifier`);

--
-- Indizes für die Tabelle `society_moneywash`
--
ALTER TABLE `society_moneywash`
  ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`identifier`);

--
-- Indizes für die Tabelle `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`model`);

--
-- Indizes für die Tabelle `vehicle_categories`
--
ALTER TABLE `vehicle_categories`
  ADD PRIMARY KEY (`name`);

--
-- Indizes für die Tabelle `vehicle_sold`
--
ALTER TABLE `vehicle_sold`
  ADD PRIMARY KEY (`plate`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `addon_account_data`
--
ALTER TABLE `addon_account_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT für Tabelle `addon_inventory`
--
ALTER TABLE `addon_inventory`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT für Tabelle `addon_inventory_items`
--
ALTER TABLE `addon_inventory_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `cardealer_vehicles`
--
ALTER TABLE `cardealer_vehicles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `datastore`
--
ALTER TABLE `datastore`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT für Tabelle `datastore_data`
--
ALTER TABLE `datastore_data`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `fine_types`
--
ALTER TABLE `fine_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=63;

--
-- AUTO_INCREMENT für Tabelle `invest`
--
ALTER TABLE `invest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT für Tabelle `job_grades`
--
ALTER TABLE `job_grades`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT für Tabelle `society_moneywash`
--
ALTER TABLE `society_moneywash`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
