import 'package:anufit/features/reports/domain/entities/report_entity.dart';
import 'package:anufit/features/reports/domain/services/report_generator.dart';

/// Unified export surface for activity reports (PDF, CSV, Excel).
abstract final class ExportEngine {
  static Future<GeneratedReport> exportActivityReport({
    required ReportData data,
    required ExportFormat format,
  }) {
    return ReportGenerator.generate(data: data, format: format);
  }
}
