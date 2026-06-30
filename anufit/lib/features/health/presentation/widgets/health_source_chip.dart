import 'package:flutter/material.dart';

import 'package:anufit/features/health/domain/entities/health_entity.dart';

class HealthSourceChip extends StatelessWidget {
  const HealthSourceChip({required this.platform, super.key});

  final HealthPlatform platform;

  @override
  Widget build(BuildContext context) {
    final label = switch (platform) {
      HealthPlatform.appleHealth => 'Apple Health',
      HealthPlatform.healthConnect => 'Health Connect',
      HealthPlatform.unavailable => 'Unavailable',
    };

    return Chip(
      avatar: const Icon(Icons.favorite, size: 16),
      label: Text(label),
    );
  }
}
