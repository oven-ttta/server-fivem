-- FiveM Database Setup Script
-- Run this with: sudo mysql < setup-database.sql

-- 1. สร้าง Database
CREATE DATABASE IF NOT EXISTS fivem_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- 2. สร้าง User สำหรับ FiveM
CREATE USER IF NOT EXISTS 'fivem'@'localhost' IDENTIFIED BY 'fivem2024';

-- 3. ให้สิทธิ์ทั้งหมดสำหรับ database fivem_db
GRANT ALL PRIVILEGES ON fivem_db.* TO 'fivem'@'localhost';

-- 4. Refresh privileges
FLUSH PRIVILEGES;

-- 5. ใช้ database
USE fivem_db;

-- 6. แสดงผลลัพธ์
SELECT 'Database "fivem_db" created successfully!' AS Status;
SELECT 'User "fivem" created with password "fivem2024"' AS Status;
SELECT 'Ready to import schema!' AS Status;
