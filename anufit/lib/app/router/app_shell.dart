import 'package:flutter/material.dart';

/// Minimal foundation shell required for [GoRouter] bootstrap.
/// Not a feature screen — replace routes as features are implemented.
class AppShell extends StatelessWidget {
  const AppShell({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox.shrink(),
    );
  }
}
