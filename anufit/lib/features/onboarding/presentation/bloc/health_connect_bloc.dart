import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/onboarding/domain/usecases/onboarding_usecases.dart';

part 'health_connect_event.dart';
part 'health_connect_state.dart';

@injectable
class HealthConnectBloc extends Bloc<HealthConnectEvent, HealthConnectState> {
  HealthConnectBloc(this._getSettings, this._saveSettings) : super(const HealthConnectState()) {
    on<HealthConnectSkipRequested>(_onSkip);
    on<HealthConnectLaterRequested>(_onConnectLater);
  }

  final GetAppSettingsUseCase _getSettings;
  final SaveAppSettingsUseCase _saveSettings;

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
