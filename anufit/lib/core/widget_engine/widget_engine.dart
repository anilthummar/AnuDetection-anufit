import 'dart:io';

import 'package:home_widget/home_widget.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/goals/domain/repository/goal_repository.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart';
import 'package:anufit/features/water/domain/repository/water_repository.dart';
import 'package:anufit/features/weight/domain/repository/weight_repository.dart';

@lazySingleton
class WidgetEngine {
  WidgetEngine(
    this._steps,
    this._goals,
    this._water,
    this._weight,
    this._onboarding,
  );

  final StepRepository _steps;
  final GoalRepository _goals;
  final WaterRepository _water;
  final WeightRepository _weight;
  final OnboardingRepository _onboarding;

  static const androidProvider = 'AnufitWidgetProvider';
  static const iOSAppGroup = 'group.com.anudetection.anufit';

  Future<void> initialize() async {
    if (Platform.isIOS) {
      await HomeWidget.setAppGroupId(iOSAppGroup);
    }
    await HomeWidget.registerInteractivityCallback(_backgroundCallback);
  }

  Future<void> syncWidgetData() async {
    final todaySteps = await _steps.getTodaySteps();
    final goalProgress = await _goals.watchGoalProgress().first;
    final water = await _water.getDashboard();
    final weight = await _weight.getDashboard();
    final user = await _onboarding.getUser();
    final goal = user?.dailyGoal ?? goalProgress.goal.stepGoal;

    await HomeWidget.saveWidgetData<int>('steps', todaySteps);
    await HomeWidget.saveWidgetData<int>('goal', goal);
    await HomeWidget.saveWidgetData<int>('water_ml', water.todayMl);
    await HomeWidget.saveWidgetData<double>('weight_kg', weight.currentWeightKg);
    await HomeWidget.saveWidgetData<double>(
      'goal_progress',
      goal <= 0 ? 0 : (todaySteps / goal).clamp(0, 1),
    );

    await HomeWidget.updateWidget(
      name: androidProvider,
      iOSName: 'AnufitWidget',
    );
  }

  @pragma('vm:entry-point')
  static Future<void> _backgroundCallback(Uri? uri) async {
    // Tap opens app via deep link configured in native widget.
  }
}
