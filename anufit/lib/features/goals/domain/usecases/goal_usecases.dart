import 'package:injectable/injectable.dart';

import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/goals/domain/entities/goal_entity.dart';
import 'package:anufit/features/goals/domain/repository/goal_repository.dart';

@injectable
class GetGoalUseCase {
  const GetGoalUseCase(this._repository);
  final GoalRepository _repository;
  Future<GoalEntity> call(NoParams params) => _repository.getGoal();
}

@injectable
class UpdateGoalUseCase {
  const UpdateGoalUseCase(this._repository);
  final GoalRepository _repository;
  Future<void> call(GoalEntity goal) => _repository.updateGoal(goal);
}

@injectable
class ResetGoalUseCase {
  const ResetGoalUseCase(this._repository);
  final GoalRepository _repository;
  Future<void> call(NoParams params) => _repository.resetGoal();
}

@injectable
class WatchGoalProgressUseCase {
  const WatchGoalProgressUseCase(this._repository);
  final GoalRepository _repository;
  Stream<GoalProgressEntity> call(NoParams params) => _repository.watchGoalProgress();
}

@injectable
class CalculateCompletionUseCase {
  const CalculateCompletionUseCase(this._repository);
  final GoalRepository _repository;
  Future<double> call(CalculateCompletionParams params) =>
      _repository.calculateCompletion(currentSteps: params.currentSteps);
}

class CalculateCompletionParams {
  const CalculateCompletionParams({this.currentSteps});
  final int? currentSteps;
}

@injectable
class EstimateCompletionTimeUseCase {
  const EstimateCompletionTimeUseCase(this._repository);
  final GoalRepository _repository;
  Future<DateTime?> call(EstimateCompletionParams params) =>
      _repository.estimateCompletionTime(currentSteps: params.currentSteps);
}

class EstimateCompletionParams {
  const EstimateCompletionParams({this.currentSteps});
  final int? currentSteps;
}

@injectable
class GetGoalProgressUseCase {
  const GetGoalProgressUseCase(this._repository);
  final GoalRepository _repository;
  Future<GoalProgressEntity> call(NoParams params) => _repository.getGoalProgress();
}
