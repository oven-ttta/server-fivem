#!/bin/bash

echo "=========================================="
echo "FiveM Thai RP Server - Structure Test"
echo "=========================================="
echo ""

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

ERRORS=0
WARNINGS=0

check_file() {
    if [ -f "$1" ]; then
        echo -e "${GREEN}✓${NC} Found: $1"
        return 0
    else
        echo -e "${RED}✗${NC} Missing: $1"
        ((ERRORS++))
        return 1
    fi
}

check_dir() {
    if [ -d "$1" ]; then
        echo -e "${GREEN}✓${NC} Directory: $1"
        return 0
    else
        echo -e "${RED}✗${NC} Missing directory: $1"
        ((ERRORS++))
        return 1
    fi
}

check_config() {
    if grep -q "$2" "$1" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} Config OK: $2 in $1"
        return 0
    else
        echo -e "${YELLOW}!${NC} Warning: $2 not found in $1"
        ((WARNINGS++))
        return 1
    fi
}

echo "1. Checking Main Files..."
echo "-------------------------------------------"
check_file "server.cfg"
check_file "README.md"
check_file "INSTALLATION.md"
check_file "LICENSE"
check_file ".gitignore"
echo ""

echo "2. Checking SQL Database..."
echo "-------------------------------------------"
check_file "sql/database.sql"
if [ -f "sql/database.sql" ]; then
    TABLES=$(grep -c "CREATE TABLE" sql/database.sql)
    echo -e "${GREEN}✓${NC} Database contains $TABLES tables"
fi
echo ""

echo "3. Checking Core Resources..."
echo "-------------------------------------------"
check_dir "resources/[core]"
check_file "resources/[core]/es_extended/fxmanifest.lua"
check_file "resources/[core]/es_extended/config.lua"
check_file "resources/[core]/es_extended/locales/th.lua"
check_file "resources/[core]/esx_identity/fxmanifest.lua"
check_file "resources/[core]/esx_identity/config.lua"
check_file "resources/[core]/esx_identity/server/main.lua"
echo ""

echo "4. Checking Job Resources..."
echo "-------------------------------------------"
check_dir "resources/[jobs]"
check_file "resources/[jobs]/esx_policejob/fxmanifest.lua"
check_file "resources/[jobs]/esx_policejob/config/config.lua"
echo ""

echo "5. Checking Admin System..."
echo "-------------------------------------------"
check_dir "resources/[admin]"
check_file "resources/[admin]/admin_system/fxmanifest.lua"
check_file "resources/[admin]/admin_system/config.lua"
echo ""

echo "6. Checking Server Config..."
echo "-------------------------------------------"
check_config "server.cfg" "sv_hostname"
check_config "server.cfg" "mysql_connection_string"
check_config "server.cfg" "ensure es_extended"
echo ""

echo "7. Checking Git Repository..."
echo "-------------------------------------------"
if [ -d ".git" ]; then
    echo -e "${GREEN}✓${NC} Git repository initialized"
    COMMIT_COUNT=$(git rev-list --count HEAD 2>/dev/null)
    echo -e "${GREEN}✓${NC} Commits: $COMMIT_COUNT"
    REMOTE=$(git remote -v | grep origin | head -1)
    if [ ! -z "$REMOTE" ]; then
        echo -e "${GREEN}✓${NC} Remote: $REMOTE"
    fi
else
    echo -e "${RED}✗${NC} Git repository not initialized"
    ((ERRORS++))
fi
echo ""

echo "8. Counting Lines of Code..."
echo "-------------------------------------------"
LUA_FILES=$(find resources -name "*.lua" 2>/dev/null | wc -l)
SQL_LINES=$(wc -l < sql/database.sql 2>/dev/null || echo 0)
CONFIG_LINES=$(wc -l < server.cfg 2>/dev/null || echo 0)

echo -e "${GREEN}✓${NC} Lua files: $LUA_FILES"
echo -e "${GREEN}✓${NC} SQL lines: $SQL_LINES"
echo -e "${GREEN}✓${NC} Server config lines: $CONFIG_LINES"
echo ""

echo "=========================================="
echo "Test Summary"
echo "=========================================="
if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All structure tests passed!${NC}"
else
    echo -e "${RED}✗ Found $ERRORS errors${NC}"
fi

if [ $WARNINGS -gt 0 ]; then
    echo -e "${YELLOW}! Found $WARNINGS warnings${NC}"
fi

echo ""
echo "Next Steps:"
echo "-------------------------------------------"
echo "1. Download FiveM Server from: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/"
echo "2. Get License Key from: https://keymaster.fivem.net"
echo "3. Install MySQL: sudo apt install mariadb-server"
echo "4. Import database: mysql -u root -p fivem_db < sql/database.sql"
echo "5. Edit server.cfg with your License Key"
echo "6. Download mysql-async: git clone https://github.com/brouznouf/fivem-mysql-async.git resources/mysql-async"
echo "7. Start server with: ./run.sh +exec server.cfg"
echo ""

exit $ERRORS
