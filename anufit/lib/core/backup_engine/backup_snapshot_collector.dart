import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/onboarding_step.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/database/isar_service.dart';
import 'package:anufit/features/achievements/data/models/achievement_model.dart';
import 'package:anufit/features/activity/data/models/activity_timeline_model.dart';
import 'package:anufit/features/goals/data/models/goal_model.dart';
import 'package:anufit/features/history/data/models/daily_summary_model.dart';
import 'package:anufit/features/history/data/models/monthly_summary_model.dart';
import 'package:anufit/features/history/data/models/weekly_summary_model.dart';
import 'package:anufit/features/health/data/models/health_permission_model.dart';
import 'package:anufit/features/health/data/models/health_sync_model.dart';
import 'package:anufit/features/onboarding/data/models/app_settings_model.dart';
import 'package:anufit/features/onboarding/data/models/user_model.dart';
import 'package:anufit/features/reminder/data/models/reminder_model.dart';
import 'package:anufit/features/step_counter/data/models/daily_step_record_model.dart';
import 'package:anufit/features/step_counter/data/models/hourly_step_record_model.dart';
import 'package:anufit/features/step_counter/data/models/step_tracking_state_model.dart';
import 'package:anufit/features/water/data/models/water_entry_model.dart';
import 'package:anufit/features/water/data/models/water_goal_model.dart';
import 'package:anufit/features/weight/data/models/weight_entry_model.dart';
import 'package:anufit/features/weight/data/models/weight_goal_model.dart';
import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

@lazySingleton
class BackupSnapshotCollector {
  BackupSnapshotCollector(this._isar);

  final IsarService _isar;

  Future<Map<String, dynamic>> collect() async {
    final db = _isar.db;
    return {
      'users': (await db.userModels.where().findAll()).map(_user).toList(),
      'appSettings': (await db.appSettingsModels.where().findAll()).map(_settings).toList(),
      'dailySteps': (await db.dailyStepRecordModels.where().findAll()).map(_dailyStep).toList(),
      'hourlySteps': (await db.hourlyStepRecordModels.where().findAll()).map(_hourlyStep).toList(),
      'stepState': (await db.stepTrackingStateModels.where().findAll()).map(_stepState).toList(),
      'goals': (await db.goalModels.where().findAll()).map(_goal).toList(),
      'achievements': (await db.achievementModels.where().findAll()).map(_achievement).toList(),
      'activityTimeline': (await db.activityTimelineModels.where().findAll()).map(_timeline).toList(),
      'dailySummaries': (await db.dailySummaryModels.where().findAll()).map(_dailySummary).toList(),
      'weeklySummaries': (await db.weeklySummaryModels.where().findAll()).map(_weeklySummary).toList(),
      'monthlySummaries': (await db.monthlySummaryModels.where().findAll()).map(_monthlySummary).toList(),
      'healthSync': (await db.healthSyncModels.where().findAll()).map(_healthSync).toList(),
      'healthPermissions': (await db.healthPermissionModels.where().findAll()).map(_healthPerm).toList(),
      'weightEntries': (await db.weightEntryModels.where().findAll()).map(_weightEntry).toList(),
      'weightGoals': (await db.weightGoalModels.where().findAll()).map(_weightGoal).toList(),
      'waterEntries': (await db.waterEntryModels.where().findAll()).map(_waterEntry).toList(),
      'waterGoals': (await db.waterGoalModels.where().findAll()).map(_waterGoal).toList(),
      'reminders': (await db.reminderModels.where().findAll()).map(_reminder).toList(),
    };
  }

