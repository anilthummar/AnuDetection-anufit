part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.name = '',
    this.age = 25,
    this.gender = Gender.preferNotToSay,
    this.height = 170,
    this.weight = 70,
    this.isSaving = false,
    this.isSaved = false,
    this.error,
  });

  final String name;
  final int age;
  final Gender gender;
  final double height;
  final double weight;
  final bool isSaving;
  final bool isSaved;
  final String? error;

  ProfileState copyWith({
    String? name,
    int? age,
    Gender? gender,
    double? height,
    double? weight,
    bool? isSaving,
    bool? isSaved,
    String? error,
  }) {
    return ProfileState(
      name: name ?? this.name,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      isSaving: isSaving ?? this.isSaving,
      isSaved: isSaved ?? this.isSaved,
      error: error,
    );
  }

  @override
  List<Object?> get props => [name, age, gender, height, weight, isSaving, isSaved, error];
}
