import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/l10n/app_localizations.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class ExportHubPage extends StatelessWidget {
  const ExportHubPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.export)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          AppCard(
            onTap: () => context.push(AppRoutes.reports),
            child: const ListTile(
              leading: Icon(Icons.picture_as_pdf_outlined),
              title: Text('Activity Reports'),
              subtitle: Text('PDF, CSV, and Excel with preview and share'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 12),
          AppCard(
            onTap: () => context.push(AppRoutes.backup),
            child: const ListTile(
              leading: Icon(Icons.backup_outlined),
              title: Text('Full Data Backup'),
              subtitle: Text('Encrypted JSON export of all local data'),
              trailing: Icon(Icons.chevron_right),
            ),
          ),
        ],
      ),
    );
  }
}
