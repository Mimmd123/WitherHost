#!/bin/bash

# WitherHost Android APK Build Setup Script
# This script initializes the Capacitor Android project

echo "=========================================="
echo "WitherHost Android APK Setup"
echo "=========================================="
echo ""

# Check if Node modules are installed
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Build the Next.js app for production
echo ""
echo "🏗️  Building Next.js app..."
npm run build

# Initialize Capacitor Android project
echo ""
echo "📱 Setting up Capacitor Android project..."
npx cap add android

# Sync the web app with Android
echo ""
echo "🔄 Syncing web app to Android..."
npx cap sync android

echo ""
echo "=========================================="
echo "✅ Setup Complete!"
echo "=========================================="
echo ""
echo "📋 Next Steps:"
echo "1. Open Android Studio"
echo "2. Select: File → Open → android folder in this project"
echo "3. Wait for Gradle sync to complete"
echo "4. Connect an Android device via USB OR set up Android Emulator"
echo "5. Click the 'Run' button (green play icon)"
echo ""
echo "🔧 To build APK manually in Android Studio:"
echo "   Build → Build Bundle(s) / APK(s) → Build APK(s)"
echo ""
echo "💻 To build from command line:"
echo "   cd android"
echo "   ./gradlew assembleRelease"
echo ""
