import 'package:flutter_test/flutter_test.dart';

import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/features/step_counter/domain/services/step_baseline_calculator.dart';

void main() {
  group('StepBaselineCalculator', () {
    test('dailySteps subtracts baseline and applies manual adjustment', () {
      expect(
        StepBaselineCalculator.dailySteps(
          hardwareTotal: 1500,
          dailyBaseline: 1000,
          manualAdjustment: 50,
        ),
        550,
      );
    });

    test('dailySteps never returns negative values', () {
      expect(
        StepBaselineCalculator.dailySteps(
          hardwareTotal: 900,
          dailyBaseline: 1000,
        ),
        0,
      );
    });

    test('newDayBaseline uses current hardware total', () {
      expect(StepBaselineCalculator.newDayBaseline(4321), 4321);
    });

    test('baselineAfterHardwareReset preserves counted steps', () {
      final baseline = StepBaselineCalculator.baselineAfterHardwareReset(
        lastHardwareTotal: 5000,
        lastDailyBaseline: 4000,
        newHardwareTotal: 100,
      );
      expect(
        StepBaselineCalculator.dailySteps(
          hardwareTotal: 100,
          dailyBaseline: baseline,
        ),
        1000,
      );
    });

    test('isNewLocalDay detects calendar changes', () {
      final stored = DateTime(2026, 6, 28);
      final now = DateTime(2026, 6, 29, 8);
      expect(
        StepBaselineCalculator.isNewLocalDay(
          storedDate: stored,
          now: now,
          storedTimezone: 'IST',
          currentTimezone: 'IST',
        ),
        isTrue,
      );
    });

    test('isNewLocalDay detects timezone changes', () {
      final day = DateTime(2026, 6, 29);
      expect(
        StepBaselineCalculator.isNewLocalDay(
          storedDate: day,
          now: day,
          storedTimezone: 'UTC',
          currentTimezone: 'IST',
        ),
        isTrue,
      );
    });

    test('rolloverBaseline resets manual adjustment', () {
      final baseline = StepBaselineCalculator.rolloverBaseline(
        current: StepBaseline(
          date: DateTime(2026, 6, 28),
          hardwareBaseline: 1000,
          lastHardwareTotal: 2500,
          timezoneId: 'UTC',
          manualAdjustment: 25,
        ),
        hardwareTotal: 3000,
        now: DateTime(2026, 6, 29),
        timezoneId: 'UTC',
      );

      expect(baseline.hardwareBaseline, 3000);
      expect(baseline.manualAdjustment, 0);
      expect(baseline.date, DateTime(2026, 6, 29));
    });
  });
}
