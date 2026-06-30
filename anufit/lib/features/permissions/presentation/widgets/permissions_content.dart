import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/constants/permission_instructions.dart';
import 'package:anufit/app/theme/app_colors.dart';
import 'package:anufit/features/onboarding/presentation/bloc/permission_bloc.dart';
import 'package:anufit/shared/widgets/design_system.dart';

/// Shared permission list used during onboarding and when permissions are revoked.
class PermissionsContent extends StatelessWidget {
  const PermissionsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PermissionBloc, PermissionState>(
      builder: (context, state) {
        return Column(
          children: [
            PermissionItemTile(
              title: 'Activity Recognition',
              subtitle: 'Required to count steps and distance',
              granted: state.activityGranted,
              deniedPermanently: state.activityDeniedPermanently,
              onTap: () => _handleActivityTap(context, state),
            ),
            const SizedBox(height: 12),
            PermissionItemTile(
              title: 'Notifications',
              subtitle: 'Reminders and daily goal updates',
              granted: state.notificationsGranted,
              deniedPermanently: state.notificationsDeniedPermanently,
              onTap: () => _handleNotificationsTap(context, state),
            ),
            const SizedBox(height: 16),
            Text(
              'Tap Allow on each permission. If you denied one earlier, tap the tile '
              'to open Settings and follow the steps shown.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        );
      },
    );
  }

  void _handleActivityTap(BuildContext context, PermissionState state) {
    if (state.activityGranted) return;

    final bloc = context.read<PermissionBloc>();
    if (state.activityDeniedPermanently) {
      bloc.add(const PermissionOpenSettings());
      return;
    }
    bloc.add(const PermissionRequestActivity());
  }

  void _handleNotificationsTap(BuildContext context, PermissionState state) {
    if (state.notificationsGranted) return;

    final bloc = context.read<PermissionBloc>();
    if (state.notificationsDeniedPermanently) {
      bloc.add(const PermissionOpenSettings());
      return;
    }
    bloc.add(const PermissionRequestNotifications());
  }
}

class PermissionItemTile extends StatelessWidget {
  const PermissionItemTile({
    required this.title,
    required this.subtitle,
    required this.granted,
    required this.deniedPermanently,
    required this.onTap,
    super.key,
  });

  final String title;
  final String subtitle;
  final bool granted;
  final bool deniedPermanently;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: granted ? null : onTap,
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                Text(subtitle),
                if (deniedPermanently)
                  Text(
                    title == 'Activity Recognition'
                        ? PermissionInstructions.activityRecognitionInSettings
                        : PermissionInstructions.notificationsInSettings,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppColors.warning,
                          height: 1.35,
                        ),
                  ),
              ],
            ),
          ),
          if (granted)
            const Icon(Icons.check_circle, color: AppColors.success)
          else
            AppButton(
              label: deniedPermanently ? 'Settings' : 'Allow',
              expand: false,
              onPressed: onTap,
            ),
        ],
      ),
    );
  }
}
