import 'package:isar_community/isar.dart';

import 'package:anufit/core/enums/gender.dart';
import 'package:anufit/core/enums/unit_system.dart';
import 'package:anufit/features/onboarding/domain/entities/user_entity.dart';

part 'user_model.g.dart';

@collection
class UserModel {
  Id id = Isar.autoIncrement;

  String? name;

  int age = 0;

  @Enumerated(EnumType.name)
  late Gender gender;

  double height = 0;

  double weight = 0;

  int dailyGoal = 10000;

  double? strideLength;

  @Enumerated(EnumType.name)
  late UnitSystem unit;

  bool autoStride = true;

  double? walkingSpeed;

  late DateTime createdAt;

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      name: name,
      age: age,
      gender: gender,
      height: height,
      weight: weight,
      dailyGoal: dailyGoal,
      strideLength: strideLength,
      unit: unit,
      autoStride: autoStride,
      walkingSpeed: walkingSpeed,
      createdAt: createdAt,
    );
  }

  static UserModel fromEntity(UserEntity entity) {
    return UserModel()
      ..id = entity.id
      ..name = entity.name
      ..age = entity.age
      ..gender = entity.gender
      ..height = entity.height
      ..weight = entity.weight
      ..dailyGoal = entity.dailyGoal
      ..strideLength = entity.strideLength
      ..unit = entity.unit
      ..autoStride = entity.autoStride
      ..walkingSpeed = entity.walkingSpeed
      ..createdAt = entity.createdAt;
  }
}
