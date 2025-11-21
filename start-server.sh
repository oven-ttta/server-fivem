#!/bin/bash

echo "=========================================="
echo "🚀 Starting FiveM Thai Roleplay Server"
echo "=========================================="
echo ""

# เช็คว่า server files มีหรือไม่
if [ ! -f "server-files/run.sh" ]; then
    echo "❌ ERROR: FiveM server files not found!"
    echo ""
    echo "Please download server files first:"
    echo "  ./download-server.sh"
    echo ""
    exit 1
fi

# เช็คว่า mysql-async มีหรือไม่
if [ ! -d "resources/mysql-async" ]; then
    echo "⚠️  WARNING: mysql-async not found!"
    echo ""
    echo "Downloading dependencies..."
    ./download-dependencies.sh
    echo ""
fi

# เช็คว่า License Key ตั้งค่าแล้วหรือไม่
if grep -q "cfxk_xxxxx" server.cfg; then
    echo "❌ ERROR: License Key not set!"
    echo ""
    echo "Please edit server.cfg and add your license key:"
    echo "  nano server.cfg"
    echo ""
    echo "Get your license key from:"
    echo "  https://keymaster.fivem.net"
    echo ""
    exit 1
fi

# เช็คว่า MySQL running หรือไม่
if ! systemctl is-active --quiet mysql && ! systemctl is-active --quiet mariadb; then
    echo "⚠️  WARNING: MySQL/MariaDB is not running!"
    echo ""
    echo "Starting MySQL..."
    sudo systemctl start mysql 2>/dev/null || sudo systemctl start mariadb 2>/dev/null
    sleep 2
fi

# เช็คว่า Database มีหรือไม่
DB_EXISTS=$(mysql -u fivem -pfivem2024 -e "SHOW DATABASES LIKE 'fivem_db';" 2>/dev/null | grep fivem_db)
if [ -z "$DB_EXISTS" ]; then
    echo "⚠️  WARNING: Database 'fivem_db' not found!"
    echo ""
    echo "Please setup MySQL first:"
    echo "  sudo mysql < setup-database.sql"
    echo "  mysql -u fivem -pfivem2024 fivem_db < sql/database.sql"
    echo ""
    read -p "Do you want to continue anyway? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        exit 1
    fi
fi

echo "✅ Pre-flight checks passed!"
echo ""
echo "🔧 Server Information:"
echo "  • Config: server.cfg"
echo "  • Port: 30120"
echo "  • Database: fivem_db"
echo ""
echo "🎮 To connect:"
echo "  F8 in FiveM → connect localhost:30120"
echo ""
echo "🛑 To stop:"
echo "  Press Ctrl+C"
echo ""
echo "=========================================="
echo ""

# เริ่ม Server
cd server-files
bash run.sh +exec "../server.cfg"
