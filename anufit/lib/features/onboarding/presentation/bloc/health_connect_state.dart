part of 'health_connect_bloc.dart';

class HealthConnectState extends Equatable {
  const HealthConnectState({
    this.skipped = false,
    this.connectLater = false,
    this.isSaving = false,
  });

  final bool skipped;
  final bool connectLater;
  final bool isSaving;

  HealthConnectState copyWith({
    bool? skipped,
    bool? connectLater,
    bool? isSaving,
  }) {
    return HealthConnectState(
      skipped: skipped ?? this.skipped,
      connectLater: connectLater ?? this.connectLater,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  @override
  List<Object?> get props => [skipped, connectLater, isSaving];
}
