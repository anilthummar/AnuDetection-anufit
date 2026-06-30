part of 'achievement_bloc.dart';

sealed class AchievementState extends Equatable {
  const AchievementState();
  @override
  List<Object?> get props => [];
}

final class AchievementInitial extends AchievementState {
  const AchievementInitial();
}

final class AchievementLoading extends AchievementState {
  const AchievementLoading();
}

final class AchievementLoaded extends AchievementState {
  const AchievementLoaded({required this.achievements, required this.totalXp});
  final List<AchievementEntity> achievements;
  final int totalXp;
  @override
  List<Object?> get props => [achievements, totalXp];
}

final class AchievementError extends AchievementState {
  const AchievementError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
