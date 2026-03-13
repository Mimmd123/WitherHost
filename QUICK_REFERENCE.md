# WitherHost APK - Quick Reference Card

**Print this page or save it!** Quick reference for all commands and procedures.

---

## 🚀 The Absolute Fastest Start

```bash
# Copy & paste these 3 commands in order:

# 1. Setup everything (macOS/Linux)
chmod +x scripts/setup-android.sh && ./scripts/setup-android.sh

# OR for Windows:
scripts\setup-android.bat

# 2. Open in Android Studio
npm run cap:open

# 3. Click the green Run button (▶) in Android Studio
# Done! App is on your phone.
```

---

## 📱 All Commands You Need

### Setup & Installation
```bash
npm run android:setup        # Full setup (first time only) - 1-2 min
npm run cap:open            # Open Android Studio
npm run cap:sync            # Update after code changes - 30 sec
```

### Building APKs
```bash
npm run android:debug       # Build debug APK (for testing) - 1-2 min
npm run android:release     # Build release APK (Google Play) - 2-3 min
npm run android:clean       # Clean build files - 30 sec
```

### Daily Development
```bash
npm run dev                 # Local dev server (test in browser)
npm run build               # Build web app - 1-2 min
npm run build && npm run cap:sync && npm run android:debug
  # Build + sync + compile all in one (most common)
```

---

## 🎮 Running on Device

### Physical Android Phone (Easiest)
1. Connect phone via USB cable
2. Enable Developer Mode: Settings → About Phone → Tap "Build Number" 7x
3. Enable USB Debugging: Settings → Developer Options
4. `npm run cap:open`
5. Click green **Run** button (▶)
6. Select your phone
7. Wait 2-5 minutes... Done! 🎉

### Android Emulator
1. Open Android Studio
2. Tools → Device Manager
3. Create & start emulator
4. `npm run cap:open`
5. Click green **Run** button (▶)
6. Select emulator
7. Wait... Done! 🎉

### Manual APK Installation
```bash
# Build APK
npm run android:debug

# Install on connected device
adb install android/app/build/outputs/apk/debug/app-debug.apk
```

---

## 🔐 Building for Google Play Store

### Step 1: Create Signing Key (Once)
```bash
keytool -genkey -v -keystore release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias witherhostkey
  
# When prompted:
# - Enter a password (SAVE THIS!)
# - Fill in your info
# - Confirm with 'yes'
```

### Step 2: Configure gradle (Edit `android/app/build.gradle`)

Find this section:
```gradle
android {
    ...
    compileSdk 33
    ...
}
```

Add BEFORE it:
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

Find `buildTypes` section and update:
```gradle
buildTypes {
    release {
        signingConfig signingConfigs.release
        minifyEnabled true
        proguardFiles getDefaultProguardFile('proguard-android-optimize.txt'), 'proguard-rules.pro'
    }
}
```

### Step 3: Build Release APK
```bash
npm run android:release
```

APK is at: `android/app/build/outputs/apk/release/app-release.apk`

### Step 4: Upload to Google Play
1. Go to https://play.google.com/console
2. Create new app or select existing
3. Release → Production
4. Upload your `app-release.apk`
5. Fill in store listing
6. Submit for review
7. Wait 24-72 hours
8. App goes live! 🚀

---

## 🐛 Troubleshooting Quick Fixes

| Problem | Quick Fix |
|---------|-----------|
| "Build failed" | `npm run android:clean && npm run android:setup` |
| "SDK not found" | Install Android SDK via Android Studio → Tools → SDK Manager |
| "Device not detected" | `adb devices` (check connection, enable USB debugging) |
| "Java not found" | Install JDK 11+, add to PATH |
| "Gradle sync fails" | `npm run android:clean && npm run cap:sync` |
| "Firebase errors" | Update `android/app/google-services.json` |
| "Can't find keytool" | Use built-in tool in Android Studio or full Java path |

---

## 🔍 Useful Debugging Commands

```bash
# List connected devices
adb devices

# View app logs (real-time)
adb logcat | grep "WitherHost"

# View all logs
adb logcat

# Record device screen
adb shell screenrecord /sdcard/video.mp4

# Pull recording to computer
adb pull /sdcard/video.mp4

# Install APK manually
adb install path/to/app.apk

# Uninstall app
adb uninstall com.armmc.app

# View app info
adb shell pm list packages | grep armmc
```

---

## 📁 Important File Locations

