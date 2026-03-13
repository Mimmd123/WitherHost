# WitherHost Android App - Complete Development Guide

Welcome! This guide covers everything you need to build, test, and deploy your WitherHost app as an Android APK.

## 📚 Documentation

Start with the guide that matches your situation:

### 🎯 First Time Setup?
→ Read **`QUICK_START_APK.md`** (5 minutes to running app)

### 🖥️ Environment Issues?
→ Read **`ANDROID_ENV_SETUP.md`** (install Java, Android Studio, SDK)

### 📖 Full Details?
→ Read **`ANDROID_BUILD_GUIDE.md`** (complete reference)

---

## 🚀 The Fastest Way to Build

```bash
# 1. Run setup (installs everything)
chmod +x scripts/setup-android.sh
./scripts/setup-android.sh

# 2. Open in Android Studio
npm run cap:open

# 3. Click the green Run button (▶️)
# Done! App is now on your phone.
```

---

## 📋 What You Need

### Required
- ✅ Node.js 16+ (you have this)
- ✅ Java 11+ (need to install)
- ✅ Android Studio (need to install)
- ✅ Android SDK Platform 33 (installed with Studio)

### Optional
- 📱 Android phone connected via USB
- 📲 Or use Android Emulator

---

## 🔄 The Build Process

```
Your Next.js Code
        ↓
    npm build (creates /out)
        ↓
   Capacitor (wraps web in native)
        ↓
   Android Studio
        ↓
   Gradle (compiles Java/Kotlin)
        ↓
   APK (installable app)
```

---

## 🎮 Common Commands

### Development
```bash
npm run dev              # Start local dev server
npm run build            # Build Next.js for production
npm run cap:sync         # Update Android after web changes
npm run cap:open         # Open Android Studio
```

### Building APKs
```bash
npm run android:debug    # Build debug APK (fast)
npm run android:release  # Build release APK (for distribution)
npm run android:clean    # Clean build files
```

### Useful Utilities
```bash
adb devices              # List connected devices
adb logcat               # See app logs
adb install app.apk      # Install APK manually
```

---

## 📱 Running on Your Device

### Option 1: Android Studio (Easiest)
1. Open Android Studio
2. Connect phone via USB
3. Click green Run button (▶️)
4. Select your phone
5. Click OK

### Option 2: Command Line
```bash
adb install android/app/build/outputs/apk/debug/app-debug.apk
```

### Option 3: USB File Transfer
1. Build APK: `npm run android:debug`
2. Copy APK to phone
3. Open file manager on phone
4. Tap APK to install

---

## 🔐 Signing for Google Play

### Step 1: Create Keystore
```bash
keytool -genkey -v -keystore release.keystore \
  -keyalg RSA -keysize 2048 -validity 10000 \
  -alias witherhostkey
```

### Step 2: Configure Gradle
Edit `android/app/build.gradle`:

```gradle
signingConfigs {
    release {
        storeFile file('../release.keystore')
        storePassword 'YOUR_PASSWORD'
        keyAlias 'witherhostkey'
        keyPassword 'YOUR_PASSWORD'
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

### Step 3: Build
```bash
npm run android:release
```

---

## 🐛 Debugging

### Device Not Detected
```bash
# Check connection
adb devices

