import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

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
    this._permissions,
  ) : super(const HealthConnectState()) {
    on<HealthConnectRequested>(_onConnect);
    on<HealthConnectSkipRequested>(_onSkip);
    on<HealthConnectLaterRequested>(_onConnectLater);
  }

  final GetAppSettingsUseCase _getSettings;
  final SaveAppSettingsUseCase _saveSettings;
  final ConnectHealthUseCase _connect;
  final IsHealthPlatformAvailableUseCase _isAvailable;
  final PermissionService _permissions;

  Future<void> _onConnect(
    HealthConnectRequested event,
    Emitter<HealthConnectState> emit,
  ) async {
    emit(state.copyWith(isSaving: true, clearError: true));
    try {
      await _permissions.requestPermission(AppPermissionType.activityRecognition);
      final available = await _isAvailable(const NoParams());
      if (!available) {
        emit(state.copyWith(
          isSaving: false,
          errorMessage: 'Health platform is not available on this device.',
        ));
        return;
      }
      final connected = await _connect(const NoParams());
      if (connected) {
        emit(state.copyWith(isSaving: false, connected: true));
      } else {
        emit(state.copyWith(
          isSaving: false,
          errorMessage: 'Permission denied. Allow access in the system dialog.',
        ));
      }
    } catch (error) {
      emit(state.copyWith(
        isSaving: false,
        errorMessage: _friendlyError(error),
      ));
    }
  }

  String _friendlyError(Object error) {
    final message = error.toString();
    if (message.contains('IsarError') || message.contains('CacheException')) {
      return 'Could not save health settings. Please try again.';
    }
    if (message.contains('Permission') || message.contains('denied')) {
      return 'Permission denied. Allow access in the system dialog.';
    }
    return 'Could not connect to Health. Please try again.';
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
