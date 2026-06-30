import 'dart:io';

import 'package:excel/excel.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;

import 'package:anufit/core/constants/app_constants.dart';
import 'package:anufit/features/reports/domain/entities/report_entity.dart';

abstract final class ReportGenerator {
  static Future<GeneratedReport> generate({
    required ReportData data,
    required ExportFormat format,
  }) async {
    return switch (format) {
      ExportFormat.pdf => _generatePdf(data),
      ExportFormat.csv => _generateCsv(data),
      ExportFormat.excel => _generateExcel(data),
    };
  }

  static Future<GeneratedReport> _generatePdf(ReportData data) async {
    final doc = pw.Document();
    doc.addPage(
      pw.MultiPage(
        build: (context) => [
          pw.Header(level: 0, child: pw.Text(data.title)),
          pw.Text('Period: ${data.periodLabel}'),
          pw.Text('User: ${data.userName}'),
          pw.SizedBox(height: 16),
          pw.Text('Total Steps: ${data.totalSteps}'),
          pw.Text('Distance: ${data.distanceKm.toStringAsFixed(1)} km'),
          pw.Text('Calories: ${data.calories.round()} kcal'),
          pw.Text('Walking Time: ${_formatDuration(data.walkingTime)}'),
          pw.Text('Goal Completion: ${(data.goalCompletionRate * 100).round()}%'),
          pw.Text('Best Day: ${data.bestDay}'),
          pw.Text('Worst Day: ${data.worstDay}'),
          if (data.achievementsEarned.isNotEmpty) ...[
            pw.SizedBox(height: 12),
            pw.Text('Achievements:'),
            for (final a in data.achievementsEarned) pw.Text('- $a'),
          ],
        ],
      ),
    );

    final dir = Directory.systemTemp;
    final path = '${dir.path}/anufit_report_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = File(path);
    await file.writeAsBytes(await doc.save());
    return GeneratedReport(filePath: path, format: ExportFormat.pdf, data: data);
  }

  static Future<GeneratedReport> _generateCsv(ReportData data) async {
    final buffer = StringBuffer()
      ..writeln('${AppConstants.appShortName} Activity Report')
      ..writeln('Period,${data.periodLabel}')
      ..writeln('User,${data.userName}')
      ..writeln('Total Steps,${data.totalSteps}')
      ..writeln('Distance (km),${data.distanceKm.toStringAsFixed(2)}')
      ..writeln('Calories,${data.calories.round()}')
      ..writeln('Walking Time,${_formatDuration(data.walkingTime)}')
      ..writeln('Goal Completion %,${(data.goalCompletionRate * 100).round()}')
      ..writeln('Best Day,${data.bestDay}')
      ..writeln('Worst Day,${data.worstDay}')
      ..writeln()
      ..writeln('Date,Steps,Distance (km)');

    for (final row in data.dailyBreakdown) {
      buffer.writeln('${row.date},${row.steps},${row.km.toStringAsFixed(2)}');
    }

    final dir = Directory.systemTemp;
    final path = '${dir.path}/anufit_report_${DateTime.now().millisecondsSinceEpoch}.csv';
    await File(path).writeAsString(buffer.toString());
    return GeneratedReport(filePath: path, format: ExportFormat.csv, data: data);
  }

  static Future<GeneratedReport> _generateExcel(ReportData data) async {
    final excel = Excel.createExcel();
    final sheet = excel['Report'];
    sheet.appendRow([TextCellValue('${AppConstants.appShortName} Activity Report')]);
    sheet.appendRow([TextCellValue('Period'), TextCellValue(data.periodLabel)]);
    sheet.appendRow([TextCellValue('Total Steps'), IntCellValue(data.totalSteps)]);
    sheet.appendRow([
      TextCellValue('Distance (km)'),
      DoubleCellValue(data.distanceKm),
    ]);
    sheet.appendRow([
      TextCellValue('Calories'),
      IntCellValue(data.calories.round()),
    ]);
    sheet.appendRow([TextCellValue('Best Day'), TextCellValue(data.bestDay)]);
    sheet.appendRow([TextCellValue('Worst Day'), TextCellValue(data.worstDay)]);
    sheet.appendRow([]);
    sheet.appendRow([
      TextCellValue('Date'),
      TextCellValue('Steps'),
      TextCellValue('Distance (km)'),
    ]);
    for (final row in data.dailyBreakdown) {
      sheet.appendRow([
        TextCellValue(row.date),
        IntCellValue(row.steps),
        DoubleCellValue(row.km),
      ]);
    }

    final dir = Directory.systemTemp;
    final path = '${dir.path}/anufit_report_${DateTime.now().millisecondsSinceEpoch}.xlsx';
    final bytes = excel.encode();
    if (bytes != null) {
      await File(path).writeAsBytes(bytes);
    }
    return GeneratedReport(filePath: path, format: ExportFormat.excel, data: data);
  }

  static String _formatDuration(Duration d) {
    if (d.inHours > 0) return '${d.inHours}h ${d.inMinutes.remainder(60)}m';
    return '${d.inMinutes}m';
  }

  static String formatDate(DateTime date) => DateFormat('d MMM yyyy').format(date);
}
