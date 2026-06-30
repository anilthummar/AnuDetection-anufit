# Step Counter - Pedometer

> **Repository:** `AnuDetection-anufit` (GitHub repo name)  
> **Published app:** Step Counter - Pedometer (Play Store / App Store)  
> **Codebase:** `anufit` (Dart package and project folder)

A production-grade Flutter step counter and health tracking app built with **Clean Architecture**, **BLoC** state management, and **Isar** local storage.

Offline-first, privacy-focused, and designed for reliable daily step counting with optional Health Connect / Apple Health sync.

| | |
|---|---|
| **GitHub repository** | `AnuDetection-anufit` |
| **Display name** | Step Counter - Pedometer |
| **Package / folder** | `anufit` |
| **Bundle ID** | `com.anudetection.anufit` |
| **Version** | 1.0.0+1 |
| **Flutter SDK** | ^3.11.4 |

---

## Screenshots

<p align="center">
  <img src="https://github.com/user-attachments/assets/3afc7c1d-5c15-4599-8760-529ca334a828" width="200" alt="Dashboard" />
  <img src="https://github.com/user-attachments/assets/aa006e8f-3833-4c94-95d9-4d9135efad92" width="200" alt="Statistics" />
  <img src="https://github.com/user-attachments/assets/57f6776b-d406-43a0-b8ac-0aee4084ae1d" width="200" alt="History" />
  <img src="https://github.com/user-attachments/assets/f423bf44-78cb-4eb3-be39-e413d78d9384" width="200" alt="Goals" />
</p>
<p align="center">
  <img src="https://github.com/user-attachments/assets/0034c5dc-c251-4cf3-91e0-c5fd3fb4ab77" width="200" alt="Profile" />
  <img src="https://github.com/user-attachments/assets/a9280f51-d355-46e1-b642-8ce6fda84970" width="200" alt="Health Sync" />
  <img src="https://github.com/user-attachments/assets/938ae39c-669b-45ff-974c-1fbb8ffc22a2" width="200" alt="Settings" />
  <img src="https://github.com/user-attachments/assets/9377584b-ddd4-4dca-83c6-8afcf12a01dc" width="200" alt="Onboarding" />
</p>

---

## App Overview

Step Counter - Pedometer helps users track daily steps, distance, calories, and walking time. Data is stored locally on the device. Users can optionally sync with **Health Connect** (Android) or **Apple Health** (iOS), export reports, back up data, and add home screen widgets.

Each feature is self-contained with clear separation between data, domain, and presentation layers.

---

## Features

| Feature | Description | Status |
|---------|-------------|--------|
| Dashboard | Live steps, progress ring, hourly chart, quick actions | ✅ Complete |
| Goals & Motivation | Daily step goals, streaks, achievements | ✅ Complete |
| History & Analytics | Activity timeline, trends | ✅ Complete |
| Statistics | Day / week / month / year / lifetime views | ✅ Complete |
| Reports | PDF, CSV, Excel export | ✅ Complete |
| Health Sync | Health Connect & Apple Health integration | ✅ Complete |
| Weight Tracking | Log and track weight over time | ✅ Complete |
| Water Tracker | Daily water intake goals | ✅ Complete |
| Smart Reminders | Goal and motivation notifications | ✅ Complete |
| User Profile | Profile, BMI, stride, units | ✅ Complete |
| Settings | Theme, language, units | ✅ Complete |
| Backup & Restore | Encrypted local backup | ✅ Complete |
| Home Widgets | Android & iOS widgets (steps, goal, water, weight) | ✅ Complete |
| Export Hub | Unified data export | ✅ Complete |
| Cloud Sync | Google Drive / iCloud interfaces | 🔶 UI only (coming soon) |
| Security | Encrypted backups, secure storage | ✅ Complete |
| Privacy Policy | In-app HTML policy viewer | ✅ Complete |
| Localization | English, Hindi, Gujarati (partial) | 🔶 In progress |

---

## Architecture

The project follows **Clean Architecture**:

```
Presentation  →  Domain  ←  Data
   (BLoC)      (Use Cases)   (Repository / Isar / Native)
```

| Layer | Responsibility |
|-------|----------------|
| **Domain** | Entities, repository contracts, use cases (pure Dart) |
| **Data** | Repository implementations, datasources, Isar models, Pigeon APIs |
| **Presentation** | BLoC, pages, widgets |

See [docs/architecture/](docs/architecture/) for diagrams and decisions.

### Feature development workflow

```
Requirement → Architecture → Folder Structure → Entities → Database
    → Repository → UseCases → Bloc → UI → Testing
```

Step-by-step checklists: [docs/architecture/development-workflow.md](docs/architecture/development-workflow.md)

---

## Folder Structure

```
lib/
├── app/                  # Bootstrap, router, theme, preferences
├── core/                   # DI, database, logger, services, engines
├── features/               # Feature modules (clean architecture each)
│   └── dashboard/
│       ├── data/
│       ├── domain/
│       └── presentation/
├── shared/                 # Design system, cross-feature widgets
├── l10n/                   # Localization (ARB files)
└── main.dart

assets/
├── images/ icons/ animations/ lottie/ svg/
├── legal/                  # Privacy policy HTML
└── json/

android/                    # Kotlin step counter, widgets, Health Connect
ios/                        # HealthKit, widgets
docs/                       # Architecture, design, release docs
scripts/                    # Build, test, analyze scripts
```

