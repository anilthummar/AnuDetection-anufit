# Anufit

A Flutter health and fitness application built with Clean Architecture, BLoC state management, and Isar local storage.

## App Overview

Anufit helps users track fitness activity, view health insights, and sync data from device health platforms. The app is structured for scalability — each feature is self-contained with clear separation between data, domain, and presentation layers.

## Features

| Feature | Branch | Status |
|---------|--------|--------|
| Dashboard | `feature/dashboard` | Planned |
| History | `feature/history` | Planned |
| Settings | `feature/settings` | Planned |
| Health Sync | `feature/health_sync` | Planned |

## Architecture

The project follows **Clean Architecture**:

```
Presentation  →  Domain  ←  Data
   (BLoC)      (Use Cases)   (Repository / Isar / API)
```

- **Domain** — pure Dart: entities, repository contracts, use cases
- **Data** — repository implementations, datasources, models (Isar, API)
- **Presentation** — BLoC, pages, widgets

See [docs/architecture/](docs/architecture/) for detailed diagrams and decisions.

### Feature development workflow

Every feature follows the same sequence:

```
Requirement → Architecture → Folder Structure → Entities → Database
    → Repository → UseCases → Bloc → UI → Testing
```

See [docs/architecture/development-workflow.md](docs/architecture/development-workflow.md) for step-by-step checklists.

## Folder Structure

```
lib/
├── app/                  # App shell: bootstrap, router, theme, config
├── core/                 # Shared infrastructure (DI, network, logger, etc.)
├── features/             # Feature modules (clean architecture per feature)
│   └── dashboard/
│       ├── data/
│       ├── domain/
│       ├── presentation/
│       └── bindings/
├── shared/               # Cross-feature widgets, models, helpers
├── generated/            # Code-gen output
└── main.dart

assets/
├── images/ icons/ animations/ fonts/
├── lottie/ svg/ translations/ json/

docs/                     # Project documentation
scripts/                  # Build, test, and codegen scripts
```

## Setup

### Prerequisites

- Flutter SDK `^3.11.4`
- Dart SDK `^3.11.4`
- Xcode (iOS) / Android Studio (Android)

### Install

```bash
git clone <repo-url>
cd anufit
flutter pub get
```

### Environment

Copy and configure environment files at the project root:

| File | Environment |
|------|-------------|
| `.env.dev` | Development |
| `.env.staging` | Staging |
| `.env.production` | Production |

Replace placeholder `API_BASE_URL` values before running against real backends.

## Development Guide

### Run the app

```bash
flutter run --dart-define=ENV=dev
```

### Common scripts

| Script | Purpose |
|--------|---------|
| `./scripts/analyze.sh` | Run static analysis |
| `./scripts/test.sh` | Run unit & widget tests |
| `./scripts/test.sh --coverage` | Run tests with coverage |
| `./scripts/gen.sh` | Run `build_runner` code generation |
| `./scripts/build.sh dev apk` | Build release APK (dev flavor) |
| `./scripts/clean.sh` | Clean build artifacts |

### Adding a new feature

Follow the [development workflow](docs/architecture/development-workflow.md):

1. Write requirement & confirm Figma is **Ready**
2. Scaffold `lib/features/<name>/` from the dashboard template
3. Build bottom-up: Entities → Database → Repository → UseCases → Bloc → UI
4. Add tests and register DI in `bindings/`
5. Branch from `develop`: `git checkout -b feature/<name> develop`

## Branch Strategy

```
main          ← production-ready releases
develop       ← integration branch
feature/*     ← short-lived feature branches
```

### Workflow

1. Branch from `develop`: `git checkout -b feature/dashboard develop`
2. Implement and open PR into `develop`
3. After QA, merge `develop` → `main` for release

### Example branches

- `feature/dashboard`
- `feature/history`
- `feature/settings`
- `feature/health_sync`

## Coding Standards

Enforced via `analysis_options.yaml` and `.cursor/rules/`:

- Strict analyzer mode (`strict-casts`, `strict-inference`, `strict-raw-types`)
- `avoid_print` — use logger
- `avoid_dynamic_calls` / `avoid_annotating_with_dynamic`
- `prefer_const` / `prefer_final`
- `always_use_package_imports`

Cursor rules provide additional guidance for architecture, BLoC, database, UI, testing, and native code.

## Packages (Staged Rollout)

Packages are added incrementally — **not all installed upfront**.

### Stage 1 — Foundation ✅

| Package | Purpose | Status |
|---------|---------|--------|
| `flutter_bloc` | State management | Installed |
| `equatable` | Value equality for states/events | Installed |
| `get_it` | Service locator | Installed |
| `injectable` | DI code generation | Installed |
| `go_router` | Declarative routing | Installed |
| `flutter_dotenv` | Environment file loading | Installed |
| `logger` | Structured logging | Installed |

### Stage 2 — Database

| Package | Purpose |
|---------|---------|
| `isar` | Local NoSQL database |
| `isar_flutter_libs` | Isar Flutter bindings |

### Stage 3 — Code Generation

| Package | Purpose |
|---------|---------|
| `freezed` / `freezed_annotation` | Immutable models & unions |
| `json_annotation` / `json_serializable` | JSON serialization |
| `build_runner` | Code generation runner |
| `injectable_generator` | DI codegen |
| `isar_generator` | Isar schema codegen |

### Stage 4 — Utilities

| Package | Purpose |
|---------|---------|
| `intl` | Internationalization |
| `logger` | Structured logging |
| `permission_handler` | Runtime permissions |
| `package_info_plus` | App version info |
| `device_info_plus` | Device metadata |
| `path_provider` | File system paths |
| `shared_preferences` | Key-value storage |

## Roadmap

- [x] **Phase 1** — Foundation packages, DI, routing, theme
- [ ] **Phase 2** — Isar setup, core database layer
- [ ] **Phase 3** — Dashboard feature (MVP)
- [ ] **Phase 4** — History & settings features
- [ ] **Phase 5** — Health sync (Apple Health / Google Fit)
- [ ] **Phase 6** — Localization, analytics, CI/CD

## Documentation

| Path | Contents |
|------|----------|
| [docs/architecture/](docs/architecture/) | Architecture decisions & diagrams |
| [docs/api/](docs/api/) | API contracts & endpoints |
| [docs/database/](docs/database/) | Isar schemas & migrations |
| [docs/design/](docs/design/) | UI/UX specs & design tokens |
| [docs/features/](docs/features/) | Per-feature specs |
| [docs/assets/](docs/assets/) | Asset naming & usage guide |

## License

Private — not for publication.
