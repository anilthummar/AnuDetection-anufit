import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:anufit/app/router/app_routes.dart';
import 'package:anufit/core/constants/legal_config.dart';
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
                    const Text('Step Counter - Pedometer'),
                    const Text('Production build — offline-first, privacy-focused'),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text('Privacy Policy'),
                subtitle: const Text('How we handle your health and activity data'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.push(AppRoutes.privacyPolicy),
              ),
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text('Support'),
                subtitle: const Text(LegalConfig.supportEmail),
              ),
              ListTile(
                leading: const Icon(Icons.language_outlined),
                title: const Text('Privacy policy URL'),
                subtitle: const Text(LegalConfig.privacyPolicyUrl),
              ),
            ],
          );
        },
      ),
    );
  }
}
