# คู่มือการติดตั้ง FiveM Thai Roleplay Server

## ขั้นตอนการติดตั้งแบบละเอียด

### ข้อกำหนดเบื้องต้น

1. **Server/VPS**
   - CPU: 2+ cores
   - RAM: 4GB+ (แนะนำ 8GB)
   - Storage: 20GB+
   - OS: Ubuntu 20.04/22.04 หรือ Windows Server

2. **Software ที่ต้องการ**
   - MySQL/MariaDB
   - Git
   - FiveM Server License Key ([สมัครที่นี่](https://keymaster.fivem.net))

---

## การติดตั้งบน Linux (Ubuntu)

### 1. อัพเดทระบบ
```bash
sudo apt update && sudo apt upgrade -y
```

### 2. ติดตั้ง Dependencies
```bash
# ติดตั้ง tools พื้นฐาน
sudo apt install -y git wget curl screen

# ติดตั้ง xz-utils สำหรับแตกไฟล์
sudo apt install -y xz-utils
```

### 3. ติดตั้ง MariaDB
```bash
# ติดตั้ง MariaDB
sudo apt install -y mariadb-server mariadb-client

# เริ่ม MariaDB
sudo systemctl start mariadb
sudo systemctl enable mariadb

# ตั้งค่าความปลอดภัย
sudo mysql_secure_installation
```

คำถามที่จะถูกถาม:
- Enter current password: กด Enter (ถ้ายังไม่มี password)
- Set root password: Y
- Remove anonymous users: Y
- Disallow root login remotely: Y
- Remove test database: Y
- Reload privilege tables: Y

### 4. สร้าง Database และ User
```bash
# เข้า MySQL
sudo mysql -u root -p

# สร้าง database
CREATE DATABASE fivem_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

# สร้าง user และให้สิทธิ์
CREATE USER 'fivem'@'localhost' IDENTIFIED BY 'strong_password_here';
GRANT ALL PRIVILEGES ON fivem_db.* TO 'fivem'@'localhost';
FLUSH PRIVILEGES;
EXIT;
```

### 5. ดาวน์โหลด FiveM Server
```bash
# สร้าง directory สำหรับ FiveM
mkdir -p ~/fivem/server
cd ~/fivem/server

# ดาวน์โหลด FiveM Server (Linux)
wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/7290-d4f3c6fc32a8da0311f5efe00e7f23da7900c35c/fx.tar.xz

# แตกไฟล์
tar xf fx.tar.xz
rm fx.tar.xz
```

### 6. Clone โปรเจค
```bash
cd ~/fivem
git clone https://github.com/oven-ttta/server-fivem.git
cd server-fivem
```

### 7. Import Database
```bash
mysql -u fivem -p fivem_db < sql/database.sql
```

### 8. ดาวน์โหลด Dependencies
```bash
cd ~/fivem/server-fivem/resources

# ดาวน์โหลด mysql-async
git clone https://github.com/brouznouf/fivem-mysql-async.git mysql-async

# หรือดาวน์โหลด oxmysql (ทางเลือกใหม่)
# git clone https://github.com/overextended/oxmysql.git
```

### 9. แก้ไข server.cfg
```bash
cd ~/fivem/server-fivem
nano server.cfg
```

แก้ไขข้อมูลต่อไปนี้:
- `sv_licenseKey` - ใส่ License Key ของคุณ
- `mysql_connection_string` - แก้ password
- `sv_hostname` - ชื่อเซิร์ฟเวอร์

### 10. สร้างสคริปต์เริ่มเซิร์ฟเวอร์
```bash
cd ~/fivem
nano start.sh
```

ใส่เนื้อหา:
```bash
#!/bin/bash
cd ~/fivem/server
./run.sh +exec ~/fivem/server-fivem/server.cfg
```

ให้สิทธิ์:
```bash
chmod +x start.sh
```

### 11. เปิด Firewall
```bash
sudo ufw allow 30120/tcp
sudo ufw allow 30120/udp
sudo ufw allow 40120/tcp
```

### 12. เริ่มเซิร์ฟเวอร์
```bash
cd ~/fivem
screen -S fivem
./start.sh
```

ออกจาก screen: กด `Ctrl+A` แล้ว `D`
กลับเข้า screen: `screen -r fivem`

---

## การติดตั้งบน Windows

### 1. ดาวน์โหลด Software ที่จำเป็น

1. **Git**: [https://git-scm.com/download/win](https://git-scm.com/download/win)
2. **MariaDB**: [https://mariadb.org/download/](https://mariadb.org/download/)
3. **Visual C++ Redistributable**: [ดาวน์โหลด](https://aka.ms/vs/17/release/vc_redist.x64.exe)

### 2. ติดตั้ง MariaDB
- ติดตั้งและตั้ง root password
- เปิด HeidiSQL หรือ MySQL Workbench
- สร้าง database `fivem_db`
- Import ไฟล์ `sql/database.sql`

### 3. ดาวน์โหลด FiveM Server
```powershell
# สร้าง folder
mkdir C:\FiveM
cd C:\FiveM

# ดาวน์โหลด server (Windows)
# ไปที่ https://runtime.fivem.net/artifacts/fivem/build_server_windows/master/
# ดาวน์โหลดเวอร์ชันล่าสุด
```

### 4. Clone โปรเจค
```powershell
cd C:\FiveM
git clone https://github.com/oven-ttta/server-fivem.git
```

### 5. แก้ไข server.cfg
- เปิดไฟล์ `C:\FiveM\server-fivem\server.cfg`
- แก้ไข License Key และ Database Connection

### 6. สร้างไฟล์ start.bat
```batch
@echo off
cd C:\FiveM\server
FXServer.exe +exec C:\FiveM\server-fivem\server.cfg
pause
```

### 7. เริ่มเซิร์ฟเวอร์
- Double-click `start.bat`

---

## ดาวน์โหลด Resources เพิ่มเติม

### ESX Resources ที่จำเป็น
```bash
cd ~/fivem/server-fivem/resources/[core]

# ESX Menu
git clone https://github.com/esx-framework/esx_menu_default.git
git clone https://github.com/esx-framework/esx_menu_list.git
git clone https://github.com/esx-framework/esx_menu_dialog.git

# Skin/Character
git clone https://github.com/esx-framework/skinchanger.git
git clone https://github.com/esx-framework/esx_skin.git
```

### Jobs Resources
```bash
cd ~/fivem/server-fivem/resources/[jobs]

# ดาวน์โหลดงานเพิ่มเติม
git clone https://github.com/esx-framework/esx_ambulancejob.git
git clone https://github.com/esx-framework/esx_mechanicjob.git
# ... และอื่นๆ
```

---

## ทดสอบเซิร์ฟเวอร์

1. เปิด FiveM Client
2. กด F8 เพื่อเปิด Console
3. พิมพ์: `connect localhost:30120` (ถ้ารันบนเครื่องเดียวกัน)
4. หรือ: `connect ip_address:30120`

---

## ตั้งค่าแอดมิน

### วิธีที่ 1: ผ่าน server.cfg
```bash
# เพิ่มในไฟล์ server.cfg
add_principal identifier.license:xxxxxxxxxxxxxxx group.admin
```

### วิธีที่ 2: ผ่าน Database
```sql
UPDATE users SET `group` = 'admin' WHERE identifier = 'license:xxxxxxxxxxxxxxx';
```

หา identifier:
1. เข้าเกม
2. ดูใน server console จะมี identifier แสดง
3. หรือดูใน database ตาราง `users`

---

## การแก้ไขปัญหา

### ปัญหา: MySQL Connection Failed
```bash
# ตรวจสอบ MySQL running
sudo systemctl status mariadb

# ตรวจสอบ user และ password
mysql -u fivem -p

# ตรวจสอบ connection string ใน server.cfg
```

### ปัญหา: Resources ไม่โหลด
- ตรวจสอบ fxmanifest.lua
- ตรวจสอบ ensure ใน server.cfg
- ดู error ใน server console

### ปัญหา: Port ถูกใช้งานแล้ว
```bash
# ตรวจสอบ port 30120
sudo netstat -tlnp | grep 30120

# หรือเปลี่ยน port ใน server.cfg
endpoint_add_tcp "0.0.0.0:30121"
endpoint_add_udp "0.0.0.0:30121"
```

---

## Performance Tuning

### MySQL Optimization
แก้ไขไฟล์ `/etc/mysql/mariadb.conf.d/50-server.cnf`:
```ini
[mysqld]
max_connections = 151
innodb_buffer_pool_size = 2G
innodb_log_file_size = 512M
query_cache_size = 64M
```

Restart MySQL:
```bash
sudo systemctl restart mariadb
```

### FiveM Server
แก้ไข server.cfg:
```bash
# เพิ่ม performance
set onesync_distanceCullVehicles true
set onesync_enableInfinity true
set onesync_population true
```

---

## การสำรองข้อมูล

### สำรอง Database
```bash
# สร้าง backup script
nano ~/backup.sh
```

```bash
#!/bin/bash
BACKUP_DIR="/home/username/backups"
DATE=$(date +%Y%m%d_%H%M%S)
mysqldump -u fivem -p'password' fivem_db > $BACKUP_DIR/fivem_db_$DATE.sql
gzip $BACKUP_DIR/fivem_db_$DATE.sql
# ลบ backup เก่าที่เกิน 7 วัน
find $BACKUP_DIR -name "*.sql.gz" -mtime +7 -delete
```

ตั้ง Cron Job:
```bash
crontab -e
# เพิ่มบรรทัด (สำรองทุกวัน เวลา 3 โมงเช้า)
0 3 * * * /home/username/backup.sh
```

---

## Auto-Restart on Crash

สร้างไฟล์ `monitor.sh`:
```bash
#!/bin/bash
while true; do
    cd ~/fivem
    ./start.sh
    echo "Server crashed at $(date). Restarting in 5 seconds..."
    sleep 5
done
```

---

## การอัพเดท

```bash
cd ~/fivem/server-fivem
git pull origin main
# Restart server
screen -r fivem
# Ctrl+C แล้ว ./start.sh ใหม่
```

---

## ต้องการความช่วยเหลือ?

- GitHub Issues: https://github.com/oven-ttta/server-fivem/issues
- FiveM Forum: https://forum.cfx.re
- FiveM Discord: https://discord.gg/fivem
