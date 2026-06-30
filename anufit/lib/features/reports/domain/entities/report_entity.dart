import 'package:equatable/equatable.dart';

enum ReportPeriod { daily, weekly, monthly, yearly, custom }

enum ExportFormat { pdf, csv, excel }

class ReportData extends Equatable {
  const ReportData({
    required this.title,
    required this.periodLabel,
    required this.userName,
    required this.totalSteps,
    required this.distanceKm,
    required this.calories,
    required this.walkingTime,
    required this.goalCompletionRate,
    required this.bestDay,
    required this.worstDay,
    required this.achievementsEarned,
    required this.dailyBreakdown,
  });

  final String title;
  final String periodLabel;
  final String userName;
  final int totalSteps;
  final double distanceKm;
  final double calories;
  final Duration walkingTime;
  final double goalCompletionRate;
  final String bestDay;
  final String worstDay;
  final List<String> achievementsEarned;
  final List<({String date, int steps, double km})> dailyBreakdown;

  @override
  List<Object?> get props => [
        title,
        periodLabel,
        userName,
        totalSteps,
        distanceKm,
        calories,
        walkingTime,
        goalCompletionRate,
        bestDay,
        worstDay,
        achievementsEarned,
        dailyBreakdown,
      ];
}

class GeneratedReport extends Equatable {
  const GeneratedReport({
    required this.filePath,
    required this.format,
    required this.data,
  });

  final String filePath;
  final ExportFormat format;
  final ReportData data;

  @override
  List<Object?> get props => [filePath, format, data];
}