  Future<void> restore(Map<String, dynamic> collections) async {
    await _isar.db.writeTxn(() async {
      await _isar.db.clear();
      for (final raw in (collections['users'] as List? ?? [])) {
        await _isar.db.userModels.put(_userFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['appSettings'] as List? ?? [])) {
        await _isar.db.appSettingsModels.put(_settingsFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['dailySteps'] as List? ?? [])) {
        await _isar.db.dailyStepRecordModels.put(_dailyStepFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['hourlySteps'] as List? ?? [])) {
        await _isar.db.hourlyStepRecordModels.put(_hourlyStepFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['stepState'] as List? ?? [])) {
        await _isar.db.stepTrackingStateModels.put(_stepStateFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['goals'] as List? ?? [])) {
        await _isar.db.goalModels.put(_goalFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['achievements'] as List? ?? [])) {
        await _isar.db.achievementModels.put(_achievementFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['activityTimeline'] as List? ?? [])) {
        await _isar.db.activityTimelineModels.put(_timelineFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['dailySummaries'] as List? ?? [])) {
        await _isar.db.dailySummaryModels.put(_dailySummaryFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['weeklySummaries'] as List? ?? [])) {
        await _isar.db.weeklySummaryModels.put(_weeklySummaryFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['monthlySummaries'] as List? ?? [])) {
        await _isar.db.monthlySummaryModels.put(_monthlySummaryFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['healthSync'] as List? ?? [])) {
        await _isar.db.healthSyncModels.put(_healthSyncFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['healthPermissions'] as List? ?? [])) {
        await _isar.db.healthPermissionModels.put(_healthPermFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['weightEntries'] as List? ?? [])) {
        await _isar.db.weightEntryModels.put(_weightEntryFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['weightGoals'] as List? ?? [])) {
        await _isar.db.weightGoalModels.put(_weightGoalFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['waterEntries'] as List? ?? [])) {
        await _isar.db.waterEntryModels.put(_waterEntryFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['waterGoals'] as List? ?? [])) {
        await _isar.db.waterGoalModels.put(_waterGoalFrom(raw as Map<String, dynamic>));
      }
      for (final raw in (collections['reminders'] as List? ?? [])) {
        await _isar.db.reminderModels.put(_reminderFrom(raw as Map<String, dynamic>));
      }
    });
  }

  Map<String, dynamic> _user(UserModel m) => {
        'id': m.id, 'name': m.name, 'age': m.age, 'gender': m.gender.name,
        'height': m.height, 'weight': m.weight, 'dailyGoal': m.dailyGoal,
        'strideLength': m.strideLength, 'unit': m.unit.name, 'autoStride': m.autoStride,
        'walkingSpeed': m.walkingSpeed, 'createdAt': m.createdAt.toIso8601String(),
      };

  UserModel _userFrom(Map<String, dynamic> j) => UserModel()
    ..id = j['id'] as int
    ..name = j['name'] as String?
    ..age = j['age'] as int
    ..gender = Gender.values.byName(j['gender'] as String)
    ..height = (j['height'] as num).toDouble()
    ..weight = (j['weight'] as num).toDouble()
    ..dailyGoal = j['dailyGoal'] as int
    ..strideLength = (j['strideLength'] as num?)?.toDouble()
    ..unit = UnitSystem.values.byName(j['unit'] as String)
    ..autoStride = j['autoStride'] as bool
    ..walkingSpeed = (j['walkingSpeed'] as num?)?.toDouble()
    ..createdAt = DateTime.parse(j['createdAt'] as String);

  Map<String, dynamic> _settings(AppSettingsModel m) => {
        'id': m.id, 'theme': m.theme, 'language': m.language,
        'notificationsEnabled': m.notificationsEnabled, 'onboardingComplete': m.onboardingComplete,
        'healthConnected': m.healthConnected, 'currentOnboardingStep': m.currentOnboardingStep.name,
        'appVersion': m.appVersion,
      };

  AppSettingsModel _settingsFrom(Map<String, dynamic> j) => AppSettingsModel()
    ..id = j['id'] as int
    ..theme = j['theme'] as String
    ..language = j['language'] as String
    ..notificationsEnabled = j['notificationsEnabled'] as bool
    ..onboardingComplete = j['onboardingComplete'] as bool
    ..healthConnected = j['healthConnected'] as bool
    ..currentOnboardingStep = OnboardingStep.values.byName(j['currentOnboardingStep'] as String)
    ..appVersion = j['appVersion'] as String;

