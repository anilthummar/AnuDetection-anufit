import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:anufit/l10n/app_localizations.dart';
import 'package:anufit/shared/widgets/design_system.dart';

class ReleaseInfoPage extends StatelessWidget {
  const ReleaseInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.releaseInfo)),
      body: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          final info = snapshot.data;
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              AppCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Version ${info?.version ?? '—'} (${info?.buildNumber ?? '—'})'),
                    const SizedBox(height: 8),
                    const Text('Anufit Health & Step Tracker'),
                    const Text('Production build — offline-first, privacy-focused'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('Privacy Policy'),
                subtitle: const Text('docs/release/privacy_policy.md'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.store_outlined),
                title: const Text('Store Listing Assets'),
                subtitle: const Text('docs/release/store_assets.md'),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.android_outlined),
                title: const Text('Android Signing Guide'),
                subtitle: const Text('docs/release/android_signing.md'),
                onTap: () {},
              ),
            ],
          );
        },
      ),
    );
  }
}
