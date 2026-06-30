import 'package:anufit/core/constants/app_constants.dart';

/// Step-by-step copy shown when the user must enable permissions in system settings.
abstract final class PermissionInstructions {
  static const String _appName = AppConstants.appName;

  static const String grantActivityRecognition =
      'Activity Recognition is required before connecting Health.\n\n'
      'Tap "Grant Activity Permission" below, then tap Allow on each permission.';

  static String physicalActivityDenied = '''
Physical activity permission is required to count steps.

Follow these steps:
1. Tap "Open App Permissions" below
2. In $_appName settings, open Permissions
3. Tap Physical activity
4. Select Allow''';

  static String healthConnectDenied = '''
Health Connect access is required to sync steps and activity.

Follow these steps:
1. Tap "Grant Health Connect Access" below
2. On the Health Connect screen, tap Allow all
3. Return here and tap Connect

Already allowed in Health Connect? Tap Grant Health Connect Access once to refresh.''';

  /// App-level Android permission (separate from Health Connect data access).
  static String healthWellnessDenied = '''
App permission is also required on Android.

Follow these steps:
1. Tap "Open App Permissions" below
2. In $_appName settings, open Permissions
3. Tap Health, fitness and wellness
4. Select Allow all
5. Return and tap Grant Health Connect Access''';

  static String activityRecognitionInSettings = '''
Activity Recognition was denied earlier.

Follow these steps:
1. Tap Open Settings below
2. In $_appName settings, open Permissions
3. Tap Physical activity
4. Select Allow''';

  static String notificationsInSettings = '''
Notifications were denied earlier.

Follow these steps:
1. Tap Open Settings below
2. In $_appName settings, open Permissions
3. Tap Notifications
4. Select Allow''';
}
