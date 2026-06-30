part of 'health_bloc.dart';

sealed class HealthEvent extends Equatable {
  const HealthEvent();
  @override
  List<Object?> get props => [];
}

final class HealthWatchStarted extends HealthEvent {
  const HealthWatchStarted();
}

final class HealthStatusUpdated extends HealthEvent {
  const HealthStatusUpdated(this.status);
  final HealthSyncStateEntity status;
  @override
  List<Object?> get props => [status];
}
