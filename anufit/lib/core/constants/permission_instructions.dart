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

  static String healthWellnessDenied = '''
Health permission is required to sync with Health Connect.

Follow these steps:
1. Tap "Open App Permissions" below
2. In $_appName settings, open Permissions
3. Tap Health, fitness and wellness
4. Select Allow all''';

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
