# ⚡ Quick Start - FiveM Thai Roleplay Server

## 🎯 รัน Server ใน 5 ขั้นตอน

### 1️⃣ Setup MySQL (ครั้งเดียว)

```bash
cd ~/Documents/server\ fivem

# สร้าง database และ import schema
sudo mysql < setup-database.sql
mysql -u fivem -pfivem2024 fivem_db < sql/database.sql

# ตรวจสอบว่าสำเร็จ
mysql -u fivem -pfivem2024 fivem_db -e "SHOW TABLES;"
```

คุณควรเห็น **17 ตาราง**

---

### 2️⃣ ดาวน์โหลด FiveM Server (ครั้งเดียว)

```bash
./download-server.sh
```

รอสักครู่... Server จะถูกดาวน์โหลดและแตกไฟล์อัตโนมัติ

---

### 3️⃣ ดาวน์โหลด Dependencies (ครั้งเดียว)

```bash
./download-dependencies.sh
```

จะดาวน์โหลด:
- mysql-async
- ESX Menus
- Skin System
- Basic Needs

---

### 4️⃣ ใส่ License Key

```bash
nano server.cfg
```

แก้บรรทัดนี้:
```cfg
sv_licenseKey "cfxk_xxxxxxxxxxxxxxxxxxxxxxxxxxxxx_xxxxx"
```

👉 สมัคร License Key ฟรีที่: **https://keymaster.fivem.net**

บันทึก: `Ctrl+O` → `Enter` → `Ctrl+X`

---

### 5️⃣ เริ่ม Server! 🚀

```bash
./start-server.sh
```

เท่านี้ Server ก็เริ่มทำงานแล้ว!

---

## 🎮 วิธีเข้าเล่น

1. เปิด **FiveM Client**
2. กด **F8** (เปิด Console)
3. พิมพ์:
   ```
   connect localhost:30120
   ```
4. กด **Enter**

---

## 🛑 วิธีหยุด Server

กด **Ctrl+C** ใน terminal

---

## ❓ แก้ไขปัญหาเบื้องต้น

### Server ไม่เริ่ม - License Key Invalid

```bash
# ตรวจสอบ License Key
grep sv_licenseKey server.cfg

# ต้องได้: sv_licenseKey "cfxk_..."
# ถ้าได้: cfxk_xxxxx = ยังไม่ได้แก้ไข!
```

**แก้ไข:** ใส่ License Key จริงใน server.cfg

---

### Server ไม่เริ่ม - MySQL Connection Failed

```bash
# เช็ค MySQL running
sudo systemctl status mysql

# ถ้า inactive → เริ่ม MySQL
sudo systemctl start mysql

# เช็ค Database
mysql -u fivem -pfivem2024 -e "SHOW DATABASES;"

# ถ้าไม่มี fivem_db → import ใหม่
sudo mysql < setup-database.sql
mysql -u fivem -pfivem2024 fivem_db < sql/database.sql
```

---

### Server เริ่มแล้ว แต่เข้าไม่ได้

```bash
# เช็ค Port
netstat -tulpn | grep 30120

# ถ้าไม่เจอ → Server ยังไม่เริ่ม
# ดู error ใน terminal ที่รัน server
```

---

### Resources ไม่โหลด

```bash
# เช็ค dependencies
ls resources/mysql-async
ls resources/[core]/esx_menu_default

# ถ้าไม่มี → ดาวน์โหลดใหม่
./download-dependencies.sh
```

---

## 📝 ไฟล์และคำสั่งสำคัญ

| ไฟล์/คำสั่ง | ใช้ทำอะไร |
|-------------|-----------|
| `./download-server.sh` | ดาวน์โหลด FiveM Server |
| `./download-dependencies.sh` | ดาวน์โหลด Resources ที่จำเป็น |
| `./start-server.sh` | เริ่ม Server |
| `nano server.cfg` | แก้ไขการตั้งค่า Server |
| `sudo mysql < setup-database.sql` | ติดตั้ง MySQL Database |
| `Ctrl+C` | หยุด Server |

---

## 🎓 เรียนรู้เพิ่มเติม

- **[HOW-TO-RUN.md](HOW-TO-RUN.md)** - คู่มือละเอียด
- **[MYSQL-SETUP.md](MYSQL-SETUP.md)** - คู่มือ MySQL
- **[README.md](README.md)** - เอกสารหลัก
- **[INSTALLATION.md](INSTALLATION.md)** - คู่มือติดตั้ง

---

## ✅ Checklist

ก่อนรัน Server เช็คว่า:

- [ ] MySQL ติดตั้งและเริ่มทำงานแล้ว
- [ ] Database import แล้ว (17 ตาราง)
- [ ] FiveM Server downloaded แล้ว
- [ ] Dependencies downloaded แล้ว
- [ ] License Key ใส่แล้ว
- [ ] Port 30120 ว่าง

เช็คครบ? **รัน `./start-server.sh` เลย!** 🚀

---

## 🆘 ติดปัญหา?

1. อ่าน error ใน terminal
2. ดู [HOW-TO-RUN.md](HOW-TO-RUN.md)
3. เปิด Issue ที่ GitHub

---

**สนุกกับการเล่น! 🎮**
