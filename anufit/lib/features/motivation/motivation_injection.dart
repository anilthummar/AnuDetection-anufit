import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/di/injection.dart';
import 'package:anufit/features/achievements/presentation/bloc/achievement_bloc.dart';
import 'package:anufit/features/activity/presentation/bloc/insight_bloc.dart';
import 'package:anufit/features/activity/presentation/bloc/timeline_bloc.dart';
import 'package:anufit/features/goals/presentation/bloc/motivation_goal_bloc.dart';

abstract final class GoalsInjection {
  static List<BlocProvider> get providers => [
        BlocProvider<MotivationGoalBloc>(
          create: (_) => getIt<MotivationGoalBloc>()..add(const MotivationGoalLoadRequested()),
        ),
      ];
}

abstract final class ActivityInjection {
  static List<BlocProvider> get providers => [
        BlocProvider<TimelineBloc>(
          create: (_) => getIt<TimelineBloc>()..add(const TimelineLoadRequested()),
        ),
        BlocProvider<InsightBloc>(
          create: (_) => getIt<InsightBloc>()..add(const InsightLoadRequested()),
        ),
      ];
}

abstract final class AchievementsInjection {
  static List<BlocProvider> get providers => [
        BlocProvider<AchievementBloc>(
          create: (_) => getIt<AchievementBloc>()
            ..add(const AchievementLoadRequested())
            ..add(const AchievementSyncRequested()),
        ),
      ];
}