# Restart ADB
adb kill-server
adb start-server
adb devices
```

### Gradle Build Fails
```bash
# Clean and rebuild
npm run android:clean
npm run cap:sync
npm run android:debug
```

### Firebase Errors
- Get `google-services.json` from Firebase Console
- Replace `android/app/google-services.json`
- Rebuild

### App Crashes
```bash
# View logs
adb logcat | grep "WitherHost"
```

---

## 📊 Project Architecture

```
project/
├── src/                           # Next.js React code
│   ├── app/
│   ├── components/
│   └── lib/
├── out/                           # Built Next.js (→ Android webDir)
├── android/                       # ⚡ Android native project
│   ├── app/
│   │   ├── src/main/
│   │   ├── build.gradle
│   │   └── google-services.json
│   ├── gradle/
│   └── build.gradle
├── capacitor.config.ts            # Capacitor config (bridges web ↔ native)
├── next.config.js                 # Next.js config
├── tailwind.config.js             # Styling
├── package.json                   # Dependencies
├── QUICK_START_APK.md             # Start here ⭐
├── ANDROID_ENV_SETUP.md           # Environment setup
├── ANDROID_BUILD_GUIDE.md         # Full reference
└── README_ANDROID.md              # This file
```

---

## 🔧 Configuration

Your app is configured for:
- **App ID**: `com.armmc.app`
- **App Name**: `WitherHost`
- **Min Android Version**: 7.0 (API 24)
- **Target Android Version**: 13 (API 33)
- **Package Manager**: npm
- **Build System**: Gradle
- **Database**: Firebase
- **UI Framework**: React + Tailwind CSS

---

## 🌐 Capacitor Plugins

Your app includes:
- `@capacitor/core` - Base Capacitor framework
- `@capacitor/android` - Android native bridge
- `@capacitor/app` - App lifecycle
- `@capacitor/status-bar` - Status bar control
- `@capacitor/keyboard` - Keyboard handling

---

## 📲 Google Play Store Submission

1. **Build Release APK**
   ```bash
   npm run android:release
   ```

2. **Create Google Play Developer Account**
   - Go to https://play.google.com/console
   - Pay $25 one-time fee
   - Create new app

3. **Upload APK**
   - Go to Release → Production
   - Upload your signed APK
   - Fill in store listing (screenshots, description, etc.)

4. **Review & Publish**
   - Google reviews (24-72 hours)
   - App goes live!

---

## 🚨 Common Issues & Fixes

| Issue | Solution |
|-------|----------|
| SDK not found | Run: `npm run android:setup` |
| Device not detected | Enable USB Debugging on phone |
| Gradle build fails | Run: `npm run android:clean` |
| Firebase errors | Update `google-services.json` |
| App crashes | Check logs: `adb logcat` |
| Can't find keytool | Use Android Studio's built-in tool |

---

## 📚 Learning Resources

- [Capacitor Documentation](https://capacitorjs.com/docs)
- [Android Developer Guide](https://developer.android.com/docs)
- [Google Play Console Help](https://support.google.com/googleplay/android-developer)
- [Firebase Setup](https://firebase.google.com/docs/android/setup)
- [Next.js Guide](https://nextjs.org/docs)

---

## 🎯 Next Steps

1. ✅ **Setup**: Follow `QUICK_START_APK.md`
2. ✅ **Build**: Run `npm run android:setup`
3. ✅ **Test**: Run on device/emulator
4. ✅ **Deploy**: Build release APK
5. ✅ **Publish**: Submit to Google Play Store

---

## 💡 Tips & Tricks

### Speed Up Builds
- Disable animations on emulator
- Use incremental builds
- Keep emulator always open

### Better Debugging
```bash
# Follow live logs
adb logcat | grep -i "withering\|firebase\|capacitor"

# Record screen
adb shell screenrecord /sdcard/recording.mp4
adb pull /sdcard/recording.mp4
```

### App Size Optimization
- Enable ProGuard (already configured)
- Compress images
- Use code splitting

---

## ❓ FAQ

**Q: Can I run on iOS too?**
A: Yes, use `npx cap add ios` but requires macOS and Xcode.

**Q: How do I update the app after changes?**
A: `npm run build && npm run cap:sync`, then rebuild in Android Studio.

**Q: Can I test without a physical device?**
A: Yes, use Android Emulator (included with Android Studio).

**Q: How long does building take?**
A: First build: 3-5 minutes. Subsequent: 1-2 minutes.

**Q: Where are APK files saved?**
A: `android/app/build/outputs/apk/`

---

## 🆘 Need Help?

1. Check the **Troubleshooting** section above
2. Read `ANDROID_BUILD_GUIDE.md` for detailed info
3. Check [Capacitor Docs](https://capacitorjs.com/docs)
4. Post issue on [GitHub](https://github.com/Mimmd123/WitherHost)

---

## 📝 Version Info

- **Capacitor**: 5.7.0
- **Android SDK**: API 33 (Android 13)
- **Min SDK**: API 24 (Android 7.0)
- **Java**: 11 or higher
- **Node.js**: 16 or higher
- **Next.js**: 14.2.0

---

**Happy building! 🚀 You've got this!**

For quick start, see: **`QUICK_START_APK.md`**
