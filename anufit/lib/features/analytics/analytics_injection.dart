import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:anufit/core/di/injection.dart';
import 'package:anufit/features/history/presentation/bloc/history_bloc.dart';
import 'package:anufit/features/reports/presentation/bloc/report_bloc.dart';
import 'package:anufit/features/statistics/presentation/bloc/chart_bloc.dart';
import 'package:anufit/features/statistics/presentation/bloc/statistics_bloc.dart';

abstract final class HistoryInjection {
  static List<BlocProvider> get providers => [
        BlocProvider<HistoryBloc>(
          create: (_) => getIt<HistoryBloc>()..add(const HistoryLoadRequested()),
        ),
      ];
}

abstract final class StatisticsInjection {
  static List<BlocProvider> get providers => [
        BlocProvider<StatisticsBloc>(
          create: (_) => getIt<StatisticsBloc>()..add(const StatisticsLoadRequested()),
        ),
        BlocProvider<ChartBloc>(
          create: (_) => getIt<ChartBloc>()..add(const ChartLoadRequested()),
        ),
      ];
}

abstract final class ReportsInjection {
  static List<BlocProvider> get providers => [
        BlocProvider<ReportBloc>(
          create: (_) => getIt<ReportBloc>(),
        ),
      ];
}
