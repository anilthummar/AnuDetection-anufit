import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';

class PermissionTile extends StatelessWidget {
  const PermissionTile({
    required this.label,
    required this.granted,
    super.key,
  });

  final String label;
  final bool granted;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(label),
      trailing: Icon(
        granted ? Icons.check_circle : Icons.cancel_outlined,
        color: granted ? Colors.green : Colors.grey,
      ),
    );
  }
}

class PermissionsSection extends StatelessWidget {
  const PermissionsSection({required this.permissions, super.key});

  final HealthPermissionEntity permissions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PermissionTile(label: 'Steps', granted: permissions.steps),
        PermissionTile(label: 'Distance', granted: permissions.distance),
        PermissionTile(label: 'Calories', granted: permissions.calories),
        PermissionTile(label: 'Weight', granted: permissions.weight),
        PermissionTile(label: 'Height', granted: permissions.height),
        const SizedBox(height: AppSpacing.sm),
        Text('Status: ${permissions.status.name}'),
      ],
    );
  }
}
