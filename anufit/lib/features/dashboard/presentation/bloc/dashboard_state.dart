part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object?> get props => [];
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

final class DashboardLoaded extends DashboardState {
  const DashboardLoaded({
    required this.summary,
    this.isRefreshing = false,
    this.isActionBusy = false,
    this.actionError,
  });

  final DashboardSummary summary;
  final bool isRefreshing;
  final bool isActionBusy;
  final String? actionError;

  DashboardLoaded copyWith({
    DashboardSummary? summary,
    bool? isRefreshing,
    bool? isActionBusy,
    String? actionError,
    bool clearActionError = false,
  }) {
    return DashboardLoaded(
      summary: summary ?? this.summary,
      isRefreshing: isRefreshing ?? this.isRefreshing,
      isActionBusy: isActionBusy ?? this.isActionBusy,
      actionError: clearActionError ? null : actionError ?? this.actionError,
    );
  }

  @override
  List<Object?> get props => [summary, isRefreshing, isActionBusy, actionError];
}

final class DashboardError extends DashboardState {
  const DashboardError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
