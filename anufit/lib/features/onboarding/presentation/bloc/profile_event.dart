part of 'profile_bloc.dart';

sealed class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object?> get props => [];
}

final class ProfileLoadExisting extends ProfileEvent {
  const ProfileLoadExisting();
}

final class ProfileNameChanged extends ProfileEvent {
  const ProfileNameChanged(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}

final class ProfileAgeChanged extends ProfileEvent {
  const ProfileAgeChanged(this.age);

  final int age;

  @override
  List<Object?> get props => [age];
}

final class ProfileGenderChanged extends ProfileEvent {
  const ProfileGenderChanged(this.gender);

  final Gender gender;

  @override
  List<Object?> get props => [gender];
}

final class ProfileHeightChanged extends ProfileEvent {
  const ProfileHeightChanged(this.height);

  final double height;

  @override
  List<Object?> get props => [height];
}

final class ProfileWeightChanged extends ProfileEvent {
  const ProfileWeightChanged(this.weight);

  final double weight;

  @override
  List<Object?> get props => [weight];
}

final class ProfileSaveRequested extends ProfileEvent {
  const ProfileSaveRequested();
}

final class ProfileSaveWithGoalRequested extends ProfileEvent {
  const ProfileSaveWithGoalRequested({
    required this.dailyGoal,
    required this.unit,
  });

  final int dailyGoal;
  final UnitSystem unit;

  @override
  List<Object?> get props => [dailyGoal, unit];
}

final class ProfileSaveAcknowledged extends ProfileEvent {
  const ProfileSaveAcknowledged();
}
