import 'package:isar_community/isar.dart';

part 'health_sync_model.g.dart';

@collection
class HealthSyncModel {
  Id id = 1;

  DateTime? lastSync;
  String status = 'idle';
  int recordsSynced = 0;
  String source = 'none';
  String? errorMessage;
  DateTime? lastIncrementalSync;
}
