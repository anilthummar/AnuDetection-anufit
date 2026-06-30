import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/entities/streak_info.dart';
import 'package:anufit/core/constants/breakpoints.dart';
import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/utils/unit_format.dart';
import 'package:anufit/core/widgets/responsive_builder.dart';
import 'package:anufit/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:anufit/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:anufit/features/dashboard/presentation/widgets/achievement_preview.dart';
import 'package:anufit/features/dashboard/presentation/widgets/dashboard_error.dart' show DashboardErrorView;
import 'package:anufit/features/dashboard/presentation/widgets/dashboard_header.dart';
import 'package:anufit/features/dashboard/presentation/widgets/dashboard_loading.dart' show DashboardLoadingView;
import 'package:anufit/features/dashboard/presentation/widgets/goal_card.dart';
import 'package:anufit/features/dashboard/presentation/widgets/hourly_chart.dart';
import 'package:anufit/features/dashboard/presentation/widgets/metric_card.dart';
import 'package:anufit/features/dashboard/presentation/widgets/progress_ring.dart';
import 'package:anufit/features/dashboard/presentation/widgets/quick_action_grid.dart';
import 'package:anufit/features/dashboard/presentation/widgets/streak_card.dart';
import 'package:anufit/features/step_counter/domain/entities/hourly_step_point.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/l10n/app_localizations.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).dashboard),
        actions: [
          IconButton(
            tooltip: 'Settings',
            onPressed: () => context.push(AppRoutes.settings),
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listenWhen: (prev, curr) =>
              curr is DashboardLoaded && curr.actionError != null,
          listener: (context, state) {
            if (state is DashboardLoaded && state.actionError != null) {
              AppSnackBar.showError(context, state.actionError!);
            }
          },
          builder: (context, state) {
            return switch (state) {
              DashboardInitial() || DashboardLoading() => const DashboardLoadingView(),
              DashboardError(:final message) => DashboardErrorView(
                  message: message,
                  onRetry: () => context.read<DashboardBloc>().add(const LoadDashboard()),
                ),
              DashboardLoaded(:final isRefreshing) => RefreshIndicator(
                  displacement: 48,
                  onRefresh: () async {
                    final bloc = context.read<DashboardBloc>();
                    bloc.add(const RefreshDashboard());
                    await bloc.stream.firstWhere(
                      (s) => s is DashboardLoaded && !s.isRefreshing,
                    );
                  },
                  child: _DashboardBody(isRefreshing: isRefreshing),
                ),
            };
          },
        ),
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.isRefreshing});

  final bool isRefreshing;

  @override
  Widget build(BuildContext context) {
    return ResponsiveContainer(
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          if (isRefreshing)
            const SliverToBoxAdapter(
              child: LinearProgressIndicator(minHeight: 2),
            ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                BlocSelector<DashboardBloc, DashboardState, String>(
                  selector: (state) =>
                      state is DashboardLoaded ? state.summary.userName : 'Walker',
                  builder: (context, name) => DashboardHeader(userName: name),
                ),
                const SizedBox(height: AppSpacing.xl),
                BlocSelector<DashboardBloc, DashboardState, (int, int, double)>(
                  selector: (state) {
                    if (state is! DashboardLoaded) return (0, 10000, 0.0);
                    final s = state.summary;
                    return (s.todaySteps, s.goal, s.completionPercentage);
                  },
                  builder: (context, data) {
                    return ProgressRing(
                      currentSteps: data.$1,
                      goalSteps: data.$2,
                      percentage: data.$3,
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                const _MetricsGrid(),
                const SizedBox(height: AppSpacing.lg),
                BlocSelector<DashboardBloc, DashboardState, List<HourlyStepPoint>>(
                  selector: (state) =>
                      state is DashboardLoaded ? state.summary.hourlySteps : const [],
                  builder: (context, hourly) => HourlyActivityChart(hourlySteps: hourly),
                ),
                const SizedBox(height: AppSpacing.lg),
                BlocSelector<DashboardBloc, DashboardState, GoalProgress?>(
                  selector: (state) =>
                      state is DashboardLoaded ? state.summary.goalProgress : null,
                  builder: (context, progress) {
                    if (progress == null) return const SizedBox.shrink();
                    return GoalCard(progress: progress);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                BlocSelector<DashboardBloc, DashboardState, StreakInfo?>(
                  selector: (state) =>
                      state is DashboardLoaded ? state.summary.streak : null,
                  builder: (context, streak) {
                    if (streak == null) return const SizedBox.shrink();
                    return StreakCard(streak: streak);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                BlocSelector<DashboardBloc, DashboardState, List<Achievement>>(
                  selector: (state) =>
                      state is DashboardLoaded ? state.summary.achievements : const [],
                  builder: (context, achievements) =>
                      AchievementPreview(achievements: achievements),
                ),
                const SizedBox(height: AppSpacing.lg),
                BlocSelector<DashboardBloc, DashboardState, (TrackingStatus, bool)>(
                  selector: (state) {
                    if (state is! DashboardLoaded) {
                      return (TrackingStatus.idle, false);
                    }
                    return (state.summary.trackingStatus, state.isActionBusy);
                  },
                  builder: (context, data) {
                    return QuickActionGrid(
                      trackingStatus: data.$1,
                      isBusy: data.$2,
                      onStartWalk: () => context
                          .read<DashboardBloc>()
                          .add(const DashboardStartWalkRequested()),
                      onPause: () => context
                          .read<DashboardBloc>()
                          .add(const DashboardPauseTrackingRequested()),
                      onResume: () => context
                          .read<DashboardBloc>()
                          .add(const DashboardResumeTrackingRequested()),
                      onAddWater: () => context.push(AppRoutes.water),
                      onLogWeight: () => context.push(AppRoutes.weight),
                    );
                  },
                ),
                const SizedBox(height: AppSpacing.xxxl),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MetricsGrid extends StatelessWidget {
  const _MetricsGrid();

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, deviceType) {
        final crossAxisCount = deviceType == DeviceType.phone ? 2 : 4;
        return BlocSelector<DashboardBloc, DashboardState, (int, double, double, Duration, UnitSystem)>(
          selector: (state) {
            if (state is! DashboardLoaded) {
              return (0, 0, 0, Duration.zero, UnitSystem.metric);
            }
            final s = state.summary;
            return (s.todaySteps, s.calories, s.distanceKm, s.walkingTime, s.unit);
          },
          builder: (context, metrics) {
            final distanceValue = UnitFormat.displayDistance(metrics.$3, metrics.$5);
            final distanceUnit = UnitFormat.distanceUnit(metrics.$5);
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.1,
              children: [
                MetricCard(
                  label: 'Steps',
                  value: _formatInt(metrics.$1),
                  icon: Icons.directions_walk,
                ),
                MetricCard(
                  label: 'Calories',
                  value: metrics.$2.round().toString(),
                  unit: 'kcal',
                  icon: Icons.local_fire_department_outlined,
                ),
                MetricCard(
                  label: 'Distance',
                  value: distanceValue.toStringAsFixed(2),
                  unit: distanceUnit,
                  icon: Icons.route_outlined,
                ),
                MetricCard(
                  label: 'Walking Time',
                  value: _formatDuration(metrics.$4),
                  icon: Icons.timer_outlined,
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatInt(int value) => value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]},',
      );

  String _formatDuration(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    if (hours > 0) return '${hours}h ${minutes}m';
    if (duration.inMinutes > 0) return '${duration.inMinutes}m';
    if (duration.inSeconds > 0) return '${duration.inSeconds}s';
    return '0m';
  }
}
