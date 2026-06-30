import 'package:injectable/injectable.dart';

import 'package:anufit/core/entities/streak_info.dart';
import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:anufit/features/dashboard/domain/repository/dashboard_repository.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

@injectable
class GetTodaySummaryUseCase {
  const GetTodaySummaryUseCase(this._repository);

  final DashboardRepository _repository;

  Future<DashboardSummary> call(NoParams params) => _repository.getTodaySummary();
}

@injectable
class DashboardWatchLiveStepsUseCase {
  const DashboardWatchLiveStepsUseCase(this._repository);

  final DashboardRepository _repository;

  Stream<StepData> call(NoParams params) => _repository.watchLiveSteps();
}

@injectable
class GetGoalProgressUseCase {
  const GetGoalProgressUseCase(this._repository);

  final DashboardRepository _repository;

  Future<GoalProgress> call(GetGoalProgressParams params) {
    return _repository.getGoalProgress(todaySteps: params.todaySteps);
  }
}

class GetGoalProgressParams {
  const GetGoalProgressParams({this.todaySteps});

  final int? todaySteps;
}

@injectable
class GetCaloriesUseCase {
  const GetCaloriesUseCase(this._repository);

  final DashboardRepository _repository;

  Future<double> call(GetMetricParams params) {
    return _repository.getCalories(steps: params.steps);
  }
}

@injectable
class GetDistanceUseCase {
  const GetDistanceUseCase(this._repository);

  final DashboardRepository _repository;

  Future<double> call(GetMetricParams params) {
    return _repository.getDistance(steps: params.steps);
  }
}

@injectable
class GetWalkingTimeUseCase {
  const GetWalkingTimeUseCase(this._repository);

  final DashboardRepository _repository;

  Future<Duration> call(GetMetricParams params) {
    return _repository.getWalkingTime(steps: params.steps);
  }
}

class GetMetricParams {
  const GetMetricParams({this.steps});

  final int? steps;
}

@injectable
class GetCurrentStreakUseCase {
  const GetCurrentStreakUseCase(this._repository);

  final DashboardRepository _repository;

  Future<StreakInfo> call(NoParams params) => _repository.getCurrentStreak();
}

@injectable
class GetAchievementsPreviewUseCase {
  const GetAchievementsPreviewUseCase(this._repository);

  final DashboardRepository _repository;

  Future<List<Achievement>> call(GetAchievementsParams params) {
    return _repository.getAchievementsPreview(todaySteps: params.todaySteps);
  }
}

class GetAchievementsParams {
  const GetAchievementsParams({this.todaySteps});

  final int? todaySteps;
}

@injectable
class GetHourlyStepsUseCase {
  const GetHourlyStepsUseCase(this._repository);

  final DashboardRepository _repository;

  Future<List<HourlyStepPoint>> call(NoParams params) => _repository.getHourlySteps();
}

@injectable
class DashboardStartTrackingUseCase {
  const DashboardStartTrackingUseCase(this._repository);

  final DashboardRepository _repository;

  Future<void> call(NoParams params) => _repository.startTracking();
}

@injectable
class DashboardPauseTrackingUseCase {
  const DashboardPauseTrackingUseCase(this._repository);

  final DashboardRepository _repository;

  Future<void> call(NoParams params) => _repository.pauseTracking();
}

@injectable
class DashboardResumeTrackingUseCase {
  const DashboardResumeTrackingUseCase(this._repository);

  final DashboardRepository _repository;

  Future<void> call(NoParams params) => _repository.resumeTracking();
}
