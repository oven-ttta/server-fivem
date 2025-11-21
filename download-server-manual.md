# วิธีดาวน์โหลด FiveM Server แบบ Manual

ถ้าสคริปต์อัตโนมัติไม่ทำงาน ให้ดาวน์โหลดด้วยมือ:

## ขั้นตอน:

### 1. เปิดเว็บเบราว์เซอร์ไปที่:
```
https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/
```

### 2. คลิกที่ build number ล่าสุด (ตัวเลขที่ใหญ่ที่สุด)
ตัวอย่าง: `7290-xxxxx` หรือมากกว่า

### 3. ดาวน์โหลดไฟล์ `fx.tar.xz`

### 4. ย้ายไฟล์ไปยัง server-files:
```bash
cd ~/Documents/server\ fivem
mkdir -p server-files
mv ~/Downloads/fx.tar.xz server-files/
cd server-files
tar xf fx.tar.xz
rm fx.tar.xz
```

### 5. ตรวจสอบว่าแตกไฟล์สำเร็จ:
```bash
ls -la
```

ควรเห็นไฟล์:
- `run.sh`
- `FXServer`
- `alpine/`

### 6. กลับไป root และดาวน์โหลด dependencies:
```bash
cd ..
./download-dependencies.sh
```

### 7. เริ่ม Server:
```bash
./start-server.sh
```

---

## วิธีอื่น: ใช้ txAdmin (แนะนำสำหรับ production)

txAdmin เป็น web-based management panel ของ FiveM:

```bash
# ดาวน์โหลด txAdmin version
cd ~/Documents/server\ fivem
mkdir -p server-files
cd server-files

# สำหรับ Linux
bash <(curl -s https://raw.githubusercontent.com/tabarra/txAdmin/master/scripts/setup.sh)

# txAdmin จะรันที่ http://localhost:40120
```

ข้อดีของ txAdmin:
- GUI สำหรับจัดการ server
- Auto-updater
- Resource manager
- Player management
- Server logs viewer
- Schedule restarts

---

## หมายเหตุ:

ถ้าใช้ txAdmin คุณไม่จำเป็นต้องดาวน์โหลด FiveM Server แบบปกติ
txAdmin จะดาวน์โหลดและจัดการทุกอย่างให้

แต่ถ้าต้องการควบคุมเองแบบ manual ก็ใช้วิธีด้านบนได้เลย
