#!/bin/bash

echo "=========================================="
echo "FiveM MySQL Database Setup"
echo "=========================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# ตรวจสอบว่ามี MySQL/MariaDB หรือไม่
if ! command -v mysql &> /dev/null; then
    echo -e "${RED}✗${NC} MySQL/MariaDB not found!"
    echo ""
    echo "Please install MySQL/MariaDB first:"
    echo "  sudo apt update"
    echo "  sudo apt install mariadb-server"
    exit 1
fi

echo -e "${GREEN}✓${NC} MySQL/MariaDB found"
echo ""

# ตรวจสอบว่า MySQL service running หรือไม่
if ! systemctl is-active --quiet mysql && ! systemctl is-active --quiet mariadb; then
    echo -e "${YELLOW}!${NC} MySQL/MariaDB is not running"
    echo "Starting MySQL/MariaDB..."
    sudo systemctl start mysql 2>/dev/null || sudo systemctl start mariadb 2>/dev/null
    sleep 2
fi

echo "Setting up FiveM Database..."
echo "-------------------------------------------"
echo ""

# สร้างไฟล์ SQL สำหรับ setup
cat > /tmp/fivem_setup.sql << 'EOSQL'
-- สร้าง database
CREATE DATABASE IF NOT EXISTS fivem_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- สร้าง user สำหรับ FiveM
CREATE USER IF NOT EXISTS 'fivem'@'localhost' IDENTIFIED BY 'fivem2024';

-- ให้สิทธิ์
GRANT ALL PRIVILEGES ON fivem_db.* TO 'fivem'@'localhost';
FLUSH PRIVILEGES;

-- แสดงผลลัพธ์
SELECT 'Database and user created successfully!' AS Status;
EOSQL

echo "Creating database and user..."
echo "-------------------------------------------"

# รัน SQL ด้วย sudo (เพราะ root ใช้ auth_socket)
sudo mysql < /tmp/fivem_setup.sql

if [ $? -eq 0 ]; then
    echo ""
    echo -e "${GREEN}✓${NC} Database setup completed!"
    echo ""
    echo "Database Details:"
    echo "  Database: fivem_db"
    echo "  User: fivem"
    echo "  Password: fivem2024"
    echo "  Host: localhost"
    echo ""

    # ลบไฟล์ temp
    rm /tmp/fivem_setup.sql

    # Import database schema
    echo "Importing database schema..."
    echo "-------------------------------------------"

    if [ -f "sql/database.sql" ]; then
        mysql -u fivem -pfivem2024 fivem_db < sql/database.sql

        if [ $? -eq 0 ]; then
            echo ""
            echo -e "${GREEN}✓${NC} Database schema imported successfully!"

            # นับจำนวน tables
            TABLE_COUNT=$(mysql -u fivem -pfivem2024 fivem_db -N -e "SELECT COUNT(*) FROM information_schema.tables WHERE table_schema = 'fivem_db';")
            echo -e "${GREEN}✓${NC} Created $TABLE_COUNT tables"

            echo ""
            echo "Tables created:"
            mysql -u fivem -pfivem2024 fivem_db -N -e "SHOW TABLES;" | sed 's/^/  - /'
        else
            echo -e "${RED}✗${NC} Failed to import database schema"
            exit 1
        fi
    else
        echo -e "${YELLOW}!${NC} sql/database.sql not found"
    fi

    echo ""
    echo "-------------------------------------------"
    echo "MySQL Connection String for server.cfg:"
    echo "-------------------------------------------"
    echo ""
    echo 'set mysql_connection_string "mysql://fivem:fivem2024@localhost/fivem_db?charset=utf8mb4"'
    echo ""
    echo "-------------------------------------------"
    echo ""
    echo -e "${GREEN}✓${NC} Setup completed successfully!"
    echo ""
    echo "Next steps:"
    echo "  1. Update server.cfg with the connection string above"
    echo "  2. Download mysql-async resource"
    echo "  3. Start your FiveM server"

else
    echo ""
    echo -e "${RED}✗${NC} Database setup failed!"
    echo ""
    echo "If you see 'Access denied', try running:"
    echo "  sudo mysql"
    echo ""
    echo "Then manually run these commands:"
    echo "  CREATE DATABASE fivem_db;"
    echo "  CREATE USER 'fivem'@'localhost' IDENTIFIED BY 'fivem2024';"
    echo "  GRANT ALL PRIVILEGES ON fivem_db.* TO 'fivem'@'localhost';"
    echo "  FLUSH PRIVILEGES;"
    rm /tmp/fivem_setup.sql
    exit 1
fi
