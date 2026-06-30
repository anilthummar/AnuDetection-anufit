import 'package:anufit/core/enums/onboarding_step.dart';

/// Centralized route paths for [GoRouter].
abstract final class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String dashboard = '/dashboard';

  static const String goals = '/goals';
  static const String activity = '/activity';
  static const String achievements = '/achievements';

  static const String history = '/history';
  static const String statistics = '/statistics';
  static const String reports = '/reports';
  static const String settings = '/settings';
  static const String weight = '/weight';
  static const String water = '/water';
  static const String reminder = '/reminder';
  static const String profile = '/profile';
  static const String healthSync = '/health-sync';

  static const String backup = '/backup';
  static const String exportHub = '/export';
  static const String cloudSync = '/cloud-sync';
  static const String widgets = '/widgets';
  static const String security = '/security';
  static const String release = '/release';
  static const String privacyPolicy = '/privacy-policy';

  static String onboardingStep(OnboardingStep step) => '$onboarding/${step.routeSuffix}';
}
