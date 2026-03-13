# WitherHost Android APK Build Guide

## Prerequisites

- **Node.js 16+** and npm/yarn installed
- **Android Studio** 2022.1 or later
- **Java Development Kit (JDK)** 11 or later
- **Android SDK** with:
  - SDK Platform API 33 (Android 13) or higher
  - Android Build-tools 33.0.0 or higher
- **Android device or emulator**

## Quick Start (Automated)

### Option 1: Using the Setup Script (Recommended)

```bash
# Make the script executable
chmod +x scripts/setup-android.sh

# Run the setup script
./scripts/setup-android.sh
```

This script will:
1. Install all npm dependencies
2. Build the Next.js app
3. Initialize the Capacitor Android project
4. Sync files with Android

Then open Android Studio and run!

### Option 2: Manual Setup

#### Step 1: Install Dependencies
```bash
npm install
```

#### Step 2: Build the Web App
```bash
npm run build
```

#### Step 3: Add Android Platform
```bash
npx cap add android
```

#### Step 4: Sync Everything
```bash
npx cap sync android
```

#### Step 5: Open in Android Studio
```bash
# Navigate to android folder
cd android

# Open in Android Studio (macOS)
open -a "Android Studio" .

# On Windows/Linux, open Android Studio and select File → Open → android folder
```

## Building the APK

### Method 1: Using Android Studio GUI (Easiest)

1. Open the `android` folder in Android Studio
2. Wait for Gradle sync to complete
3. Connect an Android device via USB (enable Developer Mode)
4. Click the green **Run** button (▶️)
5. Select your device and click OK

**For Release APK:**
- Go to **Build** → **Build Bundle(s) / APK(s)** → **Build APK(s)**
- APK will be in: `android/app/release/app-release.apk`

### Method 2: Command Line Build

```bash
cd android

# Build debug APK
./gradlew assembleDebug

# Build release APK (requires keystore - see signing below)
./gradlew assembleRelease

# APK locations:
# Debug: android/app/build/outputs/apk/debug/app-debug.apk
# Release: android/app/build/outputs/apk/release/app-release.apk
```

## Signing the Release APK

For Google Play Store releases, you need to sign your APK with a keystore.

### Generate a Keystore (One-time)

```bash
keytool -genkey -v -keystore release.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias witherhostkey

# You'll be prompted for:
# - Password (remember this!)
# - Name
# - Organization
# - Location info
```

### Configure Gradle for Signing

Edit `android/app/build.gradle` and add before `buildTypes`:

```gradle
signingConfigs {
    release {
        storeFile file('../release.keystore')
        storePassword 'your_password_here'
        keyAlias 'witherhostkey'
        keyPassword 'your_password_here'
    }
}

buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled true
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
}
```

### Build Signed Release APK

```bash
cd android
./gradlew assembleRelease
```

## Updating the App

After making changes to your Next.js app:

```bash
# Rebuild and sync
npm run build
npx cap sync android
```

Then refresh in Android Studio or rebuild the APK.

## Firebase Configuration

Your app uses Firebase. The `google-services.json` is already in `android/app/`. Make sure it matches your Firebase project.

### To update Firebase config:
1. Go to [Firebase Console](https://console.firebase.google.com)
2. Select your project
3. Download `google-services.json`
4. Replace `android/app/google-services.json`
5. Rebuild the app

## Troubleshooting

### "Build failed" or Gradle errors

```bash
cd android
./gradlew clean
./gradlew assembleDebug
```

### Android SDK not found

In Android Studio:
- Go to **Tools** → **SDK Manager**
- Install the required SDK Platform and Build-tools

### USB Device not recognized

- Enable Developer Mode on your Android device
- Install USB drivers for your device
- Run `adb devices` to verify connection

### Firebase initialization fails

- Verify `google-services.json` is correct
- Check that Firebase is initialized in `next.config.js`

## App Configuration

Located in `capacitor.config.ts`:

```typescript
- App ID: com.armmc.app
- App Name: WitherHost
- Web Directory: out (Next.js build output)
- Splash Screen: Dark theme matching app
- Status Bar: Dark theme
```

## Useful Commands

```bash
# View Capacitor version and status
npx cap info

# Copy web files to Android
npx cap copy android

# Full sync (copy + update native files)
npx cap sync android

# Open Android project
npx cap open android

# List connected devices
adb devices

# View logs from Android device
adb logcat
```

## File Structure

```
project/
├── out/                    # Next.js build output (webDir)
├── android/                # Android native project
│   ├── app/
│   │   ├── src/
│   │   ├── build.gradle
│   │   └── google-services.json
│   ├── build.gradle
│   └── gradlew
├── src/                    # Next.js source
├── capacitor.config.ts     # Capacitor configuration
└── package.json
```

## Next Steps

1. ✅ Run the setup script or follow manual setup
2. ✅ Build the APK using Android Studio or CLI
3. ✅ Test on an Android device/emulator
4. ✅ Sign the APK for Google Play Store
5. ✅ Submit to Google Play Store

## Support Resources

- [Capacitor Documentation](https://capacitorjs.com/docs)
- [Android Development Guide](https://developer.android.com/docs)
- [Firebase Setup](https://firebase.google.com/docs/android/setup)
- [Google Play Console](https://play.google.com/console)

---

**Happy building! 🚀**