```
android/app/build/outputs/apk/
  ├── debug/
  │   └── app-debug.apk (for testing)
  └── release/
      └── app-release.apk (for Google Play)

android/app/
  ├── build.gradle (edit for signing config)
  └── google-services.json (Firebase config)

src/
  └── (Edit your React code here)

capacitor.config.ts
  └── (Capacitor bridge configuration)
```

---

## ⏱️ Expected Build Times

```
First Setup              3-5 minutes
Build Web App            1-2 minutes
Capacitor Sync           30 seconds
Debug APK Build          1-2 minutes
Release APK Build        2-3 minutes
Installation on Device   30-60 seconds
```

---

## ✅ Pre-Build Checklist

Before building, make sure:
- [ ] Java 11+ installed: `java -version`
- [ ] Android Studio installed
- [ ] Android SDK Platform 33 installed
- [ ] Android Build-tools 33.0.0 installed
- [ ] Device connected or emulator running
- [ ] Latest code built: `npm run build`
- [ ] Synced to Android: `npm run cap:sync`

---

## 🎯 Common Workflows

### Workflow 1: Quick Test During Development
```bash
npm run build
npm run cap:sync
npm run android:debug
# OR click Run in Android Studio
# Test on device → Done
```

### Workflow 2: Code Change → Test
```bash
# Edit code in src/
npm run build
npm run cap:sync
# Rebuild in Android Studio (Ctrl+Shift+F10 on Windows, Cmd+R on Mac)
# Test → Done
```

### Workflow 3: Build for Google Play
```bash
npm run build
npm run cap:sync
npm run android:release
# Get app-release.apk
# Upload to Google Play Console
# Done!
```

### Workflow 4: Full Reset
```bash
npm run android:clean
rm -rf android    # Delete android folder
npm run android:setup   # Recreate from scratch
npm run cap:open
```

---

## 📚 Documentation Quick Links

| Document | Purpose | Read Time |
|----------|---------|-----------|
| **QUICK_START_APK.md** | Fast setup | 5 min |
| **ANDROID_BUILD_GUIDE.md** | Complete reference | 30 min |
| **ANDROID_ENV_SETUP.md** | Installation help | 15 min |
| **README_ANDROID.md** | Full overview | 15 min |
| **BUILD_WORKFLOW.md** | Visual diagrams | 10 min |

---

## 🔧 Configuration Summary

| Setting | Value |
|---------|-------|
| App ID | `com.armmc.app` |
| App Name | `WitherHost` |
| Min Android | API 24 (Android 7.0) |
| Target Android | API 33 (Android 13) |
| Capacitor | v5.7.0 |
| Build System | Gradle |
| Build Tool | Android SDK 33.0.0 |

---

## 💡 Pro Tips

1. **Speed up builds**: Keep Android emulator always open
2. **Better debugging**: Use `adb logcat` to see real-time logs
3. **Faster rebuilds**: Use "Run" button instead of full rebuild
4. **Save battery**: Test on emulator most of the time
5. **Version control**: Never commit `release.keystore`
6. **Backup keystore**: Save `release.keystore` in safe place!
7. **Multiple devices**: Install on several to test variations
8. **Incremental build**: Only changed files rebuild faster

---

## 🚫 What NOT to Do

- ❌ Don't commit `release.keystore` to git
- ❌ Don't share your signing key password
- ❌ Don't edit `android/` folder directly (use Capacitor sync)
- ❌ Don't skip signing for Google Play
- ❌ Don't forget to rebuild web before sync
- ❌ Don't use old Android SDK versions

---

## ✨ Success Indicators

✅ You see "BUILD SUCCESSFUL" in console
✅ APK file appears in `build/outputs/apk/`
✅ App installs on device without errors
✅ App runs and shows your UI
✅ Firebase connects successfully
✅ Tailwind CSS styles work

---

## 🎯 Next Steps

1. **Haven't set up yet?** → Run `npm run android:setup`
2. **First build?** → Click Run in Android Studio
3. **Testing?** → Connect device and build debug APK
4. **Distributing?** → Build release APK and upload to Google Play

---

## 📞 When You Get Stuck

1. Check this page (Quick Reference)
2. Read QUICK_START_APK.md (5 min guide)
3. Read ANDROID_BUILD_GUIDE.md (detailed reference)
4. Check troubleshooting section in BUILD_WORKFLOW.md
5. See ANDROID_ENV_SETUP.md (if environment issues)

---

## 🎉 You're Ready!

Everything is configured. Just follow the commands above and you'll have your
app on Android in minutes!

**Print this page** 📄 for quick reference!

**Bookmark this** 🔖 for when you need help!

---

**Happy building! 🚀**

---

Last updated: 2026-03-13
WitherHost APK - Quick Reference Card
