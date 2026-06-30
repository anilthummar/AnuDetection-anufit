import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/core/services/permission_service.dart';
import 'package:anufit/features/health/services/health_sync_scheduler.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';

/// Re-checks permissions when the app returns from system settings.
Future<void> handlePermissionResume(GoRouter router) async {
  await getIt<HealthSyncScheduler>().onAppResume();

  final settings = await getIt<OnboardingRepository>().getSettings();
  if (!settings.onboardingComplete) return;

  final activity = await getIt<PermissionService>().checkPermission(
    AppPermissionType.activityRecognition,
  );
  if (activity.isGranted) return;

  final path = router.state.uri.path;
  if (path == AppRoutes.permissions ||
      path.startsWith(AppRoutes.onboarding) ||
      path == AppRoutes.splash) {
    return;
  }

  router.go(AppRoutes.permissions);
}