  Map<String, dynamic> _dailyStep(DailyStepRecordModel m) => {
        'id': m.id, 'date': m.date.toIso8601String(), 'steps': m.steps,
        'hardwareBaseline': m.hardwareBaseline, 'hardwareTotalEnd': m.hardwareTotalEnd,
      };

  DailyStepRecordModel _dailyStepFrom(Map<String, dynamic> j) => DailyStepRecordModel()
    ..id = j['id'] as int
    ..date = DateTime.parse(j['date'] as String)
    ..steps = j['steps'] as int
    ..hardwareBaseline = j['hardwareBaseline'] as int
    ..hardwareTotalEnd = j['hardwareTotalEnd'] as int;

  Map<String, dynamic> _hourlyStep(HourlyStepRecordModel m) => {
        'id': m.id, 'hourStart': m.hourStart.toIso8601String(), 'steps': m.steps,
      };

  HourlyStepRecordModel _hourlyStepFrom(Map<String, dynamic> j) => HourlyStepRecordModel()
    ..id = j['id'] as int
    ..hourStart = DateTime.parse(j['hourStart'] as String)
    ..steps = j['steps'] as int;

  Map<String, dynamic> _stepState(StepTrackingStateModel m) => {
        'id': m.id, 'dailyBaseline': m.dailyBaseline, 'lastHardwareTotal': m.lastHardwareTotal,
        'baselineDate': m.baselineDate.toIso8601String(), 'timezoneId': m.timezoneId,
        'isTracking': m.isTracking, 'isPaused': m.isPaused, 'manualAdjustment': m.manualAdjustment,
      };

  StepTrackingStateModel _stepStateFrom(Map<String, dynamic> j) => StepTrackingStateModel()
    ..id = j['id'] as int
    ..dailyBaseline = j['dailyBaseline'] as int
    ..lastHardwareTotal = j['lastHardwareTotal'] as int
    ..baselineDate = DateTime.parse(j['baselineDate'] as String)
    ..timezoneId = j['timezoneId'] as String
    ..isTracking = j['isTracking'] as bool
    ..isPaused = j['isPaused'] as bool
    ..manualAdjustment = j['manualAdjustment'] as int;

  Map<String, dynamic> _goal(GoalModel m) => {
        'goalId': m.goalId, 'stepGoal': m.stepGoal, 'distanceGoalKm': m.distanceGoalKm,
        'calorieGoal': m.calorieGoal, 'walkingTimeGoalMinutes': m.walkingTimeGoalMinutes,
        'updatedAt': m.updatedAt.toIso8601String(),
      };

  GoalModel _goalFrom(Map<String, dynamic> j) => GoalModel()
    ..goalId = j['goalId'] as int
    ..stepGoal = j['stepGoal'] as int
    ..distanceGoalKm = (j['distanceGoalKm'] as num?)?.toDouble()
    ..calorieGoal = (j['calorieGoal'] as num?)?.toDouble()
    ..walkingTimeGoalMinutes = j['walkingTimeGoalMinutes'] as int?
    ..updatedAt = DateTime.parse(j['updatedAt'] as String);

  Map<String, dynamic> _achievement(AchievementModel m) => {
        'id': m.id, 'ruleId': m.ruleId, 'title': m.title, 'category': m.category,
        'completed': m.completed, 'completedAt': m.completedAt?.toIso8601String(),
        'progress': m.progress, 'xp': m.xp,
      };

  AchievementModel _achievementFrom(Map<String, dynamic> j) => AchievementModel()
    ..id = j['id'] as int
    ..ruleId = j['ruleId'] as String
    ..title = j['title'] as String
    ..category = j['category'] as String
    ..completed = j['completed'] as bool
    ..completedAt = j['completedAt'] != null ? DateTime.parse(j['completedAt'] as String) : null
    ..progress = (j['progress'] as num).toDouble()
    ..xp = j['xp'] as int;

