import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/shared/widgets/design_system.dart';

/// Displays multi-line permission guidance with an optional action button.
class PermissionGuideCard extends StatelessWidget {
  const PermissionGuideCard({
    required this.message,
    required this.actionLabel,
    required this.onAction,
    super.key,
  });

  final String message;
  final String actionLabel;
  final VoidCallback onAction;

  @override
  Widget build(BuildContext context) {
    final lines = message.split('\n');
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (final line in lines)
            Padding(
              padding: EdgeInsets.only(
                bottom: line == lines.last ? AppSpacing.sm : AppSpacing.xs,
              ),
              child: Text(
                line,
                style: line.startsWith('Follow these steps:')
                    ? Theme.of(context).textTheme.titleSmall
                    : Theme.of(context).textTheme.bodyMedium?.copyWith(
                          height: line.startsWith(RegExp(r'\d\.')) ? 1.35 : 1.4,
                          fontWeight: line.startsWith(RegExp(r'\d\.'))
                              ? FontWeight.w500
                              : FontWeight.normal,
                        ),
              ),
            ),
          AppButton(
            label: actionLabel,
            variant: AppButtonVariant.secondary,
            onPressed: onAction,
          ),
        ],
      ),
    );
  }
}
