part of 'widget_bloc.dart';

sealed class WidgetEvent extends Equatable {
  const WidgetEvent();

  @override
  List<Object?> get props => [];
}

class WidgetSyncRequested extends WidgetEvent {
  const WidgetSyncRequested();
}
