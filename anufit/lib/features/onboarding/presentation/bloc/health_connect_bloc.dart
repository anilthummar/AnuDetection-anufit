import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/constants/permission_instructions.dart';
import 'package:anufit/core/services/permission_service.dart';
import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/health/domain/usecases/health_usecases.dart';
import 'package:anufit/features/onboarding/domain/usecases/onboarding_usecases.dart';

part 'health_connect_event.dart';
part 'health_connect_state.dart';

@injectable
class HealthConnectBloc extends Bloc<HealthConnectEvent, HealthConnectState> {
  HealthConnectBloc(
    this._getSettings,
    this._saveSettings,
    this._connect,
    this._isAvailable,
    this._checkPermissions,
    this._permissions,
  ) : super(const HealthConnectState()) {
    on<HealthConnectRequested>(_onConnect);
    on<HealthConnectSkipRequested>(_onSkip);
    on<HealthConnectLaterRequested>(_onConnectLater);
    on<HealthConnectGuidanceHandled>(_onGuidanceHandled);
    on<HealthConnectOpenSettingsRequested>(_onOpenSettings);
  }

  final GetAppSettingsUseCase _getSettings;
  final SaveAppSettingsUseCase _saveSettings;
  final ConnectHealthUseCase _connect;
  final IsHealthPlatformAvailableUseCase _isAvailable;
  final CheckHealthPermissionsUseCase _checkPermissions;
  final PermissionService _permissions;

  Future<void> _onConnect(
    HealthConnectRequested event,
    Emitter<HealthConnectState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, clearError: true, clearGuidance: true));
    try {
      final activity = await _permissions.checkPermission(
        AppPermissionType.activityRecognition,
      );
      if (!activity.isGranted) {
        emit(
          state.copyWith(
            isSaving: false,
            errorMessage: activity.isPermanentlyDenied
                ? PermissionInstructions.physicalActivityDenied
                : PermissionInstructions.grantActivityRecognition,
            guidance: activity.isPermanentlyDenied
                ? HealthConnectGuidance.openAppSettingsForActivity
                : HealthConnectGuidance.grantActivityPermission,
          ),
        );
        return;
      }

      final available = await _isAvailable(const NoParams());
      if (!available) {
        emit(
          state.copyWith(
            isSaving: false,
            errorMessage: 'Health platform is not available on this device.',
          ),
        );
        return;
      }

      final connected = await _connect(const NoParams());
      if (connected) {
        emit(state.copyWith(isSaving: false, connected: true));
        return;
      }

      final health = await _checkPermissions(const NoParams());
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: health.authorized
              ? 'Could not connect to Health. Try again or use Connect Later.'
              : PermissionInstructions.healthWellnessDenied,
          guidance: health.authorized ? null : HealthConnectGuidance.openAppSettingsForHealth,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          isSaving: false,
          errorMessage: _friendlyError(error),
          guidance: _guidanceForError(error),
        ),
      );
    }
  }

  HealthConnectGuidance? _guidanceForError(Object error) {
    final message = error.toString().toLowerCase();
    if (message.contains('permission') || message.contains('denied')) {
      return HealthConnectGuidance.openAppSettingsForHealth;
    }
    return null;
  }

  String _friendlyError(Object error) {
    final message = error.toString();
    if (message.contains('IsarError') || message.contains('CacheException')) {
      return 'Could not save health settings. Please try again.';
    }
    if (message.contains('Permission') || message.contains('denied')) {
      return PermissionInstructions.healthWellnessDenied;
    }
    return 'Could not connect to Health. Please try again.';
  }

  Future<void> _onOpenSettings(
    HealthConnectOpenSettingsRequested event,
    Emitter<HealthConnectState> emit,
  ) async {
    await _permissions.openSettings();
    emit(state.copyWith(clearGuidance: true));
  }

  void _onGuidanceHandled(
    HealthConnectGuidanceHandled event,
    Emitter<HealthConnectState> emit,
  ) {
    emit(state.copyWith(clearGuidance: true));
  }

  Future<void> _onSkip(HealthConnectSkipRequested event, Emitter<HealthConnectState> emit) async {
    emit(state.copyWith(isSaving: true));
    final settings = await _getSettings();
    await _saveSettings(settings.copyWith(healthConnected: false));
    emit(state.copyWith(skipped: true, isSaving: false));
  }

  Future<void> _onConnectLater(
    HealthConnectLaterRequested event,
    Emitter<HealthConnectState> emit,
  ) async {
    emit(state.copyWith(isSaving: true));
    final settings = await _getSettings();
    await _saveSettings(settings.copyWith(healthConnected: false));
    emit(state.copyWith(connectLater: true, isSaving: false));
  }
}
