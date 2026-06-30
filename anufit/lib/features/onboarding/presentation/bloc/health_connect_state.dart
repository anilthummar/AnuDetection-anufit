part of 'health_connect_bloc.dart';

enum HealthConnectGuidance {
  grantActivityPermission,
  openAppSettingsForActivity,
  openHealthConnect,
}

class HealthConnectState extends Equatable {
  const HealthConnectState({
    this.skipped = false,
    this.connectLater = false,
    this.connected = false,
    this.isSaving = false,
    this.errorMessage,
    this.guidance,
  });

  final bool skipped;
  final bool connectLater;
  final bool connected;
  final bool isSaving;
  final String? errorMessage;
  final HealthConnectGuidance? guidance;

  HealthConnectState copyWith({
    bool? skipped,
    bool? connectLater,
    bool? connected,
    bool? isSaving,
    String? errorMessage,
    HealthConnectGuidance? guidance,
    bool clearError = false,
    bool clearGuidance = false,
  }) {
    return HealthConnectState(
      skipped: skipped ?? this.skipped,
      connectLater: connectLater ?? this.connectLater,
      connected: connected ?? this.connected,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      guidance: clearGuidance ? null : (guidance ?? this.guidance),
    );
  }

  @override
  List<Object?> get props => [skipped, connectLater, connected, isSaving, errorMessage, guidance];
}
