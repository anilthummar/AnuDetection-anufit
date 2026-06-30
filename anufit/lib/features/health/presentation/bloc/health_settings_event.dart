part of 'health_settings_bloc.dart';

sealed class HealthSettingsEvent extends Equatable {
  const HealthSettingsEvent();
  @override
  List<Object?> get props => [];
}

final class HealthSettingsLoadRequested extends HealthSettingsEvent {
  const HealthSettingsLoadRequested();
}

final class HealthConnectRequested extends HealthSettingsEvent {
  const HealthConnectRequested();
}

final class HealthDisconnectRequested extends HealthSettingsEvent {
  const HealthDisconnectRequested();
}

final class HealthSyncNowRequested extends HealthSettingsEvent {
  const HealthSyncNowRequested();
}

final class HealthViewPermissionsRequested extends HealthSettingsEvent {
  const HealthViewPermissionsRequested();
}

final class HealthSettingsOpenAppSettingsRequested extends HealthSettingsEvent {
  const HealthSettingsOpenAppSettingsRequested();
}

final class HealthSettingsRequestHealthConnectPermissions extends HealthSettingsEvent {
  const HealthSettingsRequestHealthConnectPermissions();
}

final class HealthSettingsResumeCheck extends HealthSettingsEvent {
  const HealthSettingsResumeCheck();
}
