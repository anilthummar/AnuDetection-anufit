part of 'widget_bloc.dart';

sealed class HomeWidgetBlocState extends Equatable {
  const HomeWidgetBlocState();

  @override
  List<Object?> get props => [];
}

class HomeWidgetInitial extends HomeWidgetBlocState {
  const HomeWidgetInitial();
}

class HomeWidgetSyncing extends HomeWidgetBlocState {
  const HomeWidgetSyncing();
}

class HomeWidgetSynced extends HomeWidgetBlocState {
  const HomeWidgetSynced();
}

class HomeWidgetError extends HomeWidgetBlocState {
  const HomeWidgetError(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
