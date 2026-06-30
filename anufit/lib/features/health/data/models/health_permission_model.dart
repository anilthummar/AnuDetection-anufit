import 'package:isar_community/isar.dart';

part 'health_permission_model.g.dart';

@collection
class HealthPermissionModel {
  Id id = 1;

  bool steps = false;
  bool distance = false;
  bool calories = false;
  bool weight = false;
  bool height = false;
  bool authorized = false;
  String status = 'unknown';
}
