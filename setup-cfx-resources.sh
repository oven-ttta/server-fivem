#!/bin/bash

echo "=========================================="
echo "📥 Setting up CFX Default Resources"
echo "=========================================="
echo ""

cd "/home/admin-oven/Documents/server fivem/server-files"

# ดาวน์โหลด cfx-server-data (มี resources ทั้งหมด)
if [ ! -d "cfx-server-data" ]; then
    echo "📦 Downloading cfx-server-data..."
    git clone https://github.com/citizenfx/cfx-server-data.git

    if [ $? -eq 0 ]; then
        echo "✅ Downloaded successfully"
        echo ""
        echo "📁 Copying resources..."

        # คัดลอก resources ที่จำเป็น
        cp -r cfx-server-data/resources/* resources/ 2>/dev/null

        echo "✅ Resources copied"
        echo ""
        echo "🧹 Cleaning up..."
        rm -rf cfx-server-data
    else
        echo "❌ Failed to download cfx-server-data"
        exit 1
    fi
else
    echo "✅ cfx-server-data already exists"
fi

echo ""
echo "📋 Copying custom resources..."

# คัดลอก resources ที่เราสร้างเอง
CUSTOM_RESOURCES="/home/admin-oven/Documents/server fivem/resources"
if [ -d "$CUSTOM_RESOURCES" ]; then
    # คัดลอก [core]
    if [ -d "$CUSTOM_RESOURCES/[core]" ]; then
        cp -r "$CUSTOM_RESOURCES/[core]" resources/ 2>/dev/null
        echo "✅ Copied [core] resources"
    fi

    # คัดลอก [jobs]
    if [ -d "$CUSTOM_RESOURCES/[jobs]" ]; then
        cp -r "$CUSTOM_RESOURCES/[jobs]" resources/ 2>/dev/null
        echo "✅ Copied [jobs] resources"
    fi

    # คัดลอก [admin]
    if [ -d "$CUSTOM_RESOURCES/[admin]" ]; then
        cp -r "$CUSTOM_RESOURCES/[admin]" resources/ 2>/dev/null
        echo "✅ Copied [admin] resources"
    fi
fi

echo ""
echo "=========================================="
echo "✅ Setup Complete!"
echo ""
echo "📍 Resources location: $(pwd)/resources"
echo ""
echo "📝 Available resources:"
ls -d resources/*/ 2>/dev/null | head -20
echo ""
echo "🚀 Start server with:"
echo "   cd .. && ./run-server.sh"
echo "=========================================="
