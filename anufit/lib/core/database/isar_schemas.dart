import 'package:isar_community/isar.dart';

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
import 'package:anufit/features/water/data/models/water_entry_model.dart';
import 'package:anufit/features/water/data/models/water_goal_model.dart';
import 'package:anufit/features/weight/data/models/weight_entry_model.dart';
import 'package:anufit/features/weight/data/models/weight_goal_model.dart';
import 'package:anufit/features/step_counter/data/models/hourly_step_record_model.dart';
import 'package:anufit/features/step_counter/data/models/step_tracking_state_model.dart';

/// All Isar collection schemas registered at app startup.
final List<CollectionSchema<dynamic>> isarSchemas = <CollectionSchema<dynamic>>[
  UserModelSchema,
  AppSettingsModelSchema,
  DailyStepRecordModelSchema,
  HourlyStepRecordModelSchema,
  StepTrackingStateModelSchema,
  GoalModelSchema,
  AchievementModelSchema,
  ActivityTimelineModelSchema,
  DailySummaryModelSchema,
  WeeklySummaryModelSchema,
  MonthlySummaryModelSchema,
  HealthSyncModelSchema,
  HealthPermissionModelSchema,
  WeightEntryModelSchema,
  WeightGoalModelSchema,
  WaterEntryModelSchema,
  WaterGoalModelSchema,
  ReminderModelSchema,
];
