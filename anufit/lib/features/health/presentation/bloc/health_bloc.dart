import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/usecase/usecase.dart';
import 'package:anufit/features/health/domain/entities/health_entity.dart';
import 'package:anufit/features/health/domain/usecases/health_usecases.dart';

part 'health_event.dart';
part 'health_state.dart';

@injectable
class HealthBloc extends Bloc<HealthEvent, HealthState> {
  HealthBloc(this._watchStatus, this._getStatus) : super(const HealthInitial()) {
    on<HealthWatchStarted>(_onWatchStarted);
    on<HealthStatusUpdated>(_onStatusUpdated);
  }

  final WatchHealthStatusUseCase _watchStatus;
  final GetHealthSyncStatusUseCase _getStatus;

  Future<void> _onWatchStarted(
    HealthWatchStarted event,
    Emitter<HealthState> emit,
  ) async {
    emit(const HealthLoading());
    final status = await _getStatus(const NoParams());
    emit(HealthReady(status: status));
    await emit.forEach(
      _watchStatus(const NoParams()),
      onData: (data) {
        add(HealthStatusUpdated(data));
        return HealthReady(status: data);
      },
    );
  }

  void _onStatusUpdated(HealthStatusUpdated event, Emitter<HealthState> emit) {
    emit(HealthReady(status: event.status));
  }
}
