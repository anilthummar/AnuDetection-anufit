import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/exceptions/app_exception.dart';
import 'package:anufit/core/services/permission_service.dart';
import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/dashboard/domain/entities/dashboard_summary.dart';
import 'package:anufit/features/dashboard/domain/services/dashboard_calculators.dart';
import 'package:anufit/features/dashboard/domain/usecases/dashboard_usecases.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

@injectable
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(
    this._getTodaySummary,
    this._watchLiveSteps,
    this._getDistance,
    this._getWalkingTime,
    this._getHourlySteps,
    this._startTracking,
    this._pauseTracking,
    this._resumeTracking,
    this._permissions,
  ) : super(const DashboardInitial()) {
    on<LoadDashboard>(_onLoad);
    on<RefreshDashboard>(_onRefresh);
    on<LiveStepsUpdated>(_onLiveStepsUpdated);
    on<GoalChanged>(_onGoalChanged);
    on<HealthSyncCompleted>(_onHealthSyncCompleted);
    on<UserProfileUpdated>(_onUserProfileUpdated);
    on<DashboardStartWalkRequested>(_onStartWalk);
    on<DashboardPauseTrackingRequested>(_onPause);
    on<DashboardResumeTrackingRequested>(_onResume);
  }

  final GetTodaySummaryUseCase _getTodaySummary;
  final DashboardWatchLiveStepsUseCase _watchLiveSteps;
  final GetDistanceUseCase _getDistance;
  final GetWalkingTimeUseCase _getWalkingTime;
  final GetHourlyStepsUseCase _getHourlySteps;
  final DashboardStartTrackingUseCase _startTracking;
  final DashboardPauseTrackingUseCase _pauseTracking;
  final DashboardResumeTrackingUseCase _resumeTracking;
  final PermissionService _permissions;

  StreamSubscription<StepData>? _liveSubscription;
  StepData? _lastLiveStepEvent;

  Future<void> _onLoad(LoadDashboard event, Emitter<DashboardState> emit) async {
    emit(const DashboardLoading());
    await _loadSummary(emit, startLiveStream: true);
  }

  Future<void> _onRefresh(RefreshDashboard event, Emitter<DashboardState> emit) async {
    final current = state;
    if (current is DashboardLoaded) {
      emit(current.copyWith(isRefreshing: true));
    } else {
      emit(const DashboardLoading());
    }
    await _loadSummary(emit, startLiveStream: false);
  }

  Future<void> _onLiveStepsUpdated(
    LiveStepsUpdated event,
    Emitter<DashboardState> emit,
  ) async {
    final current = state;
    if (current is! DashboardLoaded) return;

    final data = event.data;
    final summary = current.summary;

    // Ignore duplicate sensor ticks — only react when steps or tracking status change.
    if (data.todaySteps == summary.todaySteps &&
        data.status == summary.trackingStatus) {
      return;
    }

    final steps = data.todaySteps;
    final now = data.timestamp;
    final calories = ActivityMetricsCalculator.calories(steps);
    final completion = ActivityMetricsCalculator.completionPercentage(
      current: steps,
      goal: summary.goal,
    );
    final estimatedCompletion = ActivityMetricsCalculator.estimatedCompletion(
      todaySteps: steps,
      goal: summary.goal,
      now: now,
    );

    final distance = await _getDistance(GetMetricParams(steps: steps));
    final walkingTime = await _getWalkingTime(GetMetricParams(steps: steps));

    var hourly = summary.hourlySteps;
    if (steps > summary.todaySteps) {
      hourly = await _getHourlySteps(const NoParams());
    }

    emit(
      current.copyWith(
        summary: summary.copyWith(
          todaySteps: steps,
          calories: calories,
          distanceKm: distance,
          walkingTime: walkingTime,
          completionPercentage: completion,
          estimatedCompletion: estimatedCompletion,
          hourlySteps: hourly,
          trackingStatus: data.status,
          lastUpdated: now,
        ),
      ),
    );
  }

  Future<void> _onGoalChanged(GoalChanged event, Emitter<DashboardState> emit) async {
    await _loadSummary(emit, startLiveStream: false);
  }

  Future<void> _onHealthSyncCompleted(
    HealthSyncCompleted event,
    Emitter<DashboardState> emit,
  ) async {
    await _loadSummary(emit, startLiveStream: false);
  }

  Future<void> _onUserProfileUpdated(
    UserProfileUpdated event,
    Emitter<DashboardState> emit,
  ) async {
    await _loadSummary(emit, startLiveStream: false);
  }

  Future<void> _onStartWalk(
    DashboardStartWalkRequested event,
    Emitter<DashboardState> emit,
  ) async {
    await _runTrackingAction(emit, (params) => _startTracking(params));
  }

  Future<void> _onPause(
    DashboardPauseTrackingRequested event,
    Emitter<DashboardState> emit,
  ) async {
    await _runTrackingAction(emit, (params) => _pauseTracking(params));
  }

  Future<void> _onResume(
    DashboardResumeTrackingRequested event,
    Emitter<DashboardState> emit,
  ) async {
    await _runTrackingAction(emit, (params) => _resumeTracking(params));
  }

  Future<void> _loadSummary(
    Emitter<DashboardState> emit, {
    required bool startLiveStream,
  }) async {
    try {
      final summary = await _getTodaySummary(const NoParams());
      emit(DashboardLoaded(summary: summary));

      final activity = await _permissions.checkPermission(AppPermissionType.activityRecognition);
      if (activity.isGranted && summary.trackingStatus != TrackingStatus.tracking) {
        try {
          await _startTracking(const NoParams());
        } catch (_) {}
      }

      if (startLiveStream) {
        await _liveSubscription?.cancel();
        _lastLiveStepEvent = null;
        _liveSubscription = _watchLiveSteps(const NoParams()).listen(
          (data) {
            if (_lastLiveStepEvent != null &&
                _lastLiveStepEvent!.todaySteps == data.todaySteps &&
                _lastLiveStepEvent!.status == data.status) {
              return;
            }
            _lastLiveStepEvent = data;
            add(LiveStepsUpdated(data));
          },
          onError: (Object error, StackTrace stack) {
            add(DashboardErrorOccurred(error.toString()));
          },
        );
      }
    } on AppException catch (error) {
      emit(DashboardError(message: error.message));
    } catch (error) {
      emit(DashboardError(message: error.toString()));
    }
  }

  Future<void> _runTrackingAction(
    Emitter<DashboardState> emit,
    Future<void> Function(NoParams) action,
  ) async {
    final current = state;
    if (current is DashboardLoaded) {
      emit(current.copyWith(isActionBusy: true));
    }
    try {
      await action(const NoParams());
    } on AppException catch (error) {
      if (current is DashboardLoaded) {
        emit(current.copyWith(isActionBusy: false, actionError: error.message));
      }
    } catch (error) {
      if (current is DashboardLoaded) {
        emit(current.copyWith(isActionBusy: false, actionError: error.toString()));
      }
    } finally {
      final latest = state;
      if (latest is DashboardLoaded && latest.isActionBusy) {
        emit(latest.copyWith(isActionBusy: false, clearActionError: true));
      }
    }
  }

  String get greeting => greetingForHour(DateTime.now().hour);

  @override
  Future<void> close() {
    _liveSubscription?.cancel();
    return super.close();
  }
}
