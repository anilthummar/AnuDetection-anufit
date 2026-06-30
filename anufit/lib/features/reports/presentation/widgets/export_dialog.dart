import 'package:flutter/material.dart';

import 'package:anufit/features/reports/domain/entities/report_entity.dart';

class ExportDialog extends StatelessWidget {
  const ExportDialog({
    required this.onExport,
    super.key,
  });

  final ValueChanged<ExportFormat> onExport;

  static Future<void> show(
    BuildContext context, {
    required ValueChanged<ExportFormat> onExport,
  }) {
    return showDialog<void>(
      context: context,
      builder: (_) => ExportDialog(onExport: onExport),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Export Report'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ExportFormat.values
            .map(
              (format) => ListTile(
                title: Text(format.name.toUpperCase()),
                onTap: () {
                  Navigator.pop(context);
                  onExport(format);
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
