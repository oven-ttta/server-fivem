#!/bin/bash

echo "=========================================="
echo "🚀 Starting FiveM Thai Roleplay Server"
echo "=========================================="
echo ""

# ตั้งค่า paths
SCRIPT_DIR="/home/admin-oven/Documents/server fivem"
SERVER_DIR="$SCRIPT_DIR/server-files"
ALPINE_DIR="$SERVER_DIR/alpine"

# เช็คว่าไฟล์มีหรือไม่
if [ ! -f "$ALPINE_DIR/opt/cfx-server/FXServer" ]; then
    echo "❌ ERROR: FXServer not found!"
    echo "Path: $ALPINE_DIR/opt/cfx-server/FXServer"
    exit 1
fi

# เช็ค MySQL
if ! mysql -u fivem -pfivem2024 -e "USE fivem_db;" 2>/dev/null; then
    echo "⚠️  WARNING: Cannot connect to MySQL database!"
    echo "Make sure MySQL is running and database is imported"
    echo ""
fi

# เปลี่ยน directory
cd "$SERVER_DIR"

echo "📁 Working directory: $(pwd)"
echo "🔑 License Key: cfxk_1VoQqEIk4V0R3jKUGoFPh_2a8xMG"
echo "🗄️  Database: fivem_db"
echo "🌐 Port: 30120"
echo ""
echo "🎮 To connect:"
echo "   F8 in FiveM → connect localhost:30120"
echo ""
echo "🛑 To stop: Ctrl+C"
echo ""
echo "=========================================="
echo ""

# รัน FiveM Server ผ่าน ld-musl
exec "$ALPINE_DIR/opt/cfx-server/ld-musl-x86_64.so.1" \
    --library-path "$ALPINE_DIR/usr/lib/v8/:$ALPINE_DIR/lib/:$ALPINE_DIR/usr/lib/" \
    -- \
    "$ALPINE_DIR/opt/cfx-server/FXServer" \
    +set citizen_dir "$ALPINE_DIR/opt/cfx-server/citizen/" \
    +exec "$SCRIPT_DIR/server-basic.cfg"
