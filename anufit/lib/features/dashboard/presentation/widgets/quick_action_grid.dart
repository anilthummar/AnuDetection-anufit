import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class QuickActionGrid extends StatelessWidget {
  const QuickActionGrid({
    required this.trackingStatus,
    required this.isBusy,
    required this.onStartWalk,
    required this.onPause,
    required this.onResume,
    required this.onAddWater,
    required this.onLogWeight,
    super.key,
  });

  final TrackingStatus trackingStatus;
  final bool isBusy;
  final VoidCallback onStartWalk;
  final VoidCallback onPause;
  final VoidCallback onResume;
  final VoidCallback onAddWater;
  final VoidCallback onLogWeight;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Actions',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
        ),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final crossAxisCount = constraints.maxWidth > 500 ? 3 : 2;
            return GridView.count(
              crossAxisCount: crossAxisCount,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: AppSpacing.md,
              crossAxisSpacing: AppSpacing.md,
              childAspectRatio: 1.6,
              children: [
                _ActionTile(
                  label: _trackingLabel(),
                  icon: _trackingIcon(),
                  onPressed: isBusy ? null : _trackingAction(),
                ),
                _ActionTile(
                  label: 'Add Water',
                  icon: Icons.water_drop_outlined,
                  onPressed: isBusy ? null : onAddWater,
                ),
                _ActionTile(
                  label: 'Log Weight',
                  icon: Icons.monitor_weight_outlined,
                  onPressed: isBusy ? null : onLogWeight,
                ),
              ],
            );
          },
        ),
      ],
    );
  }

  String _trackingLabel() {
    return switch (trackingStatus) {
      TrackingStatus.tracking => 'Pause Tracking',
      TrackingStatus.paused => 'Resume Tracking',
      _ => 'Start Walk',
    };
  }

  IconData _trackingIcon() {
    return switch (trackingStatus) {
      TrackingStatus.tracking => Icons.pause_circle_outline,
      TrackingStatus.paused => Icons.play_circle_outline,
      _ => Icons.directions_walk,
    };
  }

  VoidCallback? _trackingAction() {
    return switch (trackingStatus) {
      TrackingStatus.tracking => onPause,
      TrackingStatus.paused => onResume,
      _ => onStartWalk,
    };
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onPressed,
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 28),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
    );
  }
}
