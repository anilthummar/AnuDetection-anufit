# Cursor Development Workflow

For every feature, follow this sequence. It ensures Cursor generates clean, maintainable code.

```
Requirement
      ↓
Architecture
      ↓
Folder Structure
      ↓
Entities
      ↓
Database
      ↓
Repository
      ↓
UseCases
      ↓
Bloc
      ↓
UI
      ↓
Testing
```

---

## 1. Requirement

**Goal:** Lock scope before writing code.

### Checklist

- [ ] Feature spec exists in `docs/features/<name>.md`
- [ ] Figma page is marked **Ready** (`docs/design/figma/<name>.md`)
- [ ] Acceptance criteria are defined
- [ ] Branch created: `feature/<name>` from `develop`

### Output

A clear list of user stories, screens, and data needs.

---

## 2. Architecture

**Goal:** Plan layers and data flow before scaffolding.

### Checklist

- [ ] Feature fits the standard folder layout
- [ ] Data flow documented (UI → Bloc → UseCase → Repository → Datasource → DB)
- [ ] Naming follows [naming-conventions.md](naming-conventions.md)
- [ ] External dependencies identified (API, HealthKit, permissions)

### Output

Brief architecture note in the feature spec or PR description.

---

## 3. Folder Structure

**Goal:** Scaffold the feature module.

### Checklist

- [ ] Copy structure from `lib/features/dashboard/`
- [ ] Create `data/`, `domain/`, `presentation/`, `bindings/`
- [ ] Add `.gitkeep` or placeholder files only — no logic yet

### Output

```
lib/features/<name>/
├── bindings/
├── data/
│   ├── datasource/
│   ├── models/
│   └── repository/
├── domain/
│   ├── entities/
│   ├── repository/
│   └── usecases/
└── presentation/
    ├── bloc/
    ├── pages/
    └── widgets/
```

---

## 4. Entities

**Goal:** Define pure domain objects.

### Checklist

- [ ] One entity per core concept (`<Feature>Entity`)
- [ ] No Flutter, Isar, or JSON imports
- [ ] Immutable fields, explicit types

### Output

`domain/entities/<feature>_entity.dart`

---

## 5. Database

**Goal:** Persist and retrieve data.

### Checklist

- [ ] Isar model in `data/models/<feature>_model.dart`
- [ ] Model ↔ Entity mapping methods
- [ ] Local datasource in `data/datasource/<feature>_local_datasource.dart`
- [ ] Remote datasource if API needed
- [ ] Run `./scripts/gen.sh` after schema changes

### Output

Datasource(s) that own all DB / API access.

---

## 6. Repository

**Goal:** Abstract data sources behind a contract.

### Checklist

- [ ] Abstract class in `domain/repository/<feature>_repository.dart`
- [ ] Implementation in `data/repository/<feature>_repository_impl.dart`
- [ ] Returns entities, not models
- [ ] Maps failures to `Failure` types from `lib/core/errors/`

### Output

Repository contract + impl wired to datasource(s).

---

## 7. UseCases

**Goal:** Encapsulate single business actions.

### Checklist

- [ ] One use case per action (`Get<Feature>UseCase`, `Save<Feature>UseCase`)
- [ ] Extends `UseCase<T, Params>` from `lib/core/usecase/`
- [ ] Calls repository only — never datasource or DB
- [ ] Returns `Either<Failure, T>` or typed result

### Output

`domain/usecases/<verb>_<feature>_use_case.dart`

---

## 8. Bloc

**Goal:** Manage presentation state.

### Checklist

- [ ] `<Feature>Event`, `<Feature>State`, `<Feature>Bloc`
- [ ] States extend `Equatable` (once package is added)
- [ ] Bloc calls use cases only
- [ ] Loading → success / error state pattern

### Output

`presentation/bloc/<feature>_bloc.dart` (+ event, state files)

---

## 9. UI

**Goal:** Build the screen from Figma using theme tokens.

### Checklist

- [ ] Figma page status is **Ready**
- [ ] `<Feature>Page` in `presentation/pages/`
- [ ] Widgets in `presentation/widgets/`
- [ ] Colors from `AppColors` only — no hardcoded values
- [ ] Typography from `Theme.of(context).textTheme`
- [ ] Layout via `ResponsiveBuilder` / `context.responsive()` — no hardcoded widths
- [ ] `BlocBuilder` / `BlocListener` — no direct use case calls

### Output

Working screen connected to bloc.

---

## 10. Testing

**Goal:** Verify behavior at each layer.

### Checklist

- [ ] Unit tests for use cases
- [ ] `bloc_test` for bloc state transitions
- [ ] Widget test for page rendering
- [ ] `./scripts/test.sh` passes
- [ ] `./scripts/analyze.sh` passes

### Output

```
test/features/<name>/
├── domain/usecases/
├── presentation/bloc/
└── presentation/pages/
```

---

## DI Registration

After steps 6–8, register in `features/<name>/bindings/`:

- Datasource(s)
- Repository
- Use case(s)
- Bloc

---

## Quick reference

| Step | Layer | Key file |
|------|-------|----------|
| 4 | Domain | `<Feature>Entity` |
| 5 | Data | `<Feature>LocalDatasource` |
| 6 | Data / Domain | `<Feature>RepositoryImpl` |
| 7 | Domain | `Get<Feature>UseCase` |
| 8 | Presentation | `<Feature>Bloc` |
| 9 | Presentation | `<Feature>Page` |
| 10 | Test | `test/features/<name>/` |

## Related docs

- [Data flow](data-flow.md)
- [Naming conventions](naming-conventions.md)
- [Figma pages](../design/figma/README.md)
