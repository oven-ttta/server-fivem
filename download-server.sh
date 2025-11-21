#!/bin/bash

echo "=========================================="
echo "🚀 FiveM Server Downloader"
echo "=========================================="
echo ""

# สร้างโฟลเดอร์
mkdir -p server-files
cd server-files

echo "📥 Finding latest FiveM Server build..."
echo ""

# ดึงข้อมูลเวอร์ชันล่าสุดจาก API
LATEST_URL=$(curl -s "https://changelogs-live.fivem.net/api/changelog/versions/linux/server" | grep -o '"download":"[^"]*' | grep -o 'http[^"]*' | head -1)

if [ -z "$LATEST_URL" ]; then
    echo "❌ Could not find latest version!"
    echo ""
    echo "Please download manually:"
    echo "1. Go to: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/"
    echo "2. Click on latest build number"
    echo "3. Download fx.tar.xz"
    echo "4. Extract to: $(pwd)"
    echo ""
    exit 1
fi

echo "✓ Found latest build"
echo "📍 URL: $LATEST_URL"
echo ""
echo "📥 Downloading..."
echo ""

# ดาวน์โหลด
wget --progress=bar:force:noscroll \
    -O fx.tar.xz \
    "$LATEST_URL" 2>&1

if [ $? -eq 0 ]; then
    echo ""
    echo "📦 Extracting files..."
    tar xf fx.tar.xz

    if [ $? -eq 0 ]; then
        rm fx.tar.xz

        echo ""
        echo "✅ FiveM Server downloaded successfully!"
        echo ""
        echo "📁 Server files location:"
        pwd
        echo ""
        echo "📝 Next steps:"
        echo "  1. Download dependencies: cd .. && ./download-dependencies.sh"
        echo "  2. Start server: cd .. && ./start-server.sh"
        echo ""
    else
        echo ""
        echo "❌ Extraction failed!"
        exit 1
    fi
else
    echo ""
    echo "❌ Download failed!"
    echo ""
    echo "Please try downloading manually:"
    echo "1. Go to: https://runtime.fivem.net/artifacts/fivem/build_proot_linux/master/"
    echo "2. Download the latest build"
    echo "3. Extract to: $(pwd)"
    exit 1
fi
