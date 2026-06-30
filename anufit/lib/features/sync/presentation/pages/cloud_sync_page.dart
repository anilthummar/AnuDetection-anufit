import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/features/sync/presentation/bloc/sync_bloc.dart';
import 'package:anufit/l10n/app_localizations.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class CloudSyncPage extends StatelessWidget {
  const CloudSyncPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.cloudSync)),
      body: BlocBuilder<SyncBloc, SyncState>(
        builder: (context, state) {
          return switch (state) {
            SyncLoading() || SyncInitial() => const Center(child: CircularProgressIndicator()),
            SyncLoaded(:final providers) => ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const AppCard(
                    child: Text(
                      'Cloud sync is optional. Your local database remains the source of truth. '
                      'Connect Google Drive or iCloud to upload encrypted backups.',
                    ),
                  ),
                  const SizedBox(height: 16),
                  ...providers.map(
                    (p) => ListTile(
                      leading: Icon(
                        p.name.contains('Google') ? Icons.cloud_outlined : Icons.cloud_queue,
                      ),
                      title: Text(p.name),
                      subtitle: Text(
                        p.available
                            ? (p.connected ? 'Connected' : 'Available — coming soon')
                            : 'Not available on this device',
                      ),
                      trailing: p.connected
                          ? const Icon(Icons.check_circle, color: Colors.green)
                          : null,
                    ),
                  ),
                ],
              ),
          };
        },
      ),
    );
  }
}
