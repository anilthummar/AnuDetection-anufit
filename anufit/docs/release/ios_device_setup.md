# Run on a physical iPhone

## Quick fix (most common)

The app fails when Xcode uses a **team ID that is not signed in on your Mac**.

### 1. Open the project in Xcode

```bash
open ios/Runner.xcworkspace
```

### 2. Add your Apple ID

1. **Xcode → Settings → Accounts**
2. Click **+** → **Apple ID** → sign in with your Apple ID
3. Wait until your **Team** appears (Personal Team or paid Developer Program team)

### 3. Configure signing for Runner

1. In the left sidebar, select **Runner** (blue app icon)
2. Select the **Runner** target → **Signing & Capabilities**
3. Check **Automatically manage signing**
4. **Team:** choose *your* team (not a teammate’s team ID)
5. If bundle ID `com.anudetection.anufit` is taken, change it to something unique, e.g.  
   `com.yourname.anufit`  
   (must match in Apple Developer portal if using a paid account)

### 4. Enable HealthKit (paid Apple Developer Program only)

This app uses **HealthKit** for Apple Health sync.

1. In **Signing & Capabilities**, click **+ Capability** → **HealthKit**
2. In [Apple Developer](https://developer.apple.com/account/resources/identifiers/list), open your App ID and enable **HealthKit**

> **Free “Personal Team”** accounts often **cannot** use HealthKit.  
> To run on device without HealthKit, temporarily remove `ios/Runner/Runner.entitlements`  
> from **Code Signing Entitlements** in Build Settings, or use the iOS Simulator.

### 5. Trust the Mac on iPhone

1. Connect iPhone with USB (recommended for first run)
2. Unlock the phone → tap **Trust** when prompted
3. On iPhone: **Settings → Privacy & Security → Developer Mode → On** (iOS 16+), then restart

### 6. Run from terminal

```bash
# List devices
flutter devices

# Run on your iPhone (use the device id from flutter devices)
flutter run -d <device-id> --dart-define=ENV=dev
```

Or in Xcode: select your iPhone as destination → **Run (▶)**.

---

## Errors and fixes

| Error | Fix |
|-------|-----|
| `No Account for Team "…"` | Wrong team in Xcode — pick your team in Signing & Capabilities |
| `No profiles for 'com.anudetection.anufit'` | Enable automatic signing + select your team, or change bundle ID |
| `Browsing on the local area network` / code -27 | Use USB cable, unlock device, enable Developer Mode |
| HealthKit / entitlement errors | Paid developer account + HealthKit on App ID, or disable entitlements for local dev |
| App installs but won’t open | **Settings → General → VPN & Device Management** → trust developer |

---

## Simulator (no signing required)

```bash
open -a Simulator
flutter run -d ios --dart-define=ENV=dev
```

Apple Health sync is limited on Simulator; use a real device for full health testing.
