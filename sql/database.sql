-- FiveM Thai Roleplay Server Database
-- Created by Claude Code

-- สร้างฐานข้อมูล
CREATE DATABASE IF NOT EXISTS `fivem_db` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `fivem_db`;

-- ตาราง Users (ผู้เล่น)
CREATE TABLE IF NOT EXISTS `users` (
    `identifier` VARCHAR(60) NOT NULL,
    `accounts` LONGTEXT NULL DEFAULT NULL,
    `group` VARCHAR(50) NULL DEFAULT 'user',
    `inventory` LONGTEXT NULL DEFAULT NULL,
    `job` VARCHAR(50) NULL DEFAULT 'unemployed',
    `job_grade` INT(11) NULL DEFAULT 0,
    `loadout` LONGTEXT NULL DEFAULT NULL,
    `position` VARCHAR(255) NULL DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
    `firstname` VARCHAR(50) NULL DEFAULT NULL,
    `lastname` VARCHAR(50) NULL DEFAULT NULL,
    `dateofbirth` VARCHAR(25) NULL DEFAULT NULL,
    `sex` VARCHAR(10) NULL DEFAULT NULL,
    `height` INT(11) NULL DEFAULT NULL,
    `skin` LONGTEXT NULL DEFAULT NULL,
    `status` LONGTEXT NULL DEFAULT NULL,
    `is_dead` TINYINT(1) NULL DEFAULT 0,
    `last_property` VARCHAR(255) NULL DEFAULT NULL,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `last_seen` TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง Jobs (งาน)
CREATE TABLE IF NOT EXISTS `jobs` (
    `name` VARCHAR(50) NOT NULL,
    `label` VARCHAR(255) NULL DEFAULT NULL,
    `whitelisted` TINYINT(1) NOT NULL DEFAULT 0,
    PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES
('unemployed', 'ว่างงาน', 0),
('police', 'ตำรวจ', 1),
('ambulance', 'หมอ/EMS', 1),
('mechanic', 'ช่างซ่อมรถ', 1),
('taxi', 'แท็กซี่', 0),
('lumberjack', 'คนตัดไม้', 0),
('miner', 'คนขุดแร่', 0),
('trucker', 'คนขับรถบรรทุก', 0),
('fisherman', 'ชาวประมง', 0);

-- ตาราง Job Grades
CREATE TABLE IF NOT EXISTS `job_grades` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `job_name` VARCHAR(50) NULL DEFAULT NULL,
    `grade` INT(11) NOT NULL,
    `name` VARCHAR(50) NOT NULL,
    `label` VARCHAR(255) NOT NULL,
    `salary` INT(11) NOT NULL,
    `skin_male` LONGTEXT NOT NULL,
    `skin_female` LONGTEXT NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES
('unemployed', 0, 'unemployed', 'ว่างงาน', 200, '{}', '{}'),
('police', 0, 'recruit', 'สมัครใหม่', 2500, '{}', '{}'),
('police', 1, 'officer', 'เจ้าหน้าที่', 3500, '{}', '{}'),
('police', 2, 'sergeant', 'จ่า', 4500, '{}', '{}'),
('police', 3, 'lieutenant', 'ร้อย', 5500, '{}', '{}'),
('police', 4, 'boss', 'ผู้บัญชาการ', 7000, '{}', '{}'),
('ambulance', 0, 'ambulance', 'เจ้าหน้าที่ EMS', 2500, '{}', '{}'),
('ambulance', 1, 'doctor', 'หมอ', 3500, '{}', '{}'),
('ambulance', 2, 'chief_doctor', 'หมอหัวหน้า', 4500, '{}', '{}'),
('ambulance', 3, 'boss', 'ผู้อำนวยการ', 6000, '{}', '{}'),
('mechanic', 0, 'recrue', 'ช่างฝึกหัด', 1500, '{}', '{}'),
('mechanic', 1, 'novice', 'ช่างทั่วไป', 2000, '{}', '{}'),
('mechanic', 2, 'experienced', 'ช่างชำนาญ', 2500, '{}', '{}'),
('mechanic', 3, 'chief', 'หัวหน้าช่าง', 3000, '{}', '{}'),
('mechanic', 4, 'boss', 'เจ้าของร้าน', 3500, '{}', '{}'),
('taxi', 0, 'recrue', 'คนขับใหม่', 1200, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":111,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
('taxi', 1, 'novice', 'คนขับทั่วไป', 1600, '{"hair_2":0,"hair_color_2":0,"torso_1":32,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":111,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":0,"age_2":0,"glasses_2":0,"ears_2":0,"arms":27,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
('taxi', 2, 'experienced', 'คนขับชำนาญ', 2000, '{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}'),
('taxi', 3, 'boss', 'เจ้าของบริษัท', 2500, '{"hair_2":0,"hair_color_2":0,"torso_1":26,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":57,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":4,"age_2":0,"glasses_2":0,"ears_2":0,"arms":11,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":0,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":0,"bproof_1":0,"mask_1":0,"decals_1":0,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":10,"pants_1":24}', '{"hair_2":0,"hair_color_2":0,"torso_1":57,"bags_1":0,"helmet_2":0,"chain_2":0,"eyebrows_3":0,"makeup_3":0,"makeup_2":0,"tshirt_1":38,"makeup_1":0,"bags_2":0,"makeup_4":0,"eyebrows_4":0,"chain_1":0,"lipstick_4":0,"bproof_2":0,"hair_color_1":0,"decals_2":0,"pants_2":1,"age_2":0,"glasses_2":0,"ears_2":0,"arms":21,"lipstick_1":0,"ears_1":-1,"mask_2":0,"sex":1,"lipstick_3":0,"helmet_1":-1,"shoes_2":0,"beard_2":0,"beard_1":0,"lipstick_2":0,"beard_4":0,"glasses_1":5,"bproof_1":0,"mask_1":0,"decals_1":1,"hair_1":0,"eyebrows_2":0,"beard_3":0,"age_1":0,"tshirt_2":0,"skin":0,"torso_2":0,"eyebrows_1":0,"face":0,"shoes_1":49,"pants_1":11}');

-- ตาราง Items
CREATE TABLE IF NOT EXISTS `items` (
    `name` VARCHAR(50) NOT NULL,
    `label` VARCHAR(255) NOT NULL,
    `weight` INT(11) NOT NULL DEFAULT 1,
    `rare` TINYINT(1) NOT NULL DEFAULT 0,
    `can_remove` TINYINT(1) NOT NULL DEFAULT 1,
    PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `items` (`name`, `label`, `weight`, `rare`, `can_remove`) VALUES
('bread', 'ขนมปัง', 1, 0, 1),
('water', 'น้ำดื่ม', 1, 0, 1),
('phone', 'โทรศัพท์', 1, 0, 0),
('money', 'เงินสด', 0, 0, 0),
('black_money', 'เงินสกปรก', 0, 0, 1),
('bandage', 'ผ้าพันแผล', 2, 0, 1),
('medikit', 'ชุดปฐมพยาบาล', 3, 0, 1),
('lockpick', 'ไขควง', 1, 0, 1),
('weapon_pistol', 'ปืนพก', 5, 0, 1),
('ammo-9', 'กระสุน 9mm', 1, 0, 1),
('ammo-rifle', 'กระสุนไรเฟิล', 1, 0, 1),
('marijuana', 'กัญชา', 2, 0, 1),
('cocaine', 'โคเคน', 2, 0, 1),
('meth', 'ยาบ้า', 2, 0, 1),
('wood', 'ไม้', 5, 0, 1),
('stone', 'หิน', 5, 0, 1),
('iron', 'เหล็ก', 5, 0, 1),
('gold', 'ทองคำ', 5, 0, 1),
('diamond', 'เพชร', 5, 0, 1),
('fishbait', 'เหยื่อตกปลา', 1, 0, 1),
('fish', 'ปลา', 2, 0, 1),
('burger', 'เบอร์เกอร์', 2, 0, 1),
('cola', 'โค้ก', 1, 0, 1);

-- ตาราง Vehicles (รถของผู้เล่น)
CREATE TABLE IF NOT EXISTS `owned_vehicles` (
    `owner` VARCHAR(60) NOT NULL,
    `plate` VARCHAR(12) NOT NULL,
    `vehicle` LONGTEXT NULL DEFAULT NULL,
    `type` VARCHAR(20) NOT NULL DEFAULT 'car',
    `job` VARCHAR(20) NULL DEFAULT NULL,
    `stored` TINYINT(1) NOT NULL DEFAULT 0,
    `parking` VARCHAR(60) NULL DEFAULT NULL,
    `pound` VARCHAR(60) NULL DEFAULT NULL,
    PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง Billing (ใบแจ้งหนี้)
CREATE TABLE IF NOT EXISTS `billing` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(60) NOT NULL,
    `sender` VARCHAR(255) NOT NULL,
    `target_type` VARCHAR(50) NOT NULL,
    `target` VARCHAR(255) NOT NULL,
    `label` VARCHAR(255) NOT NULL,
    `amount` INT(11) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง Properties (บ้าน)
CREATE TABLE IF NOT EXISTS `properties` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NULL DEFAULT NULL,
    `label` VARCHAR(255) NULL DEFAULT NULL,
    `entering` VARCHAR(255) NULL DEFAULT NULL,
    `exit` VARCHAR(255) NULL DEFAULT NULL,
    `inside` VARCHAR(255) NULL DEFAULT NULL,
    `outside` VARCHAR(255) NULL DEFAULT NULL,
    `ipls` VARCHAR(255) NULL DEFAULT '[]',
    `gateway` VARCHAR(255) NULL DEFAULT NULL,
    `is_single` TINYINT(1) NULL DEFAULT 0,
    `is_room` TINYINT(1) NULL DEFAULT 0,
    `is_gateway` TINYINT(1) NULL DEFAULT 0,
    `room_menu` VARCHAR(255) NULL DEFAULT NULL,
    `price` INT(11) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง User Properties
CREATE TABLE IF NOT EXISTS `user_properties` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `property_id` INT(11) NULL DEFAULT NULL,
    `identifier` VARCHAR(60) NULL DEFAULT NULL,
    `rented` INT(11) NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง Gangs (แก๊ง)
CREATE TABLE IF NOT EXISTS `gangs` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(255) NOT NULL,
    `label` VARCHAR(255) NOT NULL,
    `owner` VARCHAR(60) NOT NULL,
    `money` INT(11) NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง Gang Members
CREATE TABLE IF NOT EXISTS `gang_members` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `gang_id` INT(11) NOT NULL,
    `identifier` VARCHAR(60) NOT NULL,
    `grade` INT(11) NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง Shops (ร้านค้า)
CREATE TABLE IF NOT EXISTS `shops` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `store` VARCHAR(100) NOT NULL,
    `item` VARCHAR(100) NOT NULL,
    `price` INT(11) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง Licenses (ใบอนุญาต)
CREATE TABLE IF NOT EXISTS `licenses` (
    `type` VARCHAR(60) NOT NULL,
    `label` VARCHAR(255) NOT NULL,
    PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `licenses` (`type`, `label`) VALUES
('dmv', 'ใบขับขี่'),
('drive', 'ใบขับขี่รถยนต์'),
('drive_bike', 'ใบขับขี่มอเตอร์ไซค์'),
('drive_truck', 'ใบขับขี่รถบรรทุก'),
('weapon', 'ใบอนุญาตอาวุธ');

-- ตาราง User Licenses
CREATE TABLE IF NOT EXISTS `user_licenses` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(60) NOT NULL,
    `owner` VARCHAR(60) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง Society (องค์กร/บริษัท)
CREATE TABLE IF NOT EXISTS `addon_account` (
    `name` VARCHAR(60) NOT NULL,
    `label` VARCHAR(255) NOT NULL,
    `shared` INT(11) NOT NULL,
    PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES
('society_police', 'ตำรวจ', 1),
('society_ambulance', 'โรงพยาบาล', 1),
('society_mechanic', 'ร้านซ่อมรถ', 1),
('society_taxi', 'บริษัทแท็กซี่', 1);

CREATE TABLE IF NOT EXISTS `addon_account_data` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `account_name` VARCHAR(60) NULL DEFAULT NULL,
    `money` INT(11) NOT NULL,
    `owner` VARCHAR(60) NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง Logs (บันทึกกิจกรรม)
CREATE TABLE IF NOT EXISTS `server_logs` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(50) NOT NULL,
    `message` TEXT NOT NULL,
    `player` VARCHAR(255) NULL DEFAULT NULL,
    `identifier` VARCHAR(60) NULL DEFAULT NULL,
    `coords` VARCHAR(255) NULL DEFAULT NULL,
    `created_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ตาราง Bans
CREATE TABLE IF NOT EXISTS `bans` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(60) NOT NULL,
    `reason` TEXT NOT NULL,
    `banned_by` VARCHAR(255) NOT NULL,
    `banned_at` TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
    `expire` BIGINT(20) NULL DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- สร้าง Indexes เพื่อเพิ่มประสิทธิภาพ
CREATE INDEX idx_identifier ON users(identifier);
CREATE INDEX idx_job ON users(job);
CREATE INDEX idx_owner ON owned_vehicles(owner);
CREATE INDEX idx_gang_id ON gang_members(gang_id);
CREATE INDEX idx_identifier_gang ON gang_members(identifier);

COMMIT;
