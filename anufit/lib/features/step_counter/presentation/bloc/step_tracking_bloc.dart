import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/exceptions/app_exception.dart';
import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';
import 'package:anufit/features/step_counter/domain/usecases/step_usecases.dart';

part 'step_tracking_event.dart';
part 'step_tracking_state.dart';

@injectable
class StepTrackingBloc extends Bloc<StepTrackingEvent, StepTrackingState> {
  StepTrackingBloc(
    this._startTracking,
    this._stopTracking,
    this._pauseTracking,
    this._resumeTracking,
    this._resetTodaySteps,
    this._adjustSteps,
    this._getTodaySteps,
    this._getWeeklySteps,
    this._getMonthlySteps,
    this._watchLiveSteps,
  ) : super(StepTrackingState.initial()) {
    on<StepTrackingLiveUpdate>(_onLiveUpdate);
    on<StepTrackingStartRequested>(_onStart);
    on<StepTrackingStopRequested>(_onStop);
    on<StepTrackingPauseRequested>(_onPause);
    on<StepTrackingResumeRequested>(_onResume);
    on<StepTrackingResetRequested>(_onReset);
    on<StepTrackingAdjustRequested>(_onAdjust);
    on<StepTrackingRefreshSummariesRequested>(_onRefreshSummaries);
    on<StepTrackingErrorOccurred>(_onError);

    _liveSubscription = _watchLiveSteps(const NoParams()).listen(
      (data) => add(StepTrackingLiveUpdate(data)),
      onError: (Object error, StackTrace stack) {
        add(StepTrackingErrorOccurred(error.toString()));
      },
    );
  }

  final StartStepTrackingUseCase _startTracking;
  final StopStepTrackingUseCase _stopTracking;
  final PauseTrackingUseCase _pauseTracking;
  final ResumeTrackingUseCase _resumeTracking;
  final ResetTodayStepsUseCase _resetTodaySteps;
  final AdjustStepsUseCase _adjustSteps;
  final GetTodayStepsUseCase _getTodaySteps;
  final GetWeeklyStepsUseCase _getWeeklySteps;
  final GetMonthlyStepsUseCase _getMonthlySteps;
  final WatchLiveStepsUseCase _watchLiveSteps;

  late final StreamSubscription<StepData> _liveSubscription;

  void _onLiveUpdate(StepTrackingLiveUpdate event, Emitter<StepTrackingState> emit) {
    emit(state.copyWith(liveData: event.data, clearError: true));
  }

  Future<void> _onStart(
    StepTrackingStartRequested event,
    Emitter<StepTrackingState> emit,
  ) async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      await _startTracking(const NoParams());
      emit(state.copyWith(isBusy: false));
    } on AppException catch (error) {
      emit(state.copyWith(isBusy: false, errorMessage: error.message));
    }
  }

  Future<void> _onStop(
    StepTrackingStopRequested event,
    Emitter<StepTrackingState> emit,
  ) async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      await _stopTracking(const NoParams());
      emit(state.copyWith(isBusy: false));
    } on AppException catch (error) {
      emit(state.copyWith(isBusy: false, errorMessage: error.message));
    }
  }

  Future<void> _onPause(
    StepTrackingPauseRequested event,
    Emitter<StepTrackingState> emit,
  ) async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      await _pauseTracking(const NoParams());
      emit(state.copyWith(isBusy: false));
    } on AppException catch (error) {
      emit(state.copyWith(isBusy: false, errorMessage: error.message));
    }
  }

  Future<void> _onResume(
    StepTrackingResumeRequested event,
    Emitter<StepTrackingState> emit,
  ) async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      await _resumeTracking(const NoParams());
      emit(state.copyWith(isBusy: false));
    } on AppException catch (error) {
      emit(state.copyWith(isBusy: false, errorMessage: error.message));
    }
  }

  Future<void> _onReset(
    StepTrackingResetRequested event,
    Emitter<StepTrackingState> emit,
  ) async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      await _resetTodaySteps(const NoParams());
      await _refreshSummaries(emit);
      emit(state.copyWith(isBusy: false));
    } on AppException catch (error) {
      emit(state.copyWith(isBusy: false, errorMessage: error.message));
    }
  }

  Future<void> _onAdjust(
    StepTrackingAdjustRequested event,
    Emitter<StepTrackingState> emit,
  ) async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      await _adjustSteps(AdjustStepsParams(event.adjustment));
      emit(state.copyWith(isBusy: false));
    } on AppException catch (error) {
      emit(state.copyWith(isBusy: false, errorMessage: error.message));
    }
  }

  Future<void> _onRefreshSummaries(
    StepTrackingRefreshSummariesRequested event,
    Emitter<StepTrackingState> emit,
  ) async {
    emit(state.copyWith(isBusy: true, clearError: true));
    try {
      await _refreshSummaries(emit);
      emit(state.copyWith(isBusy: false));
    } on AppException catch (error) {
      emit(state.copyWith(isBusy: false, errorMessage: error.message));
    }
  }

  void _onError(StepTrackingErrorOccurred event, Emitter<StepTrackingState> emit) {
    emit(state.copyWith(errorMessage: event.message));
  }

  Future<void> _refreshSummaries(Emitter<StepTrackingState> emit) async {
    final today = await _getTodaySteps(const NoParams());
    final weekly = await _getWeeklySteps(const NoParams());
    final monthly = await _getMonthlySteps(const NoParams());
    emit(
      state.copyWith(
        todaySteps: today,
        weeklySteps: weekly,
        monthlySteps: monthly,
      ),
    );
  }

  @override
  Future<void> close() {
    _liveSubscription.cancel();
    return super.close();
  }
}
