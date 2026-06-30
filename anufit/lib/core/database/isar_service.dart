import 'package:injectable/injectable.dart';
import 'package:isar_community/isar.dart';

@lazySingleton
class IsarService {
  const IsarService(this._isar);

  final Isar _isar;

  Isar get db => _isar;
}
