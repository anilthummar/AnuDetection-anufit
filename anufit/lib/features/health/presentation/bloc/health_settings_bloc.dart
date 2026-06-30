import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/services/permission_service.dart';
import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';
import 'package:anufit/features/health/domain/repository/health_repository.dart';
import 'package:anufit/features/health/domain/usecases/health_usecases.dart';

part 'health_settings_event.dart';
part 'health_settings_state.dart';

@injectable
class HealthSettingsBloc extends Bloc<HealthSettingsEvent, HealthSettingsState> {
  HealthSettingsBloc(
    this._getStatus,
    this._connect,
    this._disconnect,
    this._sync,
    this._checkPermissions,
    this._isAvailable,
    this._permissions,
  ) : super(const HealthSettingsInitial()) {
    on<HealthSettingsLoadRequested>(_onLoad);
    on<HealthConnectRequested>(_onConnect);
    on<HealthDisconnectRequested>(_onDisconnect);
    on<HealthSyncNowRequested>(_onSync);
    on<HealthViewPermissionsRequested>(_onViewPermissions);
  }

  final GetHealthSyncStatusUseCase _getStatus;
  final ConnectHealthUseCase _connect;
  final DisconnectHealthUseCase _disconnect;
  final SyncHealthDataUseCase _sync;
  final CheckHealthPermissionsUseCase _checkPermissions;
  final IsHealthPlatformAvailableUseCase _isAvailable;
  final PermissionService _permissions;

  Future<void> _onLoad(
    HealthSettingsLoadRequested event,
    Emitter<HealthSettingsState> emit,
  ) async {
    emit(const HealthSettingsLoading());
    try {
      final available = await _isAvailable(const NoParams());
      final status = await _getStatus(const NoParams());
      if (status.connected) {
        try {
          await _sync(const SyncHealthParams(initial: true));
        } catch (_) {}
      }
      emit(HealthSettingsLoaded(status: status, platformAvailable: available));
    } catch (error) {
      emit(HealthSettingsError(error.toString()));
    }
  }

  Future<void> _onConnect(
    HealthConnectRequested event,
    Emitter<HealthSettingsState> emit,
  ) async {
    final current = state;
    if (current is HealthSettingsLoaded) {
      emit(current.copyWith(isBusy: true));
    }
    try {
      await _permissions.requestPermission(AppPermissionType.activityRecognition);
      final connected = await _connect(const NoParams());
      final status = await _getStatus(const NoParams());
      emit(HealthSettingsLoaded(
        status: status,
        platformAvailable: true,
        message: connected
            ? 'Health connected — pull steps from Health Connect'
            : 'Permission denied. Open Health Connect and allow Anufit access.',
      ));
    } catch (error) {
      emit(HealthSettingsError(error.toString()));
    }
  }

  Future<void> _onDisconnect(
    HealthDisconnectRequested event,
    Emitter<HealthSettingsState> emit,
  ) async {
    await _disconnect(const NoParams());
    add(const HealthSettingsLoadRequested());
  }

  Future<void> _onSync(
    HealthSyncNowRequested event,
    Emitter<HealthSettingsState> emit,
  ) async {
    final current = state;
    if (current is HealthSettingsLoaded) {
      emit(current.copyWith(isSyncing: true));
    }
    try {
      final result = await _sync(const SyncHealthParams());
      final status = await _getStatus(const NoParams());
      emit(HealthSettingsLoaded(
        status: status,
        platformAvailable: true,
        message: 'Synced ${result.recordsUpdated} records',
      ));
    } catch (error) {
      emit(HealthSettingsError(error.toString()));
    }
  }

  Future<void> _onViewPermissions(
    HealthViewPermissionsRequested event,
    Emitter<HealthSettingsState> emit,
  ) async {
    await _checkPermissions(const NoParams());
    add(const HealthSettingsLoadRequested());
  }
}
