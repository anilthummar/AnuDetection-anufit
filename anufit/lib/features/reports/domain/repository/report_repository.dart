import 'package:anufit/features/reports/domain/entities/report_entity.dart';

abstract class ReportRepository {
  Future<ReportData> buildReport({
    required ReportPeriod period,
    DateTime? customStart,
    DateTime? customEnd,
  });

  Future<GeneratedReport> exportReport({
    required ReportData data,
    required ExportFormat format,
  });
}
