#!/bin/bash

echo "=========================================="
echo "📦 Downloading FiveM Dependencies"
echo "=========================================="
echo ""

cd resources

# 1. mysql-async
echo "1️⃣ Downloading mysql-async..."
if [ -d "mysql-async" ]; then
    echo "   ⚠️  mysql-async already exists, skipping..."
else
    git clone --depth 1 https://github.com/brouznouf/fivem-mysql-async.git mysql-async
    if [ $? -eq 0 ]; then
        echo "   ✅ mysql-async downloaded"
    else
        echo "   ❌ Failed to download mysql-async"
    fi
fi
echo ""

# 2. ESX Menu System
echo "2️⃣ Downloading ESX Menu System..."
cd "[core]"

if [ -d "esx_menu_default" ]; then
    echo "   ⚠️  esx_menu_default already exists, skipping..."
else
    git clone --depth 1 https://github.com/esx-framework/esx_menu_default.git
    echo "   ✅ esx_menu_default downloaded"
fi

if [ -d "esx_menu_list" ]; then
    echo "   ⚠️  esx_menu_list already exists, skipping..."
else
    git clone --depth 1 https://github.com/esx-framework/esx_menu_list.git
    echo "   ✅ esx_menu_list downloaded"
fi

if [ -d "esx_menu_dialog" ]; then
    echo "   ⚠️  esx_menu_dialog already exists, skipping..."
else
    git clone --depth 1 https://github.com/esx-framework/esx_menu_dialog.git
    echo "   ✅ esx_menu_dialog downloaded"
fi
echo ""

# 3. Skin System
echo "3️⃣ Downloading Skin/Character System..."

if [ -d "skinchanger" ]; then
    echo "   ⚠️  skinchanger already exists, skipping..."
else
    git clone --depth 1 https://github.com/esx-framework/skinchanger.git
    echo "   ✅ skinchanger downloaded"
fi

if [ -d "esx_skin" ]; then
    echo "   ⚠️  esx_skin already exists, skipping..."
else
    git clone --depth 1 https://github.com/esx-framework/esx_skin.git
    echo "   ✅ esx_skin downloaded"
fi
echo ""

# 4. Basic Needs
echo "4️⃣ Downloading Basic Needs System..."

if [ -d "esx_basicneeds" ]; then
    echo "   ⚠️  esx_basicneeds already exists, skipping..."
else
    git clone --depth 1 https://github.com/esx-framework/esx_basicneeds.git
    echo "   ✅ esx_basicneeds downloaded"
fi

if [ -d "esx_status" ]; then
    echo "   ⚠️  esx_status already exists, skipping..."
else
    git clone --depth 1 https://github.com/esx-framework/esx_status.git
    echo "   ✅ esx_status downloaded"
fi
echo ""

# กลับไป root
cd ../..

echo "=========================================="
echo "✅ All Dependencies Downloaded!"
echo "=========================================="
echo ""
echo "📁 Resources downloaded:"
echo "  • mysql-async (Database)"
echo "  • esx_menu_* (Menu System)"
echo "  • skinchanger (Character Skin)"
echo "  • esx_skin (Skin Manager)"
echo "  • esx_basicneeds (Hunger/Thirst)"
echo "  • esx_status (Player Status)"
echo ""
echo "📝 Next step:"
echo "  Run: ./start-server.sh"
echo ""
