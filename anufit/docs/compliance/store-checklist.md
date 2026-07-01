# Store release checklist

Use this before each Play Store / App Store milestone.  
App: **Step Counter - Pedometer** (`com.anudetection.anufit`)

Related docs:

- [Privacy policy hosting](./privacy-policy-hosting.md)
- [Android signing](../release/android_signing.md)
- [Store assets](../release/store_assets.md)

---

## Status legend

| Symbol | Meaning |
|--------|---------|
| ✅ | Implemented in codebase |
| ⚠️ | Partial — action required |
| ❌ | Not done — blocking for that milestone |

---

## Before internal testing

### Code & build

- [ ] ✅ Release uses `ENV=production` (`./scripts/build.sh production appbundle`)
- [ ] ✅ Only `.env.production` bundled in release APK/AAB
- [ ] ⚠️ `android/key.properties` created from `key.properties.example`
- [ ] ✅ Release build fails without release keystore (no debug signing fallback)
- [ ] ✅ Health Connect permissions trimmed (steps, distance, calories only)
- [ ] ✅ Health disclaimer shown before Health Connect / Apple Health connect
- [ ] ✅ Battery optimization screen (Android)
- [ ] ✅ iOS `Runner.entitlements` (HealthKit) + `PrivacyInfo.xcprivacy`

### Privacy & legal

- [ ] ⚠️ Update `lib/core/constants/legal_config.dart` with real email + URL
- [ ] ❌ Host privacy policy at public HTTPS URL ([guide](./privacy-policy-hosting.md))
- [ ] ✅ In-app privacy policy at Settings → Release Info → Privacy Policy
- [ ] ⚠️ Verify hosted URL matches `LegalConfig.privacyPolicyUrl`

### Permissions UX (manual test)

- [ ] Activity Recognition requested only when user taps Allow
- [ ] Health Connect: disclaimer → permission UI → Connect succeeds
- [ ] Revoke permission in system Settings → app redirects to Permissions on resume
- [ ] Notifications optional — app works if denied
- [ ] Foreground service notification visible only while tracking

### Play Console (draft)

- [ ] Create app in Play Console (internal testing track)
- [ ] Upload AAB to internal testing
- [ ] Start Data Safety form (draft OK)
- [ ] Declare Health Connect app
- [ ] Declare foreground service type: **health**
- [ ] Declare Activity Recognition usage

### Apple (if testing iOS)

- [ ] ⚠️ Enable HealthKit capability in Apple Developer portal for bundle ID
- [ ] Upload build to TestFlight (internal)
- [ ] App Privacy questionnaire started (draft OK)

---

## Before closed testing

Complete **all internal testing** items, plus:

### Store listing

- [ ] App title: Step Counter - Pedometer
- [ ] Short description (80 chars) prepared
- [ ] Full description includes:
  - Offline-first, no account, no ads
  - Optional Health Connect / Apple Health
  - **Not a medical device** disclaimer
  - Estimates only (steps, distance, calories)
- [ ] Feature graphic (1024×500) — Play Store
- [ ] Phone screenshots (dashboard, goals, health sync, permissions)
- [ ] Content rating questionnaire (IARC) complete
- [ ] Category: Health & Fitness
- [ ] Target age: not child-directed (13+ recommended)

### Google Play declarations

- [ ] **Data Safety** form submitted (see answers below)
- [ ] **Health Connect** permissions match manifest (steps, distance, active calories)
- [ ] **Foreground service** declaration: step counting while user walks
- [ ] **BOOT_COMPLETED**: resume tracking user previously enabled
- [ ] **Sensitive permissions**: Activity Recognition justified

### Data Safety quick reference

| Data | Collected | Shared | Encrypted | User can delete | Purpose |
|------|-----------|--------|-----------|-----------------|---------|
| Steps / fitness | Yes (device) | No* | At rest on device | Yes | App functionality |
| Distance | Yes (estimate) | No* | At rest | Yes | App functionality |
| Calories | Yes (estimate) | No* | At rest | Yes | App functionality |
| Weight / height (profile) | Yes (optional user input) | No | At rest | Yes | App functionality |
| Location | **No** | No | — | — | — |
| Email / account | **No** | No | — | — | — |

\*Shared only when user authorizes Health Connect / Apple Health or uses share/export.

### Apple App Store

- [ ] Privacy Policy URL live (HTTPS)
- [ ] App Privacy nutrition labels match app behavior
- [ ] HealthKit usage strings in Info.plist reviewed
- [ ] No unnecessary background modes
- [ ] TestFlight external testers invited (optional)

### QA (14-day recommendation)

- [ ] Test on Android 13, 14, 15 with Health Connect installed
- [ ] Test on Android without Health Connect (skip flow works)
- [ ] Test battery optimization flow on Samsung / Xiaomi / Pixel
- [ ] Test iOS 16+ with Apple Health deny / allow
- [ ] No crashes on cold start, onboarding, health connect, settings
- [ ] `./scripts/analyze.sh` and `./scripts/test.sh` pass in CI

---

## Before production

Complete **all closed testing** items, plus:

### Final gates

- [ ] ❌ Privacy policy URL live and verified (`curl` returns 200)
- [ ] ❌ Support email monitored (`LegalConfig.supportEmail`)
- [ ] Closed testing completed without critical bugs (recommended 14+ days)
- [ ] Production signing key backed up securely
- [ ] Version code / build number incremented
- [ ] Release notes mention permission or policy changes if applicable

### Google Play production

- [ ] Data Safety form **published** and matches app
- [ ] Health Connect declaration **approved**
- [ ] FGS declaration **approved**
- [ ] Store listing **published** (not draft)
- [ ] Countries / pricing set
- [ ] App signing by Google Play enabled (upload key registered)

### Apple production

- [ ] App Review Information: demo steps if needed (no login required)
- [ ] HealthKit justification in review notes if asked
- [ ] Export compliance answered
- [ ] Age rating final
- [ ] Submit for App Review

### Post-launch

- [ ] Monitor Play pre-launch report / Vitals
- [ ] Monitor App Store Connect crashes
- [ ] Respond to policy or permission-related reviews within 48h

---

## Readiness scores (after compliance PR)

| Milestone | Score | Notes |
|-----------|-------|-------|
| Internal testing | **~75/100** | Blocked on hosted privacy URL + keystore |
| Closed testing | **~65/100** | + store assets + Data Safety |
| Production | **~60/100** | + live URL, QA period, console approvals |

### Remaining blockers for production

1. Host privacy policy at `LegalConfig.privacyPolicyUrl`
2. Configure `android/key.properties` for release AAB
3. Enable HealthKit in Apple Developer portal
4. Complete Play Data Safety + Health Connect forms
5. Finalize store listing with health disclaimers

---

## Quick commands

```bash
# Sync policy HTML for web hosting
./scripts/sync_privacy_policy.sh

# Verify hosted policy (after deploy)
curl -fsSL -o /dev/null -w "%{http_code}\n" https://anudetection.com/privacy

# Production Android bundle
./scripts/build.sh production appbundle

# Tests
./scripts/analyze.sh
./scripts/test.sh
```
