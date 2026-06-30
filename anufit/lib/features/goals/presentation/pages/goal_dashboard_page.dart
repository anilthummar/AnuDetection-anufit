import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/core/widgets/responsive_builder.dart';
import 'package:anufit/features/goals/domain/entities/goal_entity.dart';
import 'package:anufit/features/goals/presentation/bloc/motivation_goal_bloc.dart';
import 'package:anufit/features/goals/presentation/widgets/goal_card.dart';
import 'package:anufit/features/goals/presentation/widgets/goal_completion_banner.dart';
import 'package:anufit/features/goals/presentation/widgets/goal_progress_ring.dart';
import 'package:anufit/features/goals/presentation/widgets/goal_selector.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class GoalDashboardPage extends StatelessWidget {
  const GoalDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daily Goals')),
      body: BlocBuilder<MotivationGoalBloc, MotivationGoalState>(
        builder: (context, state) {
          return switch (state) {
            MotivationGoalInitial() || MotivationGoalLoading() =>
              const Center(child: CircularProgressIndicator()),
            MotivationGoalError(:final message) => Center(child: Text(message)),
            MotivationGoalLoaded(:final progress) => ResponsiveContainer(
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  children: [
                    if (progress.status == GoalStatus.completed ||
                        progress.status == GoalStatus.exceeded)
                      GoalCompletionBanner(progress: progress),
                    GoalProgressRing(progress: progress),
                    const SizedBox(height: AppSpacing.lg),
                    GoalCard(progress: progress),
                    const SizedBox(height: AppSpacing.lg),
                    GoalSelector(
                      currentGoal: progress.goal,
                      onSelected: (goal) => context.read<MotivationGoalBloc>().add(
                            MotivationGoalUpdateRequested(goal),
                          ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    if (progress.estimatedCompletion != null)
                      Text(
                        'Estimated finish: ${DateFormat.jm().format(progress.estimatedCompletion!)}',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    const SizedBox(height: AppSpacing.md),
                    AppButton(
                      label: 'Reset to Default',
                      variant: AppButtonVariant.secondary,
                      onPressed: () => context
                          .read<MotivationGoalBloc>()
                          .add(const MotivationGoalResetRequested()),
                    ),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
