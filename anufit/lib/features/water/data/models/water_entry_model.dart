import 'package:isar_community/isar.dart';

part 'water_entry_model.g.dart';

@collection
class WaterEntryModel {
  Id id = Isar.autoIncrement;

  @Index()
  late DateTime date;

  late DateTime time;
  int amountMl = 0;
  String? source;
  String? note;
}
