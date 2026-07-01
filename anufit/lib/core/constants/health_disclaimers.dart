/// Production health and fitness disclaimers for in-app disclosures.
abstract final class HealthDisclaimers {
  static const String healthSummary =
      'Step Counter - Pedometer is a general fitness and wellness app. '
      'It is not a medical device and is not intended to diagnose, treat, '
      'cure, or prevent any disease or health condition.';

  static const String fitnessSummary =
      'Activity summaries are for general fitness purposes only. '
      'Consult a healthcare professional before starting a new exercise program.';

  static const String accuracySummary =
      'Step counts, distance, and calorie values are estimates and may vary '
      'by device, sensor quality, and walking style. Accuracy is not guaranteed.';

  static const String healthConnectSummary =
      'Optional sync with Apple Health or Health Connect lets you import or '
      'export steps and activity data you choose to share. Data stays on your '
      'device unless you export or share it.';

  static const List<String> connectBulletPoints = [
    healthSummary,
    fitnessSummary,
    accuracySummary,
    healthConnectSummary,
  ];
}
