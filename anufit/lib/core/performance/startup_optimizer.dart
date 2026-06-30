import 'package:flutter/scheduler.dart';

typedef StartupTask = Future<void> Function();

/// Defers non-critical startup work until after the first frame.
abstract final class StartupOptimizer {
  static void runDeferred(List<StartupTask> tasks) {
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      for (final task in tasks) {
        try {
          await task();
        } catch (_) {
          // Non-fatal deferred startup tasks.
        }
      }
    });
  }
}
