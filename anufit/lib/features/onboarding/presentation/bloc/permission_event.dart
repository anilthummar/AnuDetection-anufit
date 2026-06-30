part of 'permission_bloc.dart';

sealed class PermissionEvent extends Equatable {
  const PermissionEvent();

  @override
  List<Object?> get props => [];
}

final class PermissionLoadStatus extends PermissionEvent {
  const PermissionLoadStatus({this.autoRequest = false});

  final bool autoRequest;

  @override
  List<Object?> get props => [autoRequest];
}

final class PermissionRequestActivity extends PermissionEvent {
  const PermissionRequestActivity();
}

final class PermissionRequestNotifications extends PermissionEvent {
  const PermissionRequestNotifications();
}

final class PermissionOpenSettings extends PermissionEvent {
  const PermissionOpenSettings();
}
