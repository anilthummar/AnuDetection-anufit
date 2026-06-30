import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/core/services/activity_metrics_calculator.dart';
import 'package:anufit/features/activity/data/models/activity_timeline_model.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/domain/services/step_baseline_calculator.dart';

@lazySingleton
class ActivityLocalDatasource {
  ActivityLocalDatasource(this._isarService);

  final IsarService _isarService;

  Future<void> upsertTimeline({
    required DateTime date,
    required List<HourlyStepPoint> hourly,
    required UserEntity user,
  }) async {
    final day = StepBaselineCalculator.localDate(date);
    await _isarService.db.writeTxn(() async {
      for (final point in hourly) {
        final key = '${day.year}-${day.month}-${day.day}-${point.hour}';
        final existing = await _isarService.db.activityTimelineModels
            .filter()
            .dayHourKeyEqualTo(key)
            .findFirst();
        final model = existing ?? ActivityTimelineModel()
          ..dayHourKey = key
          ..date = day
          ..hour = point.hour;
        model
          ..steps = point.steps
          ..distanceKm = ActivityMetricsCalculator.distanceKm(steps: point.steps, user: user)
          ..calories = ActivityMetricsCalculator.calories(point.steps)
          ..walkingTimeMinutes = ActivityMetricsCalculator.walkingTime(steps: point.steps, user: user).inMinutes;
        await _isarService.db.activityTimelineModels.put(model);
      }
    });
  }

  Future<List<ActivityTimelineModel>> getTimelineForDate(DateTime date) async {
    final day = StepBaselineCalculator.localDate(date);
    return _isarService.db.activityTimelineModels
        .filter()
        .dateEqualTo(day)
        .sortByHour()
        .findAll();
  }
}
