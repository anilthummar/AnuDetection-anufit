import 'package:equatable/equatable.dart';

enum StepSource {
  stepCounter,
  stepDetector,
  accelerometer,
  cmpedometer,
  manual,
  unknown;

  static StepSource fromNative(String value) {
    return StepSource.values.firstWhere(
      (s) => s.name == value || _aliases[s] == value,
      orElse: () => StepSource.unknown,
    );
  }

  static const Map<StepSource, String> _aliases = {
    StepSource.stepCounter: 'step_counter',
    StepSource.stepDetector: 'step_detector',
    StepSource.accelerometer: 'accelerometer',
    StepSource.cmpedometer: 'cmpedometer',
  };
}

enum TrackingStatus {
  idle,
  tracking,
  paused,
  stopped,
}

class StepData extends Equatable {
  const StepData({
    required this.todaySteps,
    required this.hardwareTotal,
    required this.timestamp,
    required this.source,
    required this.status,
    this.manualAdjustment = 0,
  });

  factory StepData.initial() {
    return StepData(
      todaySteps: 0,
      hardwareTotal: 0,
      timestamp: DateTime.fromMillisecondsSinceEpoch(0),
      source: StepSource.unknown,
      status: TrackingStatus.idle,
    );
  }

  final int todaySteps;
  final int hardwareTotal;
  final DateTime timestamp;
  final StepSource source;
  final TrackingStatus status;
  final int manualAdjustment;

  StepData copyWith({
    int? todaySteps,
    int? hardwareTotal,
    DateTime? timestamp,
    StepSource? source,
    TrackingStatus? status,
    int? manualAdjustment,
  }) {
    return StepData(
      todaySteps: todaySteps ?? this.todaySteps,
      hardwareTotal: hardwareTotal ?? this.hardwareTotal,
      timestamp: timestamp ?? this.timestamp,
      source: source ?? this.source,
      status: status ?? this.status,
      manualAdjustment: manualAdjustment ?? this.manualAdjustment,
    );
  }

  @override
  List<Object?> get props => [
        todaySteps,
        hardwareTotal,
        timestamp,
        source,
        status,
        manualAdjustment,
      ];
}

class StepPeriodSummary extends Equatable {
  const StepPeriodSummary({
    required this.periodStart,
    required this.steps,
  });

  final DateTime periodStart;
  final int steps;

  @override
  List<Object?> get props => [periodStart, steps];
}

class StepBaseline extends Equatable {
  const StepBaseline({
    required this.date,
    required this.hardwareBaseline,
    required this.lastHardwareTotal,
    required this.timezoneId,
    this.manualAdjustment = 0,
  });

  final DateTime date;
  final int hardwareBaseline;
  final int lastHardwareTotal;
  final String timezoneId;
  final int manualAdjustment;

  @override
  List<Object?> get props => [
        date,
        hardwareBaseline,
        lastHardwareTotal,
        timezoneId,
        manualAdjustment,
      ];
}
