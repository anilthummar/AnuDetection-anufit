part of 'health_connect_bloc.dart';

sealed class HealthConnectEvent extends Equatable {
  const HealthConnectEvent();

  @override
  List<Object?> get props => [];
}

final class HealthConnectSkipRequested extends HealthConnectEvent {
  const HealthConnectSkipRequested();
}

final class HealthConnectLaterRequested extends HealthConnectEvent {
  const HealthConnectLaterRequested();
}

final class HealthConnectRequested extends HealthConnectEvent {
  const HealthConnectRequested();
}
