# วิธีการ Push โปรเจคไป GitHub

โปรเจคถูกสร้างและ commit เรียบร้อยแล้ว! ตอนนี้คุณสามารถ push ไป GitHub ได้ 3 วิธี:

## วิธีที่ 1: ใช้ GitHub CLI (แนะนำ)

```bash
# ติดตั้ง GitHub CLI
sudo apt install gh

# Login
gh auth login

# Push
cd "/home/admin-oven/Documents/server fivem"
git push -u origin main
```

## วิธีที่ 2: ใช้ Personal Access Token

1. ไปที่ GitHub Settings → Developer settings → Personal access tokens → Tokens (classic)
2. Generate new token (classic)
3. เลือก scopes: `repo` (ทั้งหมด)
4. Copy token

```bash
cd "/home/admin-oven/Documents/server fivem"

# Push โดยใส่ token
git push https://YOUR_TOKEN@github.com/oven-ttta/server-fivem.git main

# หรือตั้งค่า remote ใหม่
git remote set-url origin https://YOUR_TOKEN@github.com/oven-ttta/server-fivem.git
git push -u origin main
```

## วิธีที่ 3: ใช้ SSH Key

```bash
# สร้าง SSH key
ssh-keygen -t ed25519 -C "your_email@example.com"

# Copy public key
cat ~/.ssh/id_ed25519.pub

# เพิ่ม SSH key ไปที่ GitHub:
# Settings → SSH and GPG keys → New SSH key → Paste key

# เปลี่ยน remote เป็น SSH
cd "/home/admin-oven/Documents/server fivem"
git remote set-url origin git@github.com:oven-ttta/server-fivem.git
git push -u origin main
```

## สถานะปัจจุบัน

โปรเจคของคุณพร้อมแล้ว:
- ✅ Git initialized
- ✅ Files committed
- ✅ Remote repository configured
- ⏳ รอการ push (ต้อง authenticate)

## หลังจาก Push แล้ว

ไปดูที่: https://github.com/oven-ttta/server-fivem

## การอัพเดทในอนาคต

```bash
cd "/home/admin-oven/Documents/server fivem"
git add .
git commit -m "Update: คำอธิบายการเปลี่ยนแปลง"
git push
```
