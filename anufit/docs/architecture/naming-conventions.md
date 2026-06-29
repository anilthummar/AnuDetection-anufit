# Naming Conventions

Every feature follows the same predictable naming pattern.

## Pattern

| Layer | Pattern | Example |
|-------|---------|---------|
| Page | `<Feature>Page` | `DashboardPage` |
| Bloc | `<Feature>Bloc` | `DashboardBloc` |
| Event | `<Feature>Event` | `DashboardEvent` |
| State | `<Feature>State` | `DashboardState` |
| Repository (contract) | `<Feature>Repository` | `DashboardRepository` |
| Repository (impl) | `<Feature>RepositoryImpl` | `DashboardRepositoryImpl` |
| Local datasource | `<Feature>LocalDatasource` | `DashboardLocalDatasource` |
| Remote datasource | `<Feature>RemoteDatasource` | `DashboardRemoteDatasource` |
| Use case | `<Verb><Feature>UseCase` | `GetDashboardUseCase` |
| Entity | `<Feature>Entity` | `DashboardEntity` |
| Model | `<Feature>Model` | `DashboardModel` |

## File names

Use `snake_case` matching the primary class:

| Class | File |
|-------|------|
| `DashboardPage` | `dashboard_page.dart` |
| `DashboardBloc` | `dashboard_bloc.dart` |
| `GetDashboardUseCase` | `get_dashboard_use_case.dart` |

## Events & states

Use descriptive subclass names:

```dart
// Events
class LoadDashboard extends DashboardEvent {}
class RefreshDashboard extends DashboardEvent {}

// States
class DashboardInitial extends DashboardState {}
class DashboardLoading extends DashboardState {}
class DashboardLoaded extends DashboardState {}
class DashboardError extends DashboardState {}
```

## Rules

- Feature prefix is always **PascalCase** matching the feature folder name.
- Use cases start with a **verb** (`Get`, `Save`, `Delete`, `Sync`).
- One primary class per file.
- No abbreviations (`Db`, `Repo`) in class names.
