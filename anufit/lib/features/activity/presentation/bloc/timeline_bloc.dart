import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';
import 'package:anufit/features/activity/domain/repository/activity_repository.dart';
import 'package:anufit/features/step_counter/domain/entities/step_data.dart';

part 'timeline_event.dart';
part 'timeline_state.dart';

@injectable
class TimelineBloc extends Bloc<TimelineEvent, TimelineState> {
  TimelineBloc(this._repository) : super(const TimelineInitial()) {
    on<TimelineLoadRequested>(_onLoad);
    on<TimelineFilterChanged>(_onFilterChanged);
  }

  final ActivityRepository _repository;

  Future<void> _onLoad(TimelineLoadRequested event, Emitter<TimelineState> emit) async {
    emit(const TimelineLoading());
    try {
      final summary = await _repository.getTimeline(event.filter, customDate: event.customDate);
      final weekly = await _repository.getWeeklySummaries();
      final heatmap = await _repository.getHeatmapData(event.filter, customDate: event.customDate);
      emit(TimelineLoaded(
        summary: summary,
        filter: event.filter,
        weekly: weekly,
        heatmap: heatmap,
        customDate: event.customDate,
      ));
    } catch (error) {
      emit(TimelineError(error.toString()));
    }
  }

  Future<void> _onFilterChanged(TimelineFilterChanged event, Emitter<TimelineState> emit) async {
    add(TimelineLoadRequested(filter: event.filter, customDate: event.customDate));
  }
}
