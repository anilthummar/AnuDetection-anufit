import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

enum AppPermissionType {
  activityRecognition,
  notifications,
}

class PermissionStatusEntity {
  const PermissionStatusEntity({
    required this.type,
    required this.isGranted,
    required this.isPermanentlyDenied,
  });

  final AppPermissionType type;
  final bool isGranted;
  final bool isPermanentlyDenied;
}

@injectable
class PermissionService {
  Future<PermissionStatusEntity> requestPermission(AppPermissionType type) async {
    final permission = _mapPermission(type);
    final status = await permission.request();
    return PermissionStatusEntity(
      type: type,
      isGranted: status.isGranted,
      isPermanentlyDenied: status.isPermanentlyDenied,
    );
  }

  Future<PermissionStatusEntity> checkPermission(AppPermissionType type) async {
    final permission = _mapPermission(type);
    final status = await permission.status;
    return PermissionStatusEntity(
      type: type,
      isGranted: status.isGranted,
      isPermanentlyDenied: status.isPermanentlyDenied,
    );
  }

  Future<bool> openSettings() => openAppSettings();

  Future<bool> isBatteryOptimizationDisabled() async {
    final status = await Permission.ignoreBatteryOptimizations.status;
    return status.isGranted;
  }

  Future<bool> requestDisableBatteryOptimization() async {
    final status = await Permission.ignoreBatteryOptimizations.request();
    if (status.isGranted) return true;
    return openAppSettings();
  }

  Permission _mapPermission(AppPermissionType type) {
    return switch (type) {
      AppPermissionType.activityRecognition => Permission.activityRecognition,
      AppPermissionType.notifications => Permission.notification,
    };
  }
}
