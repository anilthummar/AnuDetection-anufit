import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/services/permission_service.dart';

part 'permission_event.dart';
part 'permission_state.dart';

@injectable
class PermissionBloc extends Bloc<PermissionEvent, PermissionState> {
  PermissionBloc(this._permissionService) : super(const PermissionState()) {
    on<PermissionLoadStatus>(_onLoadStatus);
    on<PermissionRequestActivity>(_onRequestActivity);
    on<PermissionRequestNotifications>(_onRequestNotifications);
    on<PermissionOpenSettings>(_onOpenSettings);
  }

  final PermissionService _permissionService;

  Future<void> _onLoadStatus(
    PermissionLoadStatus event,
    Emitter<PermissionState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));
    final activity = await _permissionService.checkPermission(
      AppPermissionType.activityRecognition,
    );
    final notifications = await _permissionService.checkPermission(
      AppPermissionType.notifications,
    );
    emit(
      state.copyWith(
        activityGranted: activity.isGranted,
        notificationsGranted: notifications.isGranted,
        activityDeniedPermanently: activity.isPermanentlyDenied,
        notificationsDeniedPermanently: notifications.isPermanentlyDenied,
        isLoading: false,
      ),
    );
  }

  Future<void> _onRequestActivity(
    PermissionRequestActivity event,
    Emitter<PermissionState> emit,
  ) async {
    final result = await _permissionService.requestPermission(
      AppPermissionType.activityRecognition,
    );
    emit(state.copyWith(
      activityGranted: result.isGranted,
      activityDeniedPermanently: result.isPermanentlyDenied,
    ));
  }

  Future<void> _onRequestNotifications(
    PermissionRequestNotifications event,
    Emitter<PermissionState> emit,
  ) async {
    final result = await _permissionService.requestPermission(
      AppPermissionType.notifications,
    );
    emit(state.copyWith(
      notificationsGranted: result.isGranted,
      notificationsDeniedPermanently: result.isPermanentlyDenied,
    ));
  }

  Future<void> _onOpenSettings(
    PermissionOpenSettings event,
    Emitter<PermissionState> emit,
  ) async {
    await _permissionService.openSettings();
  }
}
