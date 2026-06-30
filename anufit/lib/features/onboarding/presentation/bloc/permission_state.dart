part of 'permission_bloc.dart';

class PermissionState extends Equatable {
  const PermissionState({
    this.activityGranted = false,
    this.notificationsGranted = false,
    this.activityDeniedPermanently = false,
    this.notificationsDeniedPermanently = false,
    this.isLoading = false,
  });

  final bool activityGranted;
  final bool notificationsGranted;
  final bool activityDeniedPermanently;
  final bool notificationsDeniedPermanently;
  final bool isLoading;

  bool get allRequiredGranted => activityGranted && notificationsGranted;

  PermissionState copyWith({
    bool? activityGranted,
    bool? notificationsGranted,
    bool? activityDeniedPermanently,
    bool? notificationsDeniedPermanently,
    bool? isLoading,
  }) {
    return PermissionState(
      activityGranted: activityGranted ?? this.activityGranted,
      notificationsGranted: notificationsGranted ?? this.notificationsGranted,
      activityDeniedPermanently:
          activityDeniedPermanently ?? this.activityDeniedPermanently,
      notificationsDeniedPermanently:
          notificationsDeniedPermanently ?? this.notificationsDeniedPermanently,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  @override
  List<Object?> get props => [
        activityGranted,
        notificationsGranted,
        activityDeniedPermanently,
        notificationsDeniedPermanently,
        isLoading,
      ];
}
