import 'package:flutter/material.dart';

import 'package:anufit/core/constants/app_spacing.dart';

class DashboardLoadingView extends StatelessWidget {
  const DashboardLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xl),
        child: CircularProgressIndicator(),
      ),
    );
  }
}
