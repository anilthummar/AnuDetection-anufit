import 'dart:io';

import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';
import 'package:anufit/core/services/permission_service.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/shared/widgets/design_system.dart';

/// Explains battery optimization and opens system settings on Android.
class BatteryOptimizationPage extends StatefulWidget {
  const BatteryOptimizationPage({super.key});

  @override
  State<BatteryOptimizationPage> createState() => _BatteryOptimizationPageState();
}

class _BatteryOptimizationPageState extends State<BatteryOptimizationPage> {
  final PermissionService _permissions = getIt<PermissionService>();
  bool _exempt = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  Future<void> _refresh() async {
    if (!Platform.isAndroid) {
      setState(() {
        _loading = false;
        _exempt = true;
      });
      return;
    }
    final exempt = await _permissions.isBatteryOptimizationDisabled();
    if (mounted) {
      setState(() {
        _exempt = exempt;
        _loading = false;
      });
    }
  }

  Future<void> _openSettings() async {
    await _permissions.requestDisableBatteryOptimization();
    await _refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Battery optimization')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keep step counting reliable',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                const Text(
                  'Some phones limit background apps to save battery. '
                  'To count steps accurately while you walk, allow Step Counter '
                  'to run without battery restrictions.',
                ),
                const SizedBox(height: 12),
                const Text(
                  'This does not use GPS and does not track your location. '
                  'A small notification appears only while step tracking is active.',
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          if (_loading)
            const Center(child: CircularProgressIndicator())
          else if (!Platform.isAndroid)
            const Text('Battery optimization settings are managed by iOS. '
                'Keep Background App Refresh enabled for reliable tracking.')
          else if (_exempt)
            Row(
              children: [
                Icon(Icons.check_circle, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Expanded(child: Text('Battery restrictions are disabled for this app.')),
              ],
            )
          else
            AppButton(
              label: 'Open battery settings',
              onPressed: _openSettings,
            ),
          const SizedBox(height: AppSpacing.md),
          if (Platform.isAndroid)
            AppButton(
              label: 'Refresh status',
              variant: AppButtonVariant.secondary,
              onPressed: _refresh,
            ),
        ],
      ),
    );
  }
}
