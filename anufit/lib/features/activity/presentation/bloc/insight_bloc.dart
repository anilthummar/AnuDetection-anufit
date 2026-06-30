import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/features/activity/domain/entities/timeline_entity.dart';
import 'package:anufit/features/activity/domain/repository/activity_repository.dart';

part 'insight_event.dart';
part 'insight_state.dart';

@injectable
class InsightBloc extends Bloc<InsightEvent, InsightState> {
  InsightBloc(this._repository) : super(const InsightInitial()) {
    on<InsightLoadRequested>(_onLoad);
  }

  final ActivityRepository _repository;

  Future<void> _onLoad(InsightLoadRequested event, Emitter<InsightState> emit) async {
    emit(const InsightLoading());
    try {
      final insights = await _repository.getInsights();
      emit(InsightLoaded(insights: insights));
    } catch (error) {
      emit(InsightError(error.toString()));
    }
  }
}
