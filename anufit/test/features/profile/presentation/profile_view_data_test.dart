import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';
import 'package:anufit/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ProfileViewData', () {
    final user = UserEntity(
      id: 1,
      name: 'Alex',
      age: 30,
      gender: Gender.male,
      height: 175,
      weight: 72,
      dailyGoal: 8000,
      strideLength: null,
      unit: UnitSystem.metric,
      autoStride: true,
      walkingSpeed: null,
      createdAt: DateTime(2024),
    );

    test('derives BMI from profile', () {
      final view = ProfileViewData(user: user);
      expect(view.bmi, closeTo(23.5, 0.2));
      expect(view.bmiCategory.name, 'healthy');
    });

    test('estimates stride when auto enabled', () {
      final view = ProfileViewData(user: user);
      expect(view.strideMeters, greaterThan(0.6));
    });
  });
}
