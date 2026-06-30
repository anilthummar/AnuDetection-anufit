import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/services/local_notification_service.dart';
import 'package:anufit/features/achievements/domain/entities/achievement_entity.dart';
import 'package:anufit/features/achievements/domain/repository/achievement_repository.dart';

part 'achievement_event.dart';
part 'achievement_state.dart';

@injectable
class AchievementBloc extends Bloc<AchievementEvent, AchievementState> {
  AchievementBloc(this._repository, this._notifications) : super(const AchievementInitial()) {
    on<AchievementLoadRequested>(_onLoad);
    on<AchievementSyncRequested>(_onSync);
  }

  final AchievementRepository _repository;
  final LocalNotificationService _notifications;

  Future<void> _onLoad(AchievementLoadRequested event, Emitter<AchievementState> emit) async {
    emit(const AchievementLoading());
    try {
      final achievements = await _repository.getAchievements();
      final xp = await _repository.getTotalXp();
      emit(AchievementLoaded(achievements: achievements, totalXp: xp));
    } catch (error) {
      emit(AchievementError(error.toString()));
    }
  }

  Future<void> _onSync(AchievementSyncRequested event, Emitter<AchievementState> emit) async {
    final before = await _repository.getAchievements();
    final after = await _repository.evaluateAndSync();
    final xp = await _repository.getTotalXp();
    emit(AchievementLoaded(achievements: after, totalXp: xp));

    for (final item in after) {
      final prev = before.where((b) => b.ruleId == item.ruleId).firstOrNull;
      if (item.completed && (prev == null || !prev.completed)) {
        await _notifications.showAchievementUnlocked(title: item.title, xp: item.xp);
      }
    }
  }
}
