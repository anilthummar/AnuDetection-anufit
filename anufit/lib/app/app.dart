import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:anufit/app/app_preferences_controller.dart';
import 'package:anufit/app/theme/app_theme.dart';
import 'package:anufit/core/di/injection.dart';
import 'package:anufit/l10n/app_localizations.dart';

class App extends StatefulWidget {
  const App({required this.router, super.key});

  final GoRouter router;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppPreferencesController _preferences;

  @override
  void initState() {
    super.initState();
    _preferences = getIt<AppPreferencesController>();
    _preferences.load();
    _preferences.addListener(_onPreferencesChanged);
  }

  @override
  void dispose() {
    _preferences.removeListener(_onPreferencesChanged);
    super.dispose();
  }

  void _onPreferencesChanged() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Anufit',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: _preferences.themeMode,
      locale: _preferences.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: widget.router,
      builder: (context, child) {
        final media = MediaQuery.of(context);
        return MediaQuery(
          data: media.copyWith(
            textScaler: media.textScaler.clamp(minScaleFactor: 0.9, maxScaleFactor: 1.4),
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