  Map<String, dynamic> _timeline(ActivityTimelineModel m) => {
        'id': m.id, 'dayHourKey': m.dayHourKey, 'date': m.date.toIso8601String(),
        'hour': m.hour, 'steps': m.steps, 'distanceKm': m.distanceKm,
        'calories': m.calories, 'walkingTimeMinutes': m.walkingTimeMinutes,
      };

  ActivityTimelineModel _timelineFrom(Map<String, dynamic> j) => ActivityTimelineModel()
    ..id = j['id'] as int
    ..dayHourKey = j['dayHourKey'] as String
    ..date = DateTime.parse(j['date'] as String)
    ..hour = j['hour'] as int
    ..steps = j['steps'] as int
    ..distanceKm = (j['distanceKm'] as num).toDouble()
    ..calories = (j['calories'] as num).toDouble()
    ..walkingTimeMinutes = j['walkingTimeMinutes'] as int;

  Map<String, dynamic> _dailySummary(DailySummaryModel m) => {
        'id': m.id, 'date': m.date.toIso8601String(), 'steps': m.steps,
        'distanceKm': m.distanceKm, 'calories': m.calories,
        'walkingTimeMinutes': m.walkingTimeMinutes, 'goalCompleted': m.goalCompleted,
      };

  DailySummaryModel _dailySummaryFrom(Map<String, dynamic> j) => DailySummaryModel()
    ..id = j['id'] as int
    ..date = DateTime.parse(j['date'] as String)
    ..steps = j['steps'] as int
    ..distanceKm = (j['distanceKm'] as num).toDouble()
    ..calories = (j['calories'] as num).toDouble()
    ..walkingTimeMinutes = j['walkingTimeMinutes'] as int
    ..goalCompleted = j['goalCompleted'] as bool;

  Map<String, dynamic> _weeklySummary(WeeklySummaryModel m) => {
        'id': m.id, 'week': m.week, 'year': m.year, 'steps': m.steps,
        'distanceKm': m.distanceKm, 'calories': m.calories, 'walkingTimeMinutes': m.walkingTimeMinutes,
      };

  WeeklySummaryModel _weeklySummaryFrom(Map<String, dynamic> j) => WeeklySummaryModel()
    ..id = j['id'] as int
    ..week = j['week'] as int
    ..year = j['year'] as int
    ..steps = j['steps'] as int
    ..distanceKm = (j['distanceKm'] as num).toDouble()
    ..calories = (j['calories'] as num).toDouble()
    ..walkingTimeMinutes = j['walkingTimeMinutes'] as int;

  Map<String, dynamic> _monthlySummary(MonthlySummaryModel m) => {
        'id': m.id, 'month': m.month, 'year': m.year, 'steps': m.steps,
        'distanceKm': m.distanceKm, 'calories': m.calories,
        'walkingTimeMinutes': m.walkingTimeMinutes, 'activeDays': m.activeDays,
      };

  MonthlySummaryModel _monthlySummaryFrom(Map<String, dynamic> j) => MonthlySummaryModel()
    ..id = j['id'] as int
    ..month = j['month'] as int
    ..year = j['year'] as int
    ..steps = j['steps'] as int
    ..distanceKm = (j['distanceKm'] as num).toDouble()
    ..calories = (j['calories'] as num).toDouble()
    ..walkingTimeMinutes = j['walkingTimeMinutes'] as int
    ..activeDays = j['activeDays'] as int;

  Map<String, dynamic> _healthSync(HealthSyncModel m) => {
        'id': m.id, 'lastSync': m.lastSync?.toIso8601String(), 'status': m.status,
        'recordsSynced': m.recordsSynced, 'source': m.source,
        'errorMessage': m.errorMessage, 'lastIncrementalSync': m.lastIncrementalSync?.toIso8601String(),
      };

  HealthSyncModel _healthSyncFrom(Map<String, dynamic> j) => HealthSyncModel()
    ..id = j['id'] as int
    ..lastSync = j['lastSync'] != null ? DateTime.parse(j['lastSync'] as String) : null
    ..status = j['status'] as String
    ..recordsSynced = j['recordsSynced'] as int
    ..source = j['source'] as String
    ..errorMessage = j['errorMessage'] as String?
    ..lastIncrementalSync = j['lastIncrementalSync'] != null
        ? DateTime.parse(j['lastIncrementalSync'] as String)
        : null;

