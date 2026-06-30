import 'package:injectable/injectable.dart';

import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';
import 'package:anufit/features/health/domain/repository/health_repository.dart';

@injectable
class RequestHealthPermissionsUseCase {
  const RequestHealthPermissionsUseCase(this._repository);
  final HealthRepository _repository;
  Future<HealthPermissionEntity> call(NoParams _) => _repository.requestPermissions();
}

@injectable
class CheckHealthPermissionsUseCase {
  const CheckHealthPermissionsUseCase(this._repository);
  final HealthRepository _repository;
  Future<HealthPermissionEntity> call(NoParams _) => _repository.checkPermissions();
}

@injectable
class ReadTodayHealthUseCase {
  const ReadTodayHealthUseCase(this._repository);
  final HealthRepository _repository;
  Future<HealthDailyRecord?> call(NoParams _) => _repository.readTodayHealth();
}

@injectable
class SyncHealthDataUseCase {
  const SyncHealthDataUseCase(this._repository);
  final HealthRepository _repository;
  Future<SyncResult> call(SyncHealthParams params) =>
      _repository.syncHealthData(initial: params.initial);
}

class SyncHealthParams {
  const SyncHealthParams({this.initial = false});
  final bool initial;
}

@injectable
class ConnectHealthUseCase {
  const ConnectHealthUseCase(this._repository);
  final HealthRepository _repository;
  Future<bool> call(NoParams _) => _repository.connectHealth();
}

@injectable
class DisconnectHealthUseCase {
  const DisconnectHealthUseCase(this._repository);
  final HealthRepository _repository;
  Future<void> call(NoParams _) => _repository.disconnectHealth();
}

@injectable
class GetHealthSyncStatusUseCase {
  const GetHealthSyncStatusUseCase(this._repository);
  final HealthRepository _repository;
  Future<HealthSyncStateEntity> call(NoParams _) => _repository.getSyncStatus();
}

@injectable
class IsHealthPlatformAvailableUseCase {
  const IsHealthPlatformAvailableUseCase(this._repository);
  final HealthRepository _repository;
  Future<bool> call(NoParams _) => _repository.isPlatformAvailable();
}

@injectable
class RefreshHealthConnectionUseCase {
  const RefreshHealthConnectionUseCase(this._repository);
  final HealthRepository _repository;
  Future<void> call(NoParams _) => _repository.refreshConnectionState();
}

@injectable
class WatchHealthStatusUseCase {
  const WatchHealthStatusUseCase(this._repository);
  final HealthRepository _repository;
  Stream<HealthSyncStateEntity> call(NoParams _) => _repository.watchHealthStatus();
}
