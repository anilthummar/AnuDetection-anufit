import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:anufit/core/entities/streak_info.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/services/permission_service.dart';
import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:anufit/features/dashboard/domain/usecases/dashboard_usecases.dart';
import 'package:anufit/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

class MockGetTodaySummaryUseCase extends Mock implements GetTodaySummaryUseCase {}

class MockDashboardWatchLiveStepsUseCase extends Mock implements DashboardWatchLiveStepsUseCase {}

class MockGetGoalProgressUseCase extends Mock implements GetGoalProgressUseCase {}

class MockGetCaloriesUseCase extends Mock implements GetCaloriesUseCase {}

class MockGetDistanceUseCase extends Mock implements GetDistanceUseCase {}

class MockGetWalkingTimeUseCase extends Mock implements GetWalkingTimeUseCase {}

class MockGetAchievementsPreviewUseCase extends Mock implements GetAchievementsPreviewUseCase {}

class MockGetHourlyStepsUseCase extends Mock implements GetHourlyStepsUseCase {}

class MockDashboardStartTrackingUseCase extends Mock implements DashboardStartTrackingUseCase {}

class MockDashboardPauseTrackingUseCase extends Mock implements DashboardPauseTrackingUseCase {}

class MockDashboardResumeTrackingUseCase extends Mock implements DashboardResumeTrackingUseCase {}

class MockPermissionService extends Mock implements PermissionService {}

void main() {
  late MockGetTodaySummaryUseCase getTodaySummary;
  late MockDashboardWatchLiveStepsUseCase watchLiveSteps;
  late MockGetGoalProgressUseCase getGoalProgress;
  late MockGetCaloriesUseCase getCalories;
  late MockGetDistanceUseCase getDistance;
  late MockGetWalkingTimeUseCase getWalkingTime;
  late MockGetAchievementsPreviewUseCase getAchievementsPreview;
  late MockGetHourlyStepsUseCase getHourlySteps;
  late MockDashboardStartTrackingUseCase startTracking;
  late MockDashboardPauseTrackingUseCase pauseTracking;
  late MockDashboardResumeTrackingUseCase resumeTracking;
  late MockPermissionService permissions;

  final summary = DashboardSummary(
    userName: 'Anil',
    todaySteps: 7540,
    goal: 10000,
    calories: 301.6,
    distanceKm: 5.2,
    walkingTime: const Duration(minutes: 65),
    completionPercentage: 0.754,
    streak: const StreakInfo(currentStreak: 3, longestStreak: 5),
    achievements: const [],
    hourlySteps: const [],
    trackingStatus: TrackingStatus.idle,
    lastUpdated: DateTime(2026, 6, 29),
    unit: UnitSystem.metric,
  );

  DashboardBloc buildBloc() {
    return DashboardBloc(
      getTodaySummary,
      watchLiveSteps,
      getDistance,
      getWalkingTime,
      getHourlySteps,
      startTracking,
      pauseTracking,
      resumeTracking,
      permissions,
    );
  }

  setUpAll(() {
    registerFallbackValue(const NoParams());
    registerFallbackValue(const GetGoalProgressParams());
    registerFallbackValue(const GetMetricParams());
    registerFallbackValue(const GetAchievementsParams());
    registerFallbackValue(AppPermissionType.activityRecognition);
  });

  setUp(() {
    getTodaySummary = MockGetTodaySummaryUseCase();
    watchLiveSteps = MockDashboardWatchLiveStepsUseCase();
    getGoalProgress = MockGetGoalProgressUseCase();
    getCalories = MockGetCaloriesUseCase();
    getDistance = MockGetDistanceUseCase();
    getWalkingTime = MockGetWalkingTimeUseCase();
    getAchievementsPreview = MockGetAchievementsPreviewUseCase();
    getHourlySteps = MockGetHourlyStepsUseCase();
    startTracking = MockDashboardStartTrackingUseCase();
    pauseTracking = MockDashboardPauseTrackingUseCase();
    resumeTracking = MockDashboardResumeTrackingUseCase();
    permissions = MockPermissionService();

    when(() => permissions.checkPermission(any())).thenAnswer(
      (_) async => const PermissionStatusEntity(
        type: AppPermissionType.activityRecognition,
        isGranted: false,
        isPermanentlyDenied: false,
      ),
    );

    when(() => getTodaySummary(any())).thenAnswer((_) async => summary);
    when(() => watchLiveSteps(any())).thenAnswer((_) => const Stream.empty());
    when(() => getGoalProgress(any())).thenAnswer(
      (_) async => const GoalProgress(
        goal: 10000,
        todaySteps: 7540,
        remainingSteps: 2460,
        completionPercentage: 0.754,
      ),
    );
    when(() => getCalories(any())).thenAnswer((_) async => 301.6);
    when(() => getDistance(any())).thenAnswer((_) async => 5.2);
    when(() => getWalkingTime(any())).thenAnswer((_) async => const Duration(minutes: 65));
    when(() => getAchievementsPreview(any())).thenAnswer((_) async => const []);
    when(() => getHourlySteps(any())).thenAnswer((_) async => const []);
  });

  blocTest<DashboardBloc, DashboardState>(
    'loads dashboard summary',
    build: buildBloc,
    act: (bloc) => bloc.add(const LoadDashboard()),
    expect: () => [
      const DashboardLoading(),
      isA<DashboardLoaded>().having((s) => s.summary.userName, 'name', 'Anil'),
    ],
  );
}
