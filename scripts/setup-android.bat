@echo off
REM WitherHost Android APK Build Setup Script (Windows)

echo ==========================================
echo WitherHost Android APK Setup
echo ==========================================
echo.

REM Check if Node modules are installed
if not exist "node_modules" (
    echo 1. Installing dependencies...
    call npm install
)

REM Build the Next.js app for production
echo.
echo 2. Building Next.js app...
call npm run build

REM Initialize Capacitor Android project
echo.
echo 3. Setting up Capacitor Android project...
call npx cap add android

REM Sync the web app with Android
echo.
echo 4. Syncing web app to Android...
call npx cap sync android

echo.
echo ==========================================
echo Setup Complete!
echo ==========================================
echo.
echo Next Steps:
echo 1. Open Android Studio
echo 2. Select: File - Open - android folder in this project
echo 3. Wait for Gradle sync to complete
echo 4. Connect an Android device via USB OR set up Android Emulator
echo 5. Click the Run button (green play icon)
echo.
echo To build APK manually in Android Studio:
echo    Build - Build Bundle(s) / APK(s) - Build APK(s)
echo.
echo To build from command line:
echo    cd android
echo    gradlew.bat assembleRelease
echo.
pause
