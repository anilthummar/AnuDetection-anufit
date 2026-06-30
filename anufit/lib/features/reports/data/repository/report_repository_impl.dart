import 'package:injectable/injectable.dart';

import 'package:anufit/core/constants/app_constants.dart';
import 'package:anufit/features/achievements/domain/repository/achievement_repository.dart';
import 'package:anufit/features/history/data/datasource/history_local_datasource.dart';
import 'package:anufit/features/history/domain/entities/history_entity.dart';
import 'package:anufit/features/history/domain/services/analytics_engine.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/reports/domain/entities/report_entity.dart';
import 'package:anufit/features/reports/domain/repository/report_repository.dart';
import 'package:anufit/features/reports/domain/services/report_generator.dart';

@LazySingleton(as: ReportRepository)
class ReportRepositoryImpl implements ReportRepository {
  ReportRepositoryImpl(
    this._historyLocal,
    this._analytics,
    this._onboardingRepository,
    this._achievementRepository,
  );

  final HistoryLocalDatasource _historyLocal;
  final AnalyticsEngine _analytics;
  final OnboardingRepository _onboardingRepository;
  final AchievementRepository _achievementRepository;

  @override
  Future<ReportData> buildReport({
    required ReportPeriod period,
    DateTime? customStart,
    DateTime? customEnd,
  }) async {
    await _analytics.syncRecent();
    final range = _resolveRange(period, customStart, customEnd);
    final models = await _historyLocal.getDailyRange(
      start: range.start,
      end: range.end,
      limit: 400,
    );

    var steps = 0;
    var distance = 0.0;
    var calories = 0.0;
    var walkingMinutes = 0;
    var goalsMet = 0;
    DailySummaryEntity? best;
    DailySummaryEntity? worst;

    final breakdown = <({String date, int steps, double km})>[];
    for (final m in models) {
      steps += m.steps;
      distance += m.distanceKm;
      calories += m.calories;
      walkingMinutes += m.walkingTimeMinutes;
      if (m.goalCompleted) goalsMet++;

      final entity = DailySummaryEntity(
        date: m.date,
        steps: m.steps,
        distanceKm: m.distanceKm,
        calories: m.calories,
        walkingTime: Duration(minutes: m.walkingTimeMinutes),
        goalCompleted: m.goalCompleted,
      );
      if (best == null || m.steps > best.steps) best = entity;
      if (worst == null || m.steps < worst.steps) worst = entity;
      breakdown.add((
        date: ReportGenerator.formatDate(m.date),
        steps: m.steps,
        km: m.distanceKm,
      ));
    }

    final user = await _onboardingRepository.getUser();
    final achievements = await _achievementRepository.getAchievements();
    final earned = achievements
        .where((a) => a.completed)
        .map((a) => a.title)
        .take(10)
        .toList();

    final periodLabel = '${ReportGenerator.formatDate(range.start)} – ${ReportGenerator.formatDate(range.end)}';

    return ReportData(
      title: '${AppConstants.appShortName} Activity Report',
      periodLabel: periodLabel,
      userName: user?.name?.trim().isNotEmpty == true ? user!.name! : 'Walker',
      totalSteps: steps,
      distanceKm: distance,
      calories: calories,
      walkingTime: Duration(minutes: walkingMinutes),
      goalCompletionRate: models.isEmpty ? 0 : goalsMet / models.length,
      bestDay: best != null ? ReportGenerator.formatDate(best.date) : '—',
      worstDay: worst != null ? ReportGenerator.formatDate(worst.date) : '—',
      achievementsEarned: earned,
      dailyBreakdown: breakdown,
    );
  }

  @override
  Future<GeneratedReport> exportReport({
    required ReportData data,
    required ExportFormat format,
  }) {
    return ReportGenerator.generate(data: data, format: format);
  }

  ({DateTime start, DateTime end}) _resolveRange(
    ReportPeriod period,
    DateTime? customStart,
    DateTime? customEnd,
  ) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    return switch (period) {
      ReportPeriod.daily => (start: today, end: today),
      ReportPeriod.weekly => (
          start: today.subtract(const Duration(days: 6)),
          end: today,
        ),
      ReportPeriod.monthly => (
          start: DateTime(today.year, today.month, 1),
          end: today,
        ),
      ReportPeriod.yearly => (
          start: DateTime(today.year, 1, 1),
          end: today,
        ),
      ReportPeriod.custom => (
          start: customStart ?? today.subtract(const Duration(days: 29)),
          end: customEnd ?? today,
        ),
    };
  }
}
