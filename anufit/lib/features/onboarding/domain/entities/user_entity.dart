import 'package:equatable/equatable.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.id,
    this.name,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.dailyGoal,
    this.strideLength,
    required this.unit,
    required this.autoStride,
    this.walkingSpeed,
    required this.createdAt,
  });

  final int id;
  final String? name;
  final int age;
  final Gender gender;
  final double height;
  final double weight;
  final int dailyGoal;
  final double? strideLength;
  final UnitSystem unit;
  final bool autoStride;
  final double? walkingSpeed;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        id,
        name,
        age,
        gender,
        height,
        weight,
        dailyGoal,
        strideLength,
        unit,
        autoStride,
        walkingSpeed,
        createdAt,
      ];
}
