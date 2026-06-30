import 'package:flutter_test/flutter_test.dart';

import 'package:anufit/features/reports/domain/entities/report_entity.dart';
import 'package:anufit/features/reports/domain/services/report_generator.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const data = ReportData(
    title: 'Test Report',
    periodLabel: 'Jun 2026',
    userName: 'Walker',
    totalSteps: 10000,
    distanceKm: 7.5,
    calories: 400,
    walkingTime: const Duration(hours: 1, minutes: 30),
    goalCompletionRate: 0.8,
    bestDay: '29 Jun 2026',
    worstDay: '28 Jun 2026',
    achievementsEarned: const ['First 5K'],
    dailyBreakdown: const [
      (date: '28 Jun 2026', steps: 4000, km: 3.0),
      (date: '29 Jun 2026', steps: 6000, km: 4.5),
    ],
  );

  test('ReportGenerator exports CSV', () async {
    final report = await ReportGenerator.generate(
      data: data,
      format: ExportFormat.csv,
    );
    expect(report.filePath.endsWith('.csv'), isTrue);
  });

  test('ReportGenerator exports PDF', () async {
    final report = await ReportGenerator.generate(
      data: data,
      format: ExportFormat.pdf,
    );
    expect(report.filePath.endsWith('.pdf'), isTrue);
  });
}
