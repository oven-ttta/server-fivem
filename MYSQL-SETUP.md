# คู่มือการติดตั้ง MySQL สำหรับ FiveM Server

## ปัญหา: Access denied for user 'root'@'localhost'

ปัญหานี้เกิดจาก MySQL/MariaDB ใช้ `auth_socket` plugin แทน password authentication

## วิธีแก้ไข (เลือก 1 วิธี)

### 🎯 วิธีที่ 1: ใช้ sudo mysql (แนะนำ - ง่ายที่สุด)

```bash
# 1. รัน setup script
cd ~/Documents/server\ fivem
sudo mysql < setup-database.sql

# 2. Import database schema
mysql -u fivem -pfivem2024 fivem_db < sql/database.sql

# 3. ตรวจสอบว่า import สำเร็จ
mysql -u fivem -pfivem2024 fivem_db -e "SHOW TABLES;"

# 4. นับจำนวน tables (ควรได้ 17 ตาราง)
mysql -u fivem -pfivem2024 fivem_db -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'fivem_db';"
```

### 🎯 วิธีที่ 2: รันทีละคำสั่ง

```bash
# 1. เข้า MySQL ด้วย sudo
sudo mysql

# 2. พิมพ์คำสั่งต่อไปนี้ใน MySQL (ทีละบรรทัด):
CREATE DATABASE fivem_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE USER 'fivem'@'localhost' IDENTIFIED BY 'fivem2024';
GRANT ALL PRIVILEGES ON fivem_db.* TO 'fivem'@'localhost';
FLUSH PRIVILEGES;
EXIT;

# 3. Import database schema
mysql -u fivem -pfivem2024 fivem_db < sql/database.sql

# 4. ตรวจสอบ
mysql -u fivem -pfivem2024 fivem_db -e "SHOW TABLES;"
```

### 🎯 วิธีที่ 3: เปลี่ยน root ให้ใช้ password (ถ้าต้องการ)

```bash
# เข้า MySQL
sudo mysql

# ใน MySQL:
ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'your_new_password';
FLUSH PRIVILEGES;
EXIT;

# ตอนนี้สามารถใช้ password ได้แล้ว
mysql -u root -p
```

---

## ข้อมูล Database ที่สร้าง

| Item | Value |
|------|-------|
| Database Name | `fivem_db` |
| Username | `fivem` |
| Password | `fivem2024` |
| Host | `localhost` |
| Charset | `utf8mb4` |
| Tables | 17 tables |

---

## Connection String สำหรับ server.cfg

เมื่อติดตั้งเสร็จแล้ว ให้แก้ไขไฟล์ `server.cfg`:

```bash
set mysql_connection_string "mysql://fivem:fivem2024@localhost/fivem_db?charset=utf8mb4"
```

---

## การตรวจสอบว่าติดตั้งสำเร็จ

### ตรวจสอบ Database
```bash
mysql -u fivem -pfivem2024 fivem_db -e "SHOW DATABASES;"
```

### ตรวจสอบ Tables (ต้องได้ 17 ตาราง)
```bash
mysql -u fivem -pfivem2024 fivem_db -e "SHOW TABLES;"
```

ผลลัพธ์ที่ควรได้:
```
addon_account
addon_account_data
bans
billing
gang_members
gangs
items
job_grades
jobs
licenses
owned_vehicles
properties
server_logs
shops
user_licenses
user_properties
users
```

### ตรวจสอบ Users ใน Database
```bash
mysql -u fivem -pfivem2024 fivem_db -e "SELECT COUNT(*) AS user_count FROM users;"
```

### ตรวจสอบ Jobs
```bash
mysql -u fivem -pfivem2024 fivem_db -e "SELECT name, label FROM jobs;"
```

ผลลัพธ์ที่ควรได้:
```
unemployed - ว่างงาน
police - ตำรวจ
ambulance - หมอ/EMS
mechanic - ช่างซ่อมรถ
taxi - แท็กซี่
lumberjack - คนตัดไม้
miner - คนขุดแร่
trucker - คนขับรถบรรทุก
fisherman - ชาวประมง
```

---

## การแก้ปัญหาที่พบบ่อย

### ปัญหา: ERROR 1698 (28000): Access denied
**วิธีแก้:** ใช้ `sudo mysql` แทน `mysql -u root -p`

### ปัญหา: ERROR 2002: Can't connect to MySQL server
**วิธีแก้:** MySQL ไม่ได้เปิด
```bash
sudo systemctl start mysql
# หรือ
sudo systemctl start mariadb
```

### ปัญหา: ERROR 1045 (28000): Access denied for user 'fivem'
**วิธีแก้:** User ยังไม่ถูกสร้าง หรือ password ผิด
```bash
# ลองสร้างใหม่
sudo mysql -e "DROP USER IF EXISTS 'fivem'@'localhost';"
sudo mysql < setup-database.sql
```

### ปัญหา: ERROR 1049: Unknown database 'fivem_db'
**วิธีแก้:** Database ยังไม่ถูกสร้าง
```bash
sudo mysql -e "CREATE DATABASE fivem_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
```

---

## ขั้นตอนถัดไป (หลังติดตั้ง MySQL เสร็จ)

1. ✅ ติดตั้ง MySQL และสร้าง Database
2. ⏭️ แก้ไข server.cfg (ใส่ connection string)
3. ⏭️ ดาวน์โหลด mysql-async resource
4. ⏭️ ดาวน์โหลด ESX resources เพิ่มเติม
5. ⏭️ ใส่ FiveM License Key
6. ⏭️ เริ่ม Server

---

## คำสั่งที่ใช้บ่อย

```bash
# เข้า MySQL
sudo mysql

# เข้า Database fivem_db
mysql -u fivem -pfivem2024 fivem_db

# Backup Database
mysqldump -u fivem -pfivem2024 fivem_db > backup.sql

# Restore Database
mysql -u fivem -pfivem2024 fivem_db < backup.sql

# ดู Logs
sudo tail -f /var/log/mysql/error.log

# Restart MySQL
sudo systemctl restart mysql
```

---

**หมายเหตุ:** Password `fivem2024` เป็นแค่ตัวอย่าง สำหรับ production ควรเปลี่ยนเป็น password ที่แข็งแรงกว่านี้
