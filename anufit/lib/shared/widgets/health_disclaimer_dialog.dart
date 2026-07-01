import 'package:flutter/material.dart';

import 'package:anufit/core/constants/health_disclaimers.dart';

/// Shows required health disclaimers before connecting Apple Health / Health Connect.
Future<bool> showHealthDisclaimerDialog(BuildContext context) async {
  final accepted = await showDialog<bool>(
    context: context,
    barrierDismissible: false,
    builder: (ctx) => const _HealthDisclaimerDialog(),
  );
  return accepted == true;
}

class _HealthDisclaimerDialog extends StatelessWidget {
  const _HealthDisclaimerDialog();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Before you connect'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (final point in HealthDisclaimers.connectBulletPoints) ...[
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('• '),
                  Expanded(child: Text(point)),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Not now'),
        ),
        FilledButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('I understand'),
        ),
      ],
    );
  }
}
