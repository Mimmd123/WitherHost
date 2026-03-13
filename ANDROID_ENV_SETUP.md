# Android Development Environment Setup

This guide helps you set up your machine for building WitherHost as an Android APK.

## Prerequisites Checklist

- [ ] Java Development Kit (JDK) 11+
- [ ] Android Studio
- [ ] Android SDK Platform 33
- [ ] Android Build Tools 33.0.0
- [ ] Node.js 16+

---

## Installation Steps

### 1. Install Java Development Kit (JDK)

**Check if you have Java installed:**
```bash
java -version
javac -version
```

**If not installed:**

**macOS:**
```bash
# Using Homebrew
brew install java
```

**Windows:**
- Download from: https://www.oracle.com/java/technologies/downloads/
- Install JDK 11 or higher
- Add to PATH if needed

**Linux:**
```bash
# Ubuntu/Debian
sudo apt-get install openjdk-11-jdk

# Fedora
sudo dnf install java-11-openjdk
```

### 2. Install Android Studio

1. Download from: https://developer.android.com/studio
2. Run the installer
3. Complete the setup wizard
4. During setup, select:
   - ✅ Android SDK
   - ✅ Android SDK Platform
   - ✅ Android Build-Tools

### 3. Install Required Android SDK Components

Open Android Studio and go to **Tools** → **SDK Manager**

Install these:
- [ ] **SDK Platforms** → Android 13 (API Level 33)
- [ ] **SDK Tools** → Android SDK Build-Tools 33.0.0
- [ ] **SDK Tools** → Android Emulator (optional)
- [ ] **SDK Tools** → Android SDK Platform-Tools

### 4. Set Up Android SDK Path

**macOS/Linux:**

Add to `~/.zshrc` or `~/.bash_profile`:
```bash
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
```

Then reload:
```bash
source ~/.zshrc
```

**Windows:**

1. Open System Environment Variables:
   - Right-click **This PC** → **Properties**
   - Click **Advanced system settings**
   - Click **Environment Variables**

2. Add new variable:
   - Variable name: `ANDROID_HOME`
   - Variable value: `C:\Users\YourUsername\AppData\Local\Android\sdk`

3. Add to PATH:
   - Select `Path` → Click **Edit**
   - Add:
     - `%ANDROID_HOME%\emulator`
     - `%ANDROID_HOME%\tools`
     - `%ANDROID_HOME%\tools\bin`
     - `%ANDROID_HOME%\platform-tools`

### 5. Verify Installation

```bash
# Check Android SDK
adb version

# Check Java
java -version

# Check Android tools
sdkmanager --list
```

All should show version info without errors.

### 6. Connect Android Device (Optional)

**Enable Developer Mode:**
1. Open **Settings** on your Android device
2. Go to **About Phone**
3. Tap **Build Number** 7 times
4. Go back to **Settings** → **Developer Options**
5. Enable **USB Debugging**

**Connect via USB:**
```bash
# Verify device is recognized
adb devices

# You should see your device listed
```

---

## Android Emulator Setup (Alternative)

If you don't have a physical device:

1. In Android Studio: **Tools** → **Device Manager**
2. Click **Create Device**
3. Select device (e.g., "Pixel 5")
4. Select API Level 33
5. Click **Finish**
6. Start the emulator

---

## Troubleshooting

### "android-sdk not found"
Make sure `ANDROID_HOME` is set correctly:
```bash
echo $ANDROID_HOME
```

Should show your Android SDK path, not be empty.

### "Build-Tools not found"
Install via SDK Manager in Android Studio, not command line.

### "Device not recognized"
```bash
# Restart adb
adb kill-server
adb start-server
adb devices
```

### Java version incompatible
Use JDK 11+:
```bash
java -version
# Should show: version "11" or higher
```

---

## Verify Everything Works

Once installed, run:
```bash
npm run android:setup
```

This will test:
- ✅ Node.js
- ✅ Android SDK
- ✅ Gradle
- ✅ Java

If all pass, you're ready to build! 🎉

---

## Next Steps

1. ✅ Complete all installations above
2. ✅ Verify with `npm run android:setup`
3. ✅ See `QUICK_START_APK.md` to build your first APK

---

## Resources

- [Android Studio Setup](https://developer.android.com/studio/install)
- [Android SDK Setup](https://developer.android.com/studio/command-line/sdkmanager)
- [Java Development Kit](https://www.oracle.com/java/technologies/downloads/)
- [Capacitor Android Setup](https://capacitorjs.com/docs/android)
