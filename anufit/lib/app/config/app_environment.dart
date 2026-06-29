/// Supported runtime environments.
enum AppEnvironment {
  dev('dev'),
  staging('staging'),
  production('production');

  const AppEnvironment(this.value);

  final String value;

  static AppEnvironment fromString(String value) {
    return AppEnvironment.values.firstWhere(
      (env) => env.value == value,
      orElse: () => AppEnvironment.dev,
    );
  }

  String get envFileName => '.env.$value';
}
