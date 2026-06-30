part of 'report_bloc.dart';

sealed class ReportEvent extends Equatable {
  const ReportEvent();
  @override
  List<Object?> get props => [];
}

final class ReportPreviewRequested extends ReportEvent {
  const ReportPreviewRequested({
    this.period = ReportPeriod.weekly,
    this.customStart,
    this.customEnd,
  });
  final ReportPeriod period;
  final DateTime? customStart;
  final DateTime? customEnd;
  @override
  List<Object?> get props => [period, customStart, customEnd];
}

final class ReportExportRequested extends ReportEvent {
  const ReportExportRequested({
    required this.format,
    this.period = ReportPeriod.weekly,
    this.customStart,
    this.customEnd,
    this.data,
  });
  final ExportFormat format;
  final ReportPeriod period;
  final DateTime? customStart;
  final DateTime? customEnd;
  final ReportData? data;
  @override
  List<Object?> get props => [format, period, customStart, customEnd, data];
}

final class ReportShareRequested extends ReportEvent {
  const ReportShareRequested({required this.filePath});
  final String filePath;
  @override
  List<Object?> get props => [filePath];
}
