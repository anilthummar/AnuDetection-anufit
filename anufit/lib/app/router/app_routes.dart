/// Centralized route paths for [GoRouter].
///
/// Feature routes are declared here and wired in [AppRouter]
/// as each feature is implemented.
abstract final class AppRoutes {
  static const String shell = '/';

  // Feature routes (to be wired during feature implementation)
  static const String dashboard = '/dashboard';
  static const String history = '/history';
  static const String statistics = '/statistics';
  static const String settings = '/settings';
  static const String weight = '/weight';
  static const String water = '/water';
  static const String reminder = '/reminder';
  static const String profile = '/profile';
  static const String healthSync = '/health-sync';
}
