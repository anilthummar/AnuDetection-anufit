part of 'achievement_bloc.dart';

sealed class AchievementEvent extends Equatable {
  const AchievementEvent();
  @override
  List<Object?> get props => [];
}

final class AchievementLoadRequested extends AchievementEvent {
  const AchievementLoadRequested();
}

final class AchievementSyncRequested extends AchievementEvent {
  const AchievementSyncRequested();
}
