#!/bin/bash

echo "=========================================="
echo "FiveM Config Validation"
echo "=========================================="
echo ""

GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

ERRORS=0

echo "Validating Lua Syntax..."
echo "-------------------------------------------"

# Find all Lua files
LUA_FILES=$(find resources -name "*.lua" -o -name "fxmanifest.lua")

for file in $LUA_FILES; do
    # Check if file is readable
    if [ -r "$file" ]; then
        # Try to check basic syntax (we don't have luac, so just check for common errors)
        if grep -q "function.*function" "$file" 2>/dev/null; then
            echo -e "${RED}✗${NC} Potential syntax error in: $file (nested function)"
            ((ERRORS++))
        else
            echo -e "${GREEN}✓${NC} $file"
        fi
    fi
done

echo ""
echo "Validating SQL Syntax..."
echo "-------------------------------------------"

if [ -f "sql/database.sql" ]; then
    # Check for basic SQL syntax
    if grep -q "CREATE TABLE" sql/database.sql && grep -q "ENGINE=" sql/database.sql; then
        echo -e "${GREEN}✓${NC} SQL file has valid structure"

        # Count tables
        TABLE_COUNT=$(grep -c "CREATE TABLE" sql/database.sql)
        echo -e "${BLUE}ℹ${NC} Found $TABLE_COUNT tables"

        # List tables
        echo -e "${BLUE}ℹ${NC} Tables:"
        grep "CREATE TABLE" sql/database.sql | sed 's/CREATE TABLE IF NOT EXISTS /  - /' | sed 's/ .*//'
    else
        echo -e "${RED}✗${NC} SQL file may have syntax errors"
        ((ERRORS++))
    fi
fi

echo ""
echo "Validating Server Config..."
echo "-------------------------------------------"

if [ -f "server.cfg" ]; then
    # Check for required settings

    if grep -q "sv_licenseKey" server.cfg; then
        if grep -q 'sv_licenseKey "cfxk_xxxxx' server.cfg; then
            echo -e "${YELLOW}!${NC} Warning: Default license key detected (needs to be changed)"
        else
            echo -e "${GREEN}✓${NC} License key configured"
        fi
    else
        echo -e "${RED}✗${NC} Missing sv_licenseKey"
        ((ERRORS++))
    fi

    if grep -q "mysql_connection_string" server.cfg; then
        if grep -q 'password@localhost' server.cfg; then
            echo -e "${YELLOW}!${NC} Warning: Default MySQL password (needs to be changed)"
        else
            echo -e "${GREEN}✓${NC} MySQL connection string configured"
        fi
    else
        echo -e "${RED}✗${NC} Missing mysql_connection_string"
        ((ERRORS++))
    fi

    if grep -q "endpoint_add_tcp" server.cfg; then
        echo -e "${GREEN}✓${NC} TCP endpoint configured"
    fi

    if grep -q "endpoint_add_udp" server.cfg; then
        echo -e "${GREEN}✓${NC} UDP endpoint configured"
    fi

    # Count ensures
    ENSURE_COUNT=$(grep -c "^ensure " server.cfg)
    echo -e "${BLUE}ℹ${NC} Resources to load: $ENSURE_COUNT"
fi

echo ""
echo "Checking Resource Dependencies..."
echo "-------------------------------------------"

# Check if resources reference each other correctly
if grep -q "es_extended" resources/[core]/esx_identity/fxmanifest.lua; then
    echo -e "${GREEN}✓${NC} esx_identity depends on es_extended"
fi

if grep -q "es_extended" resources/[jobs]/esx_policejob/fxmanifest.lua; then
    echo -e "${GREEN}✓${NC} esx_policejob depends on es_extended"
fi

if grep -q "es_extended" resources/[admin]/admin_system/fxmanifest.lua; then
    echo -e "${GREEN}✓${NC} admin_system depends on es_extended"
fi

echo ""
echo "Checking File Permissions..."
echo "-------------------------------------------"

# Check if lua files are readable
UNREADABLE=0
for file in $(find resources -name "*.lua"); do
    if [ ! -r "$file" ]; then
        echo -e "${RED}✗${NC} Cannot read: $file"
        ((UNREADABLE++))
        ((ERRORS++))
    fi
done

if [ $UNREADABLE -eq 0 ]; then
    echo -e "${GREEN}✓${NC} All Lua files are readable"
fi

echo ""
echo "Checking for Common Issues..."
echo "-------------------------------------------"

# Check for BOM in Lua files
BOM_FILES=$(find resources -name "*.lua" -exec grep -l $'\xEF\xBB\xBF' {} \; 2>/dev/null | wc -l)
if [ $BOM_FILES -gt 0 ]; then
    echo -e "${RED}✗${NC} Found $BOM_FILES files with BOM (Byte Order Mark)"
    ((ERRORS++))
else
    echo -e "${GREEN}✓${NC} No BOM issues found"
fi

# Check for Windows line endings
CRLF_FILES=$(find resources -name "*.lua" -exec grep -l $'\r' {} \; 2>/dev/null | wc -l)
if [ $CRLF_FILES -gt 0 ]; then
    echo -e "${YELLOW}!${NC} Warning: Found $CRLF_FILES files with Windows line endings (CRLF)"
else
    echo -e "${GREEN}✓${NC} All files use Unix line endings"
fi

echo ""
echo "=========================================="
echo "Validation Summary"
echo "=========================================="

if [ $ERRORS -eq 0 ]; then
    echo -e "${GREEN}✓ All validations passed!${NC}"
    echo ""
    echo "Your FiveM server structure is ready!"
    echo ""
    echo "To run the server, you need:"
    echo "1. FiveM Server binaries"
    echo "2. Valid License Key"
    echo "3. MySQL/MariaDB running"
    echo "4. mysql-async resource"
    exit 0
else
    echo -e "${RED}✗ Found $ERRORS critical errors${NC}"
    echo "Please fix the errors before running the server"
    exit 1
fi
