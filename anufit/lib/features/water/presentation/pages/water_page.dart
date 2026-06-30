import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/features/water/presentation/bloc/water_bloc.dart';
import 'package:anufit/features/water/presentation/widgets/water_progress.dart';

class WaterPage extends StatelessWidget {
  const WaterPage({super.key});

  static const _goalOptions = [1.0, 1.5, 2.0, 2.5, 3.0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Water Tracker')),
      body: BlocBuilder<WaterBloc, WaterState>(
        builder: (context, state) {
          return switch (state) {
            WaterLoading() || WaterInitial() => const Center(child: CircularProgressIndicator()),
            WaterError(:final message) => Center(child: Text(message)),
            WaterLoaded(:final dashboard) => ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  WaterProgress(todayMl: dashboard.todayMl, goalLiters: dashboard.goalLiters),
                  const SizedBox(height: 16),
                  Text('Quick Add', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  WaterQuickAdd(
                    onAdd: (ml) => context.read<WaterBloc>().add(WaterAddRequested(ml)),
                  ),
                  const SizedBox(height: 16),
                  Text('Daily Goal', style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    children: _goalOptions
                        .map(
                          (l) => ChoiceChip(
                            label: Text('${l}L'),
                            selected: dashboard.goalLiters == l,
                            onSelected: (_) => context.read<WaterBloc>().add(WaterGoalSetRequested(l)),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  Text('Today', style: Theme.of(context).textTheme.titleMedium),
                  WaterHistoryList(
                    entries: dashboard.history
                        .map((e) => (time: e.time, amountMl: e.amountMl))
                        .toList(),
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}
