# Data Flow

All data must flow through this chain. **Never bypass a layer.**

```
UI (Page / Widget)
       ↓
    Bloc
       ↓
   UseCase
       ↓
  Repository (contract)
       ↓
  RepositoryImpl
       ↓
  Datasource (local / remote)
       ↓
  Database / API
       ↓
  Native APIs (HealthKit, Google Fit, etc.)
```

## Layer responsibilities

| Layer | May call | Must NOT call |
|-------|----------|---------------|
| UI | Bloc | UseCase, Repository, Datasource, DB |
| Bloc | UseCase | Repository, Datasource, DB, API |
| UseCase | Repository | Datasource, DB, API |
| RepositoryImpl | Datasource | UI, Bloc |
| Datasource | Database / HTTP / Platform | UI, Bloc, UseCase |
| Database | Native storage | UI, Bloc |

## Examples

### Allowed

```dart
// Bloc → UseCase
final result = await _getDashboardUseCase(const NoParams());

// UseCase → Repository
return _repository.getDashboard();

// RepositoryImpl → Datasource
final models = await _localDatasource.getAll();

// Datasource → Isar
return _isar.dashboardModels.where().findAll();
```

### Forbidden

```dart
// ❌ UI calling repository directly
final data = await getIt<DashboardRepository>().getDashboard();

// ❌ Bloc calling datasource
final data = await _localDatasource.getAll();

// ❌ UseCase calling Isar
final items = await isar.dashboardModels.where().findAll();
```

## Error handling

Errors propagate **up** the chain:

```
Datasource throws → Repository catches → UseCase returns Either<Failure, T> → Bloc emits error state → UI shows message
```
