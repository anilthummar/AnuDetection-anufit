import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/services/local_notification_service.dart';
import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/goals/domain/entities/goal_entity.dart';
import 'package:anufit/features/goals/domain/usecases/goal_usecases.dart';

part 'motivation_goal_event.dart';
part 'motivation_goal_state.dart';

@injectable
class MotivationGoalBloc extends Bloc<MotivationGoalEvent, MotivationGoalState> {
  MotivationGoalBloc(
    this._updateGoal,
    this._resetGoal,
    this._watchProgress,
    this._notifications,
  ) : super(const MotivationGoalInitial()) {
    on<MotivationGoalLoadRequested>(_onLoad);
    on<MotivationGoalUpdateRequested>(_onUpdate);
    on<MotivationGoalResetRequested>(_onReset);
    on<MotivationGoalProgressUpdated>(_onProgressUpdated);
  }

  final UpdateGoalUseCase _updateGoal;
  final ResetGoalUseCase _resetGoal;
  final WatchGoalProgressUseCase _watchProgress;
  final LocalNotificationService _notifications;

  StreamSubscription<GoalProgressEntity>? _subscription;
  bool _halfwayNotified = false;
  bool _completedNotified = false;

  Future<void> _onLoad(
    MotivationGoalLoadRequested event,
    Emitter<MotivationGoalState> emit,
  ) async {
    emit(const MotivationGoalLoading());
    try {
      final progress = await _watchProgress(const NoParams()).first;
      emit(MotivationGoalLoaded(progress: progress));
      await _subscription?.cancel();
      _subscription = _watchProgress(const NoParams()).listen(
        (p) => add(MotivationGoalProgressUpdated(p)),
      );
    } catch (error) {
      emit(MotivationGoalError(error.toString()));
    }
  }

  Future<void> _onUpdate(
    MotivationGoalUpdateRequested event,
    Emitter<MotivationGoalState> emit,
  ) async {
    await _updateGoal(event.goal);
    add(const MotivationGoalLoadRequested());
  }

  Future<void> _onReset(
    MotivationGoalResetRequested event,
    Emitter<MotivationGoalState> emit,
  ) async {
    await _resetGoal(const NoParams());
    _halfwayNotified = false;
    _completedNotified = false;
    add(const MotivationGoalLoadRequested());
  }

  Future<void> _onProgressUpdated(
    MotivationGoalProgressUpdated event,
    Emitter<MotivationGoalState> emit,
  ) async {
    final progress = event.progress;
    emit(MotivationGoalLoaded(progress: progress));

    final goal = progress.goal.stepGoal;
    final steps = progress.currentSteps;
    if (!_halfwayNotified && steps >= goal ~/ 2 && steps < goal) {
      _halfwayNotified = true;
      await _notifications.showHalfwayToGoal(steps: steps, goal: goal);
    }
    if (!_completedNotified &&
        (progress.status == GoalStatus.completed ||
            progress.status == GoalStatus.exceeded)) {
      _completedNotified = true;
      await _notifications.showGoalCompleted(steps: steps, goal: goal);
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
