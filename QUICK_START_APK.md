# 🚀 WitherHost APK - Quick Start Guide

## 5-Minute Setup

### Step 1: Run the Setup Script

**On macOS/Linux:**
```bash
chmod +x scripts/setup-android.sh
./scripts/setup-android.sh
```

**On Windows:**
```bash
scripts\setup-android.bat
```

This will:
- Install dependencies
- Build your Next.js app
- Initialize Capacitor Android project
- Sync everything automatically

### Step 2: Open in Android Studio

```bash
npm run cap:open
```

Or manually:
1. Open **Android Studio**
2. Click **File** → **Open**
3. Select the `android` folder in your project
4. Wait for Gradle to sync (1-2 minutes)

### Step 3: Run on Device or Emulator

1. **Connect your Android phone** via USB (or start an emulator)
2. Click the green **Run** button (▶️) in Android Studio
3. Select your device
4. Wait for the app to build and install (~2-5 minutes)

**Done! 🎉 Your app is now running on Android!**

---

## Building the APK

### For Testing (Debug APK)

**Using npm:**
```bash
npm run android:debug
```

**Using Android Studio:**
- Click **Run** button (▶️)
- APK is installed directly on connected device

### For Distribution (Release APK)

**Step 1: Create a Keystore (One-time)**

```bash
keytool -genkey -v -keystore release.keystore -keyalg RSA -keysize 2048 -validity 10000 -alias witherhostkey
```

When prompted, enter a password and remember it!

**Step 2: Configure Signing**

Edit `android/app/build.gradle` - find the `buildTypes` section and add before it:

```gradle
signingConfigs {
    release {
        storeFile file('../release.keystore')
        storePassword 'YOUR_PASSWORD_HERE'
        keyAlias 'witherhostkey'
        keyPassword 'YOUR_PASSWORD_HERE'
    }
}
```

**Step 3: Build Release APK**

```bash
npm run android:release
```

Your APK will be at: `android/app/build/outputs/apk/release/app-release.apk`

---

## Available Commands

| Command | What it does |
|---------|-----------|
| `npm run dev` | Start dev server |
| `npm run build` | Build Next.js app |
| `npm run android:setup` | Full Android setup (first time) |
| `npm run android:debug` | Build debug APK |
| `npm run android:release` | Build release APK |
| `npm run android:clean` | Clean Android build files |
| `npm run cap:sync` | Update Android after web changes |
| `npm run cap:copy` | Copy web files to Android |
| `npm run cap:open` | Open in Android Studio |

---

## After Making Changes

If you modify your Next.js app and want to update the Android build:

```bash
npm run build
npm run cap:sync
```

Then rebuild in Android Studio.

---

## Troubleshooting

### Build Fails - "SDK not found"
- Open Android Studio
- Go to **Tools** → **SDK Manager**
- Install **SDK Platform 33** and **Build-tools 33.0.0**

### Device Not Detected
```bash
# Check if device is connected
adb devices

# Enable developer mode on your Android phone:
# Settings → About Phone → Tap "Build Number" 7 times
# Settings → Developer Options → USB Debugging (enable)
```

### Gradle Sync Fails
```bash
npm run android:clean
npm run cap:sync
```

### Firebase Errors
- Download `google-services.json` from Firebase Console
- Replace `android/app/google-services.json`
- Rebuild the app

---

## File Structure

```
project/
├── src/                    # Next.js source code
├── out/                    # Built Next.js app (→ Android webDir)
├── android/                # ⚡ Android native project
│   ├── app/
│   ├── build.gradle
│   └── google-services.json
├── capacitor.config.ts     # Capacitor config
├── package.json            # Dependencies & scripts
├── ANDROID_BUILD_GUIDE.md  # Detailed guide
└── QUICK_START_APK.md      # This file
```

---

## What's Configured

✅ Capacitor for web→native conversion  
✅ Firebase integration  
✅ Tailwind CSS support  
✅ Dark theme (splash screen & status bar)  
✅ App ID: `com.armmc.app`  
✅ Min SDK: API 24 (Android 7.0)  
✅ Target SDK: API 33 (Android 13)  

---

## Next Steps

1. ✅ Run setup script
2. ✅ Open in Android Studio
3. ✅ Run on device/emulator
4. ✅ Build release APK
5. ✅ Submit to Google Play Store

---

## Need More Info?

- **Full Build Guide**: See `ANDROID_BUILD_GUIDE.md`
- **Capacitor Docs**: https://capacitorjs.com/docs
- **Google Play Console**: https://play.google.com/console

**Happy coding! 🚀**
