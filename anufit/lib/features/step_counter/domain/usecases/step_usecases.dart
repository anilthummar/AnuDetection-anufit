import 'package:injectable/injectable.dart';

import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/features/step_counter/domain/repository/step_repository.dart';

@injectable
class StartStepTrackingUseCase {
  const StartStepTrackingUseCase(this._repository);

  final StepRepository _repository;

  Future<void> call(NoParams params) => _repository.startTracking();
}

@injectable
class StopStepTrackingUseCase {
  const StopStepTrackingUseCase(this._repository);

  final StepRepository _repository;

  Future<void> call(NoParams params) => _repository.stopTracking();
}

@injectable
class PauseTrackingUseCase {
  const PauseTrackingUseCase(this._repository);

  final StepRepository _repository;

  Future<void> call(NoParams params) => _repository.pauseTracking();
}

@injectable
class ResumeTrackingUseCase {
  const ResumeTrackingUseCase(this._repository);

  final StepRepository _repository;

  Future<void> call(NoParams params) => _repository.resumeTracking();
}

@injectable
class ResetTodayStepsUseCase {
  const ResetTodayStepsUseCase(this._repository);

  final StepRepository _repository;

  Future<void> call(NoParams params) => _repository.resetTodaySteps();
}

class AdjustStepsParams {
  const AdjustStepsParams(this.adjustment);

  final int adjustment;
}

@injectable
class AdjustStepsUseCase {
  const AdjustStepsUseCase(this._repository);

  final StepRepository _repository;

  Future<void> call(AdjustStepsParams params) => _repository.adjustSteps(params.adjustment);
}

@injectable
class GetTodayStepsUseCase {
  const GetTodayStepsUseCase(this._repository);

  final StepRepository _repository;

  Future<int> call(NoParams params) => _repository.getTodaySteps();
}

@injectable
class GetWeeklyStepsUseCase {
  const GetWeeklyStepsUseCase(this._repository);

  final StepRepository _repository;

  Future<List<StepPeriodSummary>> call(NoParams params) => _repository.getWeeklySteps();
}

@injectable
class GetMonthlyStepsUseCase {
  const GetMonthlyStepsUseCase(this._repository);

  final StepRepository _repository;

  Future<List<StepPeriodSummary>> call(NoParams params) => _repository.getMonthlySteps();
}

@injectable
class WatchLiveStepsUseCase {
  const WatchLiveStepsUseCase(this._repository);

  final StepRepository _repository;

  Stream<StepData> call(NoParams params) => _repository.watchLiveSteps();
}
