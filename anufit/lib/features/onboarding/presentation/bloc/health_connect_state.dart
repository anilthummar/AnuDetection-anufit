part of 'health_connect_bloc.dart';

class HealthConnectState extends Equatable {
  const HealthConnectState({
    this.skipped = false,
    this.connectLater = false,
    this.connected = false,
    this.isSaving = false,
    this.errorMessage,
  });

  final bool skipped;
  final bool connectLater;
  final bool connected;
  final bool isSaving;
  final String? errorMessage;

  HealthConnectState copyWith({
    bool? skipped,
    bool? connectLater,
    bool? connected,
    bool? isSaving,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HealthConnectState(
      skipped: skipped ?? this.skipped,
      connectLater: connectLater ?? this.connectLater,
      connected: connected ?? this.connected,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }

  @override
  List<Object?> get props => [skipped, connectLater, connected, isSaving, errorMessage];
}
