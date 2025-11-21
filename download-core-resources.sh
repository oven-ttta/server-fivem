#!/bin/bash

echo "=========================================="
echo "📥 Downloading FiveM Core Resources"
echo "=========================================="
echo ""

RESOURCES_DIR="/home/admin-oven/Documents/server fivem/server-files/resources"

# สร้างโฟลเดอร์
mkdir -p "$RESOURCES_DIR"
cd "$RESOURCES_DIR"

echo "📦 Downloading default CFX resources..."
echo ""

# ดาวน์โหลด CFX default resources
CFX_RESOURCES=(
    "mapmanager"
    "chat"
    "spawnmanager"
    "sessionmanager"
    "basic-gamemode"
    "hardcap"
)

for resource in "${CFX_RESOURCES[@]}"; do
    if [ ! -d "$resource" ]; then
        echo "⬇️  Downloading $resource..."
        git clone "https://github.com/citizenfx/$resource.git" "$resource" 2>/dev/null
        if [ $? -eq 0 ]; then
            echo "   ✅ $resource downloaded"
        else
            echo "   ⚠️  Failed to download $resource (may need manual download)"
        fi
    else
        echo "   ⏭️  $resource already exists"
    fi
done

echo ""
echo "📦 Downloading mysql-async..."
if [ ! -d "mysql-async" ]; then
    git clone "https://github.com/brouznouf/fivem-mysql-async.git" mysql-async 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "   ✅ mysql-async downloaded"
    else
        echo "   ⚠️  Failed to download mysql-async"
    fi
else
    echo "   ⏭️  mysql-async already exists"
fi

echo ""
echo "📦 Downloading ESX Framework (v1-final)..."
if [ ! -d "[core]/es_extended" ]; then
    mkdir -p "[core]"
    cd "[core]"

    # ลอง download ESX จาก legacy version
    git clone "https://github.com/esx-framework/esx_core.git" es_extended 2>/dev/null
    if [ $? -ne 0 ]; then
        echo "   ⚠️  ESX repository not accessible, using custom version..."
        # ใช้ของที่เราสร้างไว้แล้ว
        if [ -d "/home/admin-oven/Documents/server fivem/resources/[core]/es_extended" ]; then
            cp -r "/home/admin-oven/Documents/server fivem/resources/[core]/es_extended" .
            echo "   ✅ Using custom ESX"
        fi
    else
        echo "   ✅ ESX downloaded"
    fi

    cd ..
else
    echo "   ⏭️  ESX already exists"
fi

echo ""
echo "=========================================="
echo "✅ Core Resources Setup Complete!"
echo ""
echo "📍 Resources location: $RESOURCES_DIR"
echo ""
echo "📝 Next steps:"
echo "   1. Run: cd .. && ./run-server.sh"
echo ""
echo "⚠️  Note: Some resources may not be available from GitHub"
echo "   You may need to download them manually from:"
echo "   - https://forum.cfx.re/"
echo "   - https://github.com/esx-framework"
echo "=========================================="
