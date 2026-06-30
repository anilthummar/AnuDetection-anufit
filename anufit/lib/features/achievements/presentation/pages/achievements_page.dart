import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/core/widgets/responsive_builder.dart';
import 'package:anufit/features/achievements/presentation/widgets/achievement_dialog.dart';
import 'package:anufit/features/achievements/presentation/bloc/achievement_bloc.dart';
import 'package:anufit/features/achievements/presentation/widgets/achievement_grid.dart';
import 'package:anufit/features/achievements/presentation/widgets/xp_progress_bar.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Achievements'),
        actions: [
          IconButton(
            onPressed: () =>
                context.read<AchievementBloc>().add(const AchievementSyncRequested()),
            icon: const Icon(Icons.sync),
          ),
        ],
      ),
      body: BlocBuilder<AchievementBloc, AchievementState>(
        builder: (context, state) {
          return switch (state) {
            AchievementInitial() || AchievementLoading() =>
              const Center(child: CircularProgressIndicator()),
            AchievementError(:final message) => Center(child: Text(message)),
            AchievementLoaded(:final achievements, :final totalXp) =>
              ResponsiveContainer(
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  children: [
                    XpProgressBar(totalXp: totalXp),
                    const SizedBox(height: AppSpacing.lg),
                    AchievementGrid(
                      achievements: achievements,
                      onTap: (item) => AchievementDialog.show(context, item),
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
