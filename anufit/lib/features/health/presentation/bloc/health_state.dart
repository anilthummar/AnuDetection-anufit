part of 'health_bloc.dart';

sealed class HealthState extends Equatable {
  const HealthState();
  @override
  List<Object?> get props => [];
}

final class HealthInitial extends HealthState {
  const HealthInitial();
}

final class HealthLoading extends HealthState {
  const HealthLoading();
}

final class HealthReady extends HealthState {
  const HealthReady({required this.status});
  final HealthSyncStateEntity status;
  @override
  List<Object?> get props => [status];
}
