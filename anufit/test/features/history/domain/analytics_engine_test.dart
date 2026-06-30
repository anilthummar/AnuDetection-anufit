import 'package:flutter_test/flutter_test.dart';

import 'package:anufit/features/history/domain/services/analytics_engine.dart';

void main() {
  test('isoWeek returns consistent week numbers', () {
    expect(AnalyticsEngine.isoWeek(DateTime(2026, 6, 29)), greaterThan(0));
    expect(
      AnalyticsEngine.isoWeek(DateTime(2026, 1, 1)),
      AnalyticsEngine.isoWeek(DateTime(2026, 1, 2)),
    );
  });
}
