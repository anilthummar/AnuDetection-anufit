part of 'report_bloc.dart';

sealed class ReportState extends Equatable {
  const ReportState();
  @override
  List<Object?> get props => [];
}

final class ReportInitial extends ReportState {
  const ReportInitial();
}

final class ReportLoading extends ReportState {
  const ReportLoading();
}

final class ReportPreviewLoaded extends ReportState {
  const ReportPreviewLoaded({required this.data});
  final ReportData data;
  @override
  List<Object?> get props => [data];
}

final class ReportExported extends ReportState {
  const ReportExported({required this.generated, required this.data});
  final GeneratedReport generated;
  final ReportData data;
  @override
  List<Object?> get props => [generated, data];
}

final class ReportError extends ReportState {
  const ReportError(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
