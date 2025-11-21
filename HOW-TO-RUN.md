# 🚀 วิธีการรัน FiveM Thai Roleplay Server

## ขั้นตอนการรัน Server

### 📋 สิ่งที่ต้องเตรียม

1. ✅ FiveM Server License Key ([สมัครที่นี่](https://keymaster.fivem.net))
2. ✅ MySQL/MariaDB ติดตั้งและตั้งค่าแล้ว
3. ✅ Database import แล้ว
4. ⬜ FiveM Server artifacts (ตัว server)
5. ⬜ Dependencies resources

---

## 🔧 ขั้นตอนที่ 1: ดาวน์โหลด FiveM Server

### สำหรับ Linux:

```bash
cd ~/Documents/server\ fivem

# สร้างโฟลเดอร์สำหรับ FiveM Server
mkdir -p server-files
cd server-files

# ดาวน์โหลด FiveM Server (Linux)
# ไปที่: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/
# คัดลอก URL ของเวอร์ชันล่าสุด แล้วใช้คำสั่ง:

wget https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/[BUILD_NUMBER]/fx.tar.xz

# แตกไฟล์
tar xf fx.tar.xz

# ลบไฟล์ที่แตกแล้ว
rm fx.tar.xz
```

### หรือใช้คำสั่งนี้เพื่อดาวน์โหลดเวอร์ชันล่าสุดอัตโนมัติ:

```bash
cd ~/Documents/server\ fivem
mkdir -p server-files
cd server-files

# ดาวน์โหลด latest build
curl -O https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/latest.tar.xz
tar xf latest.tar.xz
rm latest.tar.xz
```

---

## 🔧 ขั้นตอนที่ 2: ดาวน์โหลด Dependencies

```bash
cd ~/Documents/server\ fivem/resources

# 1. mysql-async (จำเป็น!)
git clone https://github.com/brouznouf/fivem-mysql-async.git mysql-async

# 2. ESX Menu System (จำเป็น!)
cd "[core]"
git clone https://github.com/esx-framework/esx_menu_default.git
git clone https://github.com/esx-framework/esx_menu_list.git
git clone https://github.com/esx-framework/esx_menu_dialog.git

# 3. Skin/Character System (จำเป็น!)
git clone https://github.com/esx-framework/skinchanger.git
git clone https://github.com/esx-framework/esx_skin.git

# 4. Core ESX Scripts
cd ~/Documents/server\ fivem/resources/"[core]"

# ถ้าต้องการใช้ ESX official แทนที่เราสร้าง (ทางเลือก)
# git clone https://github.com/esx-framework/esx_core.git es_extended

# กลับไปยัง root
cd ~/Documents/server\ fivem
```

---

## 🔧 ขั้นตอนที่ 3: ตั้งค่า server.cfg

```bash
cd ~/Documents/server\ fivem
nano server.cfg
```

แก้ไขส่วนสำคัญ:

```cfg
# ใส่ License Key ของคุณ (สมัครที่ keymaster.fivem.net)
sv_licenseKey "cfxk_YOUR_LICENSE_KEY_HERE"

# ตั้งค่า MySQL (ถ้ารัน setup-database.sql แล้ว)
set mysql_connection_string "mysql://fivem:fivem2024@localhost/fivem_db?charset=utf8mb4"

# ตั้งชื่อ Server ของคุณ
sv_hostname "^1[TH]^7 ชื่อเซิร์ฟเวอร์ของคุณ"
```

บันทึกไฟล์: `Ctrl+O` แล้ว `Enter`, ออก: `Ctrl+X`

---

## 🔧 ขั้นตอนที่ 4: สร้าง Start Script

```bash
cd ~/Documents/server\ fivem
nano start-server.sh
```

วางโค้ดนี้:

```bash
#!/bin/bash

echo "=========================================="
echo "Starting FiveM Thai Roleplay Server"
echo "=========================================="
echo ""

# เช็คว่า server files มีหรือไม่
if [ ! -f "server-files/run.sh" ]; then
    echo "ERROR: FiveM server files not found!"
    echo "Please download server files first."
    echo ""
    echo "Run: ./download-server.sh"
    exit 1
fi

# เช็คว่า License Key ตั้งค่าแล้วหรือไม่
if grep -q "cfxk_xxxxx" server.cfg; then
    echo "ERROR: License Key not set!"
    echo "Please edit server.cfg and add your license key"
    exit 1
fi

# เริ่ม Server
cd server-files
bash run.sh +exec "../server.cfg"
```

ให้สิทธิ์:
```bash
chmod +x start-server.sh
```

---

## 🔧 ขั้นตอนที่ 5: สร้าง Download Script

```bash
cd ~/Documents/server\ fivem
nano download-server.sh
```

วางโค้ดนี้:

```bash
#!/bin/bash

echo "=========================================="
echo "Downloading FiveM Server"
echo "=========================================="
echo ""

# สร้างโฟลเดอร์
mkdir -p server-files
cd server-files

# ดาวน์โหลด
echo "Downloading FiveM Server (Linux)..."
echo "This may take a few minutes..."
echo ""

# ดาวน์โหลดจาก master branch (latest)
curl -L -o fx.tar.xz "https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/latest.tar.xz"

if [ $? -eq 0 ]; then
    echo ""
    echo "Extracting..."
    tar xf fx.tar.xz
    rm fx.tar.xz

    echo ""
    echo "✓ FiveM Server downloaded successfully!"
    echo ""
    echo "Next steps:"
    echo "  1. Get License Key from: https://keymaster.fivem.net"
    echo "  2. Edit server.cfg and add your license key"
    echo "  3. Run: ./start-server.sh"
else
    echo ""
    echo "✗ Download failed!"
    echo ""
    echo "Please download manually from:"
    echo "https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/"
    exit 1
fi
```

ให้สิทธิ์:
```bash
chmod +x download-server.sh
```

---

## 🚀 การรัน Server

### แบบง่าย (3 คำสั่ง):

```bash
cd ~/Documents/server\ fivem

# 1. ดาวน์โหลด Server (ครั้งแรกเท่านั้น)
./download-server.sh

# 2. ดาวน์โหลด Dependencies (ครั้งแรกเท่านั้น)
cd resources
git clone https://github.com/brouznouf/fivem-mysql-async.git mysql-async
cd ..

# 3. แก้ไข server.cfg (ใส่ License Key)
nano server.cfg

# 4. เริ่ม Server!
./start-server.sh
```

---

## 🎮 การเชื่อมต่อเข้า Server

### จาก FiveM Client:

1. เปิด FiveM
2. กด `F8` เพื่อเปิด Console
3. พิมพ์:
   ```
   connect localhost:30120
   ```
   หรือถ้าอยู่คนละเครื่อง:
   ```
   connect IP_ADDRESS:30120
   ```

### จาก Direct Connect:

1. เปิด FiveM
2. กด `F8`
3. พิมพ์: `connect localhost:30120`

---

## 🔍 การตรวจสอบ Server

### ตรวจสอบว่า Server กำลังรันอยู่:

```bash
# ดู process
ps aux | grep FXServer

# ดู port 30120
netstat -tulpn | grep 30120

# หรือ
ss -tulpn | grep 30120
```

### ดู Server Logs:

Server logs จะแสดงใน terminal ที่รัน `./start-server.sh`

---

## 🛑 การหยุด Server

กด `Ctrl+C` ใน terminal ที่รัน server

หรือถ้ารันใน background:
```bash
# หา PID
ps aux | grep FXServer

# Kill process
kill [PID]
```

---

## 🔧 การรันใน Background (ถ้าต้องการ)

### ใช้ screen:

```bash
# ติดตั้ง screen
sudo apt install screen

# เริ่ม screen session
screen -S fivem

# รัน server
./start-server.sh

# ออกจาก screen (server ยังรันอยู่)
Ctrl+A, D

# กลับเข้า screen
screen -r fivem

# ดู sessions ทั้งหมด
screen -ls
```

### ใช้ systemd service (สำหรับ production):

```bash
# สร้างไฟล์ service
sudo nano /etc/systemd/system/fivem.service
```

วางโค้ด:
```ini
[Unit]
Description=FiveM Thai RP Server
After=network.target mysql.service

[Service]
Type=simple
User=admin-oven
WorkingDirectory=/home/admin-oven/Documents/server fivem/server-files
ExecStart=/bin/bash /home/admin-oven/Documents/server fivem/server-files/run.sh +exec "../server.cfg"
Restart=on-failure
RestartSec=5

[Install]
WantedBy=multi-user.target
```

เริ่มใช้งาน:
```bash
sudo systemctl daemon-reload
sudo systemctl enable fivem
sudo systemctl start fivem

# ดู status
sudo systemctl status fivem

# ดู logs
sudo journalctl -u fivem -f
```

---

## ❓ แก้ปัญหาที่พบบ่อย

### 1. License Key Invalid
```
ERROR: License key is invalid
```
**วิธีแก้:** ตรวจสอบ License Key ที่ server.cfg และสมัครใหม่ที่ keymaster.fivem.net

### 2. MySQL Connection Failed
```
ERROR: Could not connect to MySQL
```
**วิธีแก้:**
- ตรวจสอบว่า MySQL running: `sudo systemctl status mysql`
- ตรวจสอบ connection string ใน server.cfg
- ทดสอบ connection: `mysql -u fivem -pfivem2024 fivem_db`

### 3. Port Already in Use
```
ERROR: Port 30120 is already in use
```
**วิธีแก้:**
```bash
# หา process ที่ใช้ port
sudo netstat -tulpn | grep 30120

# Kill process
sudo kill [PID]
```

### 4. Resources Not Loading
```
ERROR: Could not load resource [resource_name]
```
**วิธีแก้:**
- ตรวจสอบ fxmanifest.lua ใน resource นั้น
- ตรวจสอบ dependencies
- ดู server console สำหรับ error ละเอียด

---

## 📝 Checklist ก่อนรัน

- [ ] FiveM Server downloaded
- [ ] License Key ใส่ใน server.cfg แล้ว
- [ ] MySQL running และ database import แล้ว
- [ ] mysql-async resource ดาวน์โหลดแล้ว
- [ ] ESX dependencies ดาวน์โหลดแล้ว
- [ ] Port 30120 ว่าง (ไม่ถูกใช้งาน)
- [ ] Firewall เปิด port 30120

---

## 🎯 ลำดับการรันครั้งแรก

```bash
# 1. Setup MySQL
cd ~/Documents/server\ fivem
sudo mysql < setup-database.sql
mysql -u fivem -pfivem2024 fivem_db < sql/database.sql

# 2. Download Server
./download-server.sh

# 3. Download Dependencies
cd resources
git clone https://github.com/brouznouf/fivem-mysql-async.git mysql-async
cd ..

# 4. Edit Config
nano server.cfg
# ใส่ License Key

# 5. Start Server!
./start-server.sh
```

เท่านี้ Server ก็พร้อมรันแล้ว! 🎉
