import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/constants/permission_instructions.dart';
import 'package:anufit/core/services/permission_service.dart';
import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';
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
    this._refreshConnection,
    this._permissions,
  ) : super(const HealthSettingsInitial()) {
    on<HealthSettingsLoadRequested>(_onLoad);
    on<HealthConnectRequested>(_onConnect);
    on<HealthDisconnectRequested>(_onDisconnect);
    on<HealthSyncNowRequested>(_onSync);
    on<HealthViewPermissionsRequested>(_onViewPermissions);
    on<HealthSettingsOpenAppSettingsRequested>(_onOpenAppSettings);
  }

  final GetHealthSyncStatusUseCase _getStatus;
  final ConnectHealthUseCase _connect;
  final DisconnectHealthUseCase _disconnect;
  final SyncHealthDataUseCase _sync;
  final CheckHealthPermissionsUseCase _checkPermissions;
  final IsHealthPlatformAvailableUseCase _isAvailable;
  final RefreshHealthConnectionUseCase _refreshConnection;
  final PermissionService _permissions;

  Future<void> _onLoad(
    HealthSettingsLoadRequested event,
    Emitter<HealthSettingsState> emit,
  ) async {
    emit(const HealthSettingsLoading());
    try {
      final available = await _isAvailable(const NoParams());
      await _refreshConnection(const NoParams());
      var status = await _getStatus(const NoParams());

      if (available && !status.connected) {
        final activity = await _permissions.checkPermission(
          AppPermissionType.activityRecognition,
        );
        if (!activity.isGranted) {
          emit(HealthSettingsLoaded(
            status: status,
            platformAvailable: available,
            message: activity.isPermanentlyDenied
                ? PermissionInstructions.physicalActivityDenied
                : PermissionInstructions.grantActivityRecognition,
            permissionAction: activity.isPermanentlyDenied
                ? HealthPermissionAction.openAppSettings
                : HealthPermissionAction.grantActivityPermission,
          ));
          return;
        }

        final connected = await _connect(const NoParams());
        status = await _getStatus(const NoParams());
        if (connected) {
          try {
            await _sync(const SyncHealthParams(initial: true));
            status = await _getStatus(const NoParams());
          } catch (_) {}
        }
        emit(HealthSettingsLoaded(
          status: status,
          platformAvailable: available,
          message: connected
              ? 'Health connected successfully'
              : 'Permission required — tap Connect to allow access',
        ));
        return;
      }

      if (status.connected) {
        try {
          await _sync(const SyncHealthParams(initial: true));
          status = await _getStatus(const NoParams());
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
      final activity = await _permissions.checkPermission(
        AppPermissionType.activityRecognition,
      );
      if (!activity.isGranted) {
        final status = await _getStatus(const NoParams());
        emit(HealthSettingsLoaded(
          status: status,
          platformAvailable: true,
          isBusy: false,
          message: activity.isPermanentlyDenied
              ? PermissionInstructions.physicalActivityDenied
              : PermissionInstructions.grantActivityRecognition,
          permissionAction: activity.isPermanentlyDenied
              ? HealthPermissionAction.openAppSettings
              : HealthPermissionAction.grantActivityPermission,
        ));
        return;
      }

      final connected = await _connect(const NoParams());
      final status = await _getStatus(const NoParams());
      emit(HealthSettingsLoaded(
        status: status,
        platformAvailable: true,
        isBusy: false,
        message: connected
            ? 'Health connected — pull steps from Health Connect'
            : PermissionInstructions.healthWellnessDenied,
        permissionAction: connected ? null : HealthPermissionAction.openAppSettings,
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

  Future<void> _onOpenAppSettings(
    HealthSettingsOpenAppSettingsRequested event,
    Emitter<HealthSettingsState> emit,
  ) async {
    await _permissions.openSettings();
    final current = state;
    if (current is HealthSettingsLoaded) {
      emit(current.copyWith(clearPermissionAction: true));
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