  Map<String, dynamic> _healthPerm(HealthPermissionModel m) => {
        'id': m.id, 'steps': m.steps, 'distance': m.distance, 'calories': m.calories,
        'weight': m.weight, 'height': m.height, 'authorized': m.authorized, 'status': m.status,
      };

  HealthPermissionModel _healthPermFrom(Map<String, dynamic> j) => HealthPermissionModel()
    ..id = j['id'] as int
    ..steps = j['steps'] as bool
    ..distance = j['distance'] as bool
    ..calories = j['calories'] as bool
    ..weight = j['weight'] as bool
    ..height = j['height'] as bool
    ..authorized = j['authorized'] as bool
    ..status = j['status'] as String;

  Map<String, dynamic> _weightEntry(WeightEntryModel m) => {
        'id': m.id, 'date': m.date.toIso8601String(), 'weightKg': m.weightKg,
        'bmi': m.bmi, 'note': m.note,
      };

  WeightEntryModel _weightEntryFrom(Map<String, dynamic> j) => WeightEntryModel()
    ..id = j['id'] as int
    ..date = DateTime.parse(j['date'] as String)
    ..weightKg = (j['weightKg'] as num).toDouble()
    ..bmi = (j['bmi'] as num).toDouble()
    ..note = j['note'] as String?;

  Map<String, dynamic> _weightGoal(WeightGoalModel m) => {
        'id': m.id, 'goalWeightKg': m.goalWeightKg, 'updatedAt': m.updatedAt.toIso8601String(),
      };

  WeightGoalModel _weightGoalFrom(Map<String, dynamic> j) => WeightGoalModel()
    ..id = j['id'] as int
    ..goalWeightKg = (j['goalWeightKg'] as num).toDouble()
    ..updatedAt = DateTime.parse(j['updatedAt'] as String);

  Map<String, dynamic> _waterEntry(WaterEntryModel m) => {
        'id': m.id, 'date': m.date.toIso8601String(), 'time': m.time.toIso8601String(),
        'amountMl': m.amountMl, 'source': m.source, 'note': m.note,
      };

  WaterEntryModel _waterEntryFrom(Map<String, dynamic> j) => WaterEntryModel()
    ..id = j['id'] as int
    ..date = DateTime.parse(j['date'] as String)
    ..time = DateTime.parse(j['time'] as String)
    ..amountMl = j['amountMl'] as int
    ..source = j['source'] as String?
    ..note = j['note'] as String?;

  Map<String, dynamic> _waterGoal(WaterGoalModel m) => {
        'id': m.id, 'dailyGoalLiters': m.dailyGoalLiters, 'updatedAt': m.updatedAt.toIso8601String(),
      };

  WaterGoalModel _waterGoalFrom(Map<String, dynamic> j) => WaterGoalModel()
    ..id = j['id'] as int
    ..dailyGoalLiters = (j['dailyGoalLiters'] as num).toDouble()
    ..updatedAt = DateTime.parse(j['updatedAt'] as String);

  Map<String, dynamic> _reminder(ReminderModel m) => {
        'id': m.id, 'title': m.title, 'description': m.description, 'type': m.type,
        'repeat': m.repeat, 'hour': m.hour, 'minute': m.minute,
        'enabled': m.enabled, 'notificationId': m.notificationId,
      };

  ReminderModel _reminderFrom(Map<String, dynamic> j) => ReminderModel()
    ..id = j['id'] as int
    ..title = j['title'] as String
    ..description = j['description'] as String
    ..type = j['type'] as String
    ..repeat = j['repeat'] as String
    ..hour = j['hour'] as int
    ..minute = j['minute'] as int
    ..enabled = j['enabled'] as bool
    ..notificationId = j['notificationId'] as int;
}
