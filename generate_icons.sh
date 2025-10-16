#!/bin/bash

# TANGO Restaurant POS - Icon Generator Script

echo "🎨 TANGO POS - Generating App Icons..."
echo ""

# Check if icon files exist
if [ ! -f "assets/images/app_icon.png" ]; then
    echo "❌ Error: app_icon.png not found in assets/images/"
    echo ""
    echo "Please create a 1024x1024 PNG icon and save it as:"
    echo "  assets/images/app_icon.png"
    echo ""
    echo "See APP_ICON_SETUP.md for details."
    exit 1
fi

if [ ! -f "assets/images/app_icon_foreground.png" ]; then
    echo "⚠️  Warning: app_icon_foreground.png not found"
    echo "Copying app_icon.png as foreground..."
    cp assets/images/app_icon.png assets/images/app_icon_foreground.png
fi

echo "✅ Icon files found"
echo ""

# Install dependencies
echo "📦 Installing dependencies..."
flutter pub get

echo ""

# Generate icons
echo "🚀 Generating platform icons..."
flutter pub run flutter_launcher_icons

echo ""
echo "✅ Done! App icons generated for iOS and Android"
echo ""
echo "Next steps:"
echo "  1. Run: flutter clean"
echo "  2. Run: flutter run"
echo "  3. Check your app icon!"