---

## Setup

### Prerequisites

- Flutter SDK `^3.11.4`
- Dart SDK `^3.11.4`
- Xcode 15+ (iOS, deployment target 14.0+)
- Android Studio (Android, minSdk 26)

### Install

```bash
git clone <repo-url>
cd anufit
flutter pub get
dart run build_runner build
```

### Environment

Configure environment files at the project root:

| File | Environment |
|------|-------------|
| `.env.dev` | Development |
| `.env.staging` | Staging |
| `.env.production` | Production |

Replace placeholder `API_BASE_URL` values before connecting to real backends. The app is **offline-first** — no backend is required for core step tracking.

### Android release signing

Create `android/key.properties` before publishing to Google Play. See [docs/release/android_signing.md](docs/release/android_signing.md).

---

## Development

### Run the app

```bash
flutter run
# or with environment:
flutter run --dart-define=ENV=dev
```

VS Code launch configs are available under **Step Counter - Pedometer** in `.vscode/launch.json`.

### Scripts

| Script | Purpose |
|--------|---------|
| `./scripts/analyze.sh` | Static analysis |
| `./scripts/test.sh` | Unit & widget tests |
| `./scripts/test.sh --coverage` | Tests with coverage |
| `./scripts/gen.sh` | `build_runner` code generation |
| `./scripts/build.sh dev apk` | Release APK |
| `./scripts/clean.sh` | Clean build artifacts |

### Common commands

```bash
flutter analyze
flutter test
flutter build apk --release
flutter build appbundle --release
flutter build ios --release
```

### Adding a new feature

1. Scaffold `lib/features/<name>/` following an existing feature
2. Build bottom-up: Entities → Database → Repository → UseCases → Bloc → UI
3. Register DI via `@injectable` and run `dart run build_runner build`
4. Add tests under `test/features/<name>/`
5. Branch from `develop`: `git checkout -b feature/<name> develop`

---

## Branch Strategy

```
main          ← production-ready releases
develop       ← integration branch
feature/*     ← short-lived feature branches
```

1. Branch from `develop`
2. Implement and open PR into `develop`
3. After QA, merge `develop` → `main` for release

---

## Tech Stack

| Area | Technology |
|------|------------|
| State management | `flutter_bloc`, `equatable` |
| DI | `get_it`, `injectable` |
| Routing | `go_router` |
| Database | `isar_community` |
| Health | `health` (Health Connect / HealthKit) |
| Native steps | Pigeon + Android `SensorManager` + foreground service |
| Charts | `fl_chart` |
| Widgets | `home_widget` |
| Notifications | `flutter_local_notifications` |
| Security | `flutter_secure_storage`, `encrypt` |
| i18n | `flutter_localizations`, ARB files |

---

## Permissions

| Permission | Android | iOS | Purpose |
|------------|---------|-----|---------|
| Activity recognition | ✅ | Motion & Fitness | Step counting |
| Notifications | ✅ | ✅ | Reminders |
| Health Connect / HealthKit | ✅ | ✅ | Optional health sync |
| Foreground service | ✅ | — | Background step tracking |

Permissions are requested during onboarding and re-checked when the app resumes if revoked in system settings.

---

## Roadmap

### Completed

- [x] Foundation — DI, routing, theme, Isar
- [x] Onboarding & permissions flow
- [x] Native step counter (Pigeon, sensors, baseline, midnight reset)
- [x] Dashboard with live updates
- [x] Goals, achievements, activity timeline
- [x] History, statistics, reports
- [x] Health Connect & Apple Health
- [x] Weight, water, reminders, profile, settings
- [x] Backup, widgets, export, security, privacy policy
- [x] Bottom navigation shell

### Planned (AnuDetection vision)

- [ ] AI walking coach with personalized daily goals
- [ ] Indoor / outdoor activity detection
- [ ] Automatic walking, running, and cycling recognition
- [ ] Route tracking with GPS (optional)
- [ ] Friends, challenges, and leaderboards
- [ ] Wear OS & Apple Watch companion apps
- [ ] Voice assistant integration
- [ ] Dynamic Island live activity (iOS)
- [ ] Full Hindi & Gujarati localization
- [ ] Google Drive & iCloud cloud sync

---

## Documentation

| Path | Contents |
|------|----------|
| [docs/architecture/](docs/architecture/) | Architecture decisions & data flow |
| [docs/design/figma/](docs/design/figma/) | UI/UX specs & design tokens |
| [docs/release/](docs/release/) | Privacy policy, signing, store assets |
| [assets/legal/privacy_policy.html](assets/legal/privacy_policy.html) | Store-ready privacy policy |

---

## Coding Standards

Enforced via `analysis_options.yaml` and `.cursor/rules/`:

- Strict analyzer mode (`strict-casts`, `strict-inference`, `strict-raw-types`)
- `avoid_print` — use `AppLogger`
- `prefer_const` / `prefer_final`
- `always_use_package_imports`

---

## License

Private — not for publication.
