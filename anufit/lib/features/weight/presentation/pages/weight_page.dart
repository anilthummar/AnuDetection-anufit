import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/core/services/health_metrics_engine.dart';
import 'package:anufit/core/utils/unit_format.dart';
import 'package:anufit/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:anufit/features/weight/domain/entities/weight_entity.dart';
import 'package:anufit/features/weight/presentation/bloc/weight_bloc.dart';
import 'package:anufit/features/weight/presentation/widgets/weight_card.dart';
import 'package:anufit/features/weight/presentation/widgets/weight_chart.dart';
import 'package:anufit/shared/widgets/design_system.dart';
import 'package:anufit/core/di/injection.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({super.key});

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  UnitSystem _unit = UnitSystem.metric;

  @override
  void initState() {
    super.initState();
    _loadUnit();
  }

  Future<void> _loadUnit() async {
    final user = await getIt<OnboardingRepository>().getUser();
    if (mounted && user != null) setState(() => _unit = user.unit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weight Tracking')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showLogDialog(context),
        icon: const Icon(Icons.add),
        label: const Text('Log Weight'),
      ),
      body: BlocBuilder<WeightBloc, WeightState>(
        builder: (context, state) {
          return switch (state) {
            WeightLoading() || WeightInitial() => const Center(child: CircularProgressIndicator()),
            WeightError(:final message) => Center(child: Text(message)),
            WeightLoaded(:final dashboard, :final chartPeriod) => ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  WeightCard(weightKg: dashboard.currentWeightKg, unit: _unit),
                  const SizedBox(height: 12),
                  GoalWeightCard(
                    goalKg: dashboard.goalWeightKg,
                    remainingKg: dashboard.remainingKg,
                    unit: _unit,
                  ),
                  const SizedBox(height: 12),
                  BmiCard(bmi: dashboard.bmi, category: dashboard.category),
                  const SizedBox(height: 12),
                  _healthyRange(context, dashboard),
                  const SizedBox(height: 12),
                  SegmentedButton<WeightChartPeriod>(
                    segments: const [
                      ButtonSegment(value: WeightChartPeriod.weekly, label: Text('Week')),
                      ButtonSegment(value: WeightChartPeriod.monthly, label: Text('Month')),
                      ButtonSegment(value: WeightChartPeriod.yearly, label: Text('Year')),
                    ],
                    selected: {chartPeriod},
                    onSelectionChanged: (s) => context
                        .read<WeightBloc>()
                        .add(WeightChartPeriodChanged(s.first)),
                  ),
                  const SizedBox(height: 12),
                  WeightChart(history: dashboard.history, period: chartPeriod, unit: _unit),
                  const SizedBox(height: 12),
                  Text('History', style: Theme.of(context).textTheme.titleMedium),
                  ...dashboard.history.take(10).map(
                        (e) => ListTile(
                          title: Text(UnitFormat.weightLabel(e.weightKg, _unit)),
                          subtitle: Text(
                            '${e.date.toLocal().toString().split(' ').first} · BMI ${e.bmi.toStringAsFixed(1)}',
                          ),
                        ),
                      ),
                ],
              ),
          };
        },
      ),
    );
  }

  Widget _healthyRange(BuildContext context, WeightDashboardEntity dashboard) {
    return FutureBuilder(
      future: getIt<OnboardingRepository>().getUser(),
      builder: (context, snap) {
        final height = snap.data?.height ?? 170.0;
        final range = HealthMetricsEngine.healthyWeightRangeKg(height);
        return AppCard(
          child: Text(
            'Healthy range: ${UnitFormat.weightLabel(range.minKg, _unit)} – ${UnitFormat.weightLabel(range.maxKg, _unit)}',
          ),
        );
      },
    );
  }

  Future<void> _showLogDialog(BuildContext context) async {
    final controller = TextEditingController();
    final noteController = TextEditingController();
    final weight = await showDialog<double>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log Weight'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppTextField(
              label: _unit == UnitSystem.imperial ? 'Weight (lb)' : 'Weight (kg)',
              controller: controller,
              keyboardType: TextInputType.number,
            ),
            AppTextField(label: 'Notes', controller: noteController),
          ],
        ),
        actions: [
          TextButton(onPressed: () => ctx.pop(), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              final raw = double.tryParse(controller.text);
              if (raw == null) return;
              final kg = _unit == UnitSystem.imperial ? raw / 2.20462 : raw;
              ctx.pop(kg);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (weight != null && context.mounted) {
      context.read<WeightBloc>().add(
            WeightLogRequested(weightKg: weight, note: noteController.text.isEmpty ? null : noteController.text),
          );
    }
  }
}
