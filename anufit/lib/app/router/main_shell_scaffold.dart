import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MainShellScaffold extends StatelessWidget {
  const MainShellScaffold({
    required this.navigationShell,
    super.key,
  });

  final StatefulNavigationShell navigationShell;

  static const _tabs = <({IconData icon, IconData selectedIcon, String label})>[
    (icon: Icons.home_outlined, selectedIcon: Icons.home, label: 'Home'),
    (icon: Icons.history, selectedIcon: Icons.history, label: 'History'),
    (icon: Icons.bar_chart_outlined, selectedIcon: Icons.bar_chart, label: 'Stats'),
    (icon: Icons.flag_outlined, selectedIcon: Icons.flag, label: 'Goals'),
    (icon: Icons.person_outline, selectedIcon: Icons.person, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        destinations: [
          for (final tab in _tabs)
            NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.selectedIcon),
              label: tab.label,
            ),
        ],
      ),
    );
  }
}
