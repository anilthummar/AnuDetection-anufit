import 'package:isar_community/isar.dart';

part 'weight_entry_model.g.dart';

@collection
class WeightEntryModel {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime date;

  double weightKg = 0;
  double bmi = 0;
  String? note;
}
