import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/goals/domain/entities/goal_entity.dart';

class GoalSelector extends StatelessWidget {
  const GoalSelector({
    required this.currentGoal,
    required this.onSelected,
    super.key,
  });

  final GoalEntity currentGoal;
  final ValueChanged<GoalEntity> onSelected;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final preset in GoalEntity.stepPresets)
          ChoiceChip(
            label: Text(_format(preset)),
            selected: currentGoal.stepGoal == preset,
            onSelected: (_) => onSelected(
              GoalEntity(stepGoal: preset, updatedAt: DateTime.now()),
            ),
          ),
        ActionChip(
          label: const Text('Custom'),
          onPressed: () => _showCustomDialog(context),
        ),
      ],
    );
  }

  Future<void> _showCustomDialog(BuildContext context) async {
    final controller = TextEditingController(text: '${currentGoal.stepGoal}');
    final value = await showDialog<int>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Custom Step Goal'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.pop(context, int.tryParse(controller.text)),
            child: const Text('Save'),
          ),
        ],
      ),
    );
    if (value != null && value > 0) {
      onSelected(GoalEntity(stepGoal: value, updatedAt: DateTime.now()));
    }
  }

  String _format(int value) => value.toString().replaceAllMapped(
        RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
        (m) => '${m[1]},',
      );
}
