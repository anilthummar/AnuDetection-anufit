import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:anufit/core/widget_engine/widget_engine.dart';

part 'widget_event.dart';
part 'widget_state.dart';

@injectable
class WidgetBloc extends Bloc<WidgetEvent, HomeWidgetBlocState> {
  WidgetBloc(this._engine) : super(const HomeWidgetInitial()) {
    on<WidgetSyncRequested>(_onSync);
  }

  final WidgetEngine _engine;

  Future<void> _onSync(WidgetSyncRequested event, Emitter<HomeWidgetBlocState> emit) async {
    emit(const HomeWidgetSyncing());
    try {
      await _engine.syncWidgetData();
      emit(const HomeWidgetSynced());
    } catch (e) {
      emit(HomeWidgetError(e.toString()));
    }
  }
}
