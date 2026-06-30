part of 'health_settings_bloc.dart';

sealed class HealthSettingsState extends Equatable {
  const HealthSettingsState();
  @override
  List<Object?> get props => [];
}

final class HealthSettingsInitial extends HealthSettingsState {
  const HealthSettingsInitial();
}

final class HealthSettingsLoading extends HealthSettingsState {
  const HealthSettingsLoading();
}

final class HealthSettingsLoaded extends HealthSettingsState {
  const HealthSettingsLoaded({
    required this.status,
    required this.platformAvailable,
    this.isBusy = false,
    this.isSyncing = false,
    this.message,
  });

  final HealthSyncStateEntity status;
  final bool platformAvailable;
  final bool isBusy;
  final bool isSyncing;
  final String? message;

  HealthSettingsLoaded copyWith({
    HealthSyncStateEntity? status,
    bool? platformAvailable,
    bool? isBusy,
    bool? isSyncing,
    String? message,
  }) {
    return HealthSettingsLoaded(
      status: status ?? this.status,
      platformAvailable: platformAvailable ?? this.platformAvailable,
      isBusy: isBusy ?? this.isBusy,
      isSyncing: isSyncing ?? this.isSyncing,
      message: message,
    );
  }

  @override
  List<Object?> get props =>
      [status, platformAvailable, isBusy, isSyncing, message];
}

final class HealthSettingsError extends HealthSettingsState {
  const HealthSettingsError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
