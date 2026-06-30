import 'package:anufit/core/enums/unit_system.dart';

abstract final class UnitFormat {
  static double displayWeight(double kg, UnitSystem unit) =>
      unit == UnitSystem.imperial ? kg * 2.20462 : kg;

  static String weightLabel(double kg, UnitSystem unit, {int decimals = 1}) {
    final value = displayWeight(kg, unit);
    final suffix = unit == UnitSystem.imperial ? 'lb' : 'kg';
    return '${value.toStringAsFixed(decimals)} $suffix';
  }

  static double displayHeight(double cm, UnitSystem unit) =>
      unit == UnitSystem.imperial ? cm / 2.54 : cm;

  static String heightLabel(double cm, UnitSystem unit) {
    if (unit == UnitSystem.imperial) {
      final totalInches = cm / 2.54;
      final feet = totalInches ~/ 12;
      final inches = (totalInches % 12).round();
      return "$feet'$inches\"";
    }
    return '${cm.toStringAsFixed(0)} cm';
  }

  static String distanceLabel(double km, UnitSystem unit, {int decimals = 2}) {
    if (unit == UnitSystem.imperial) {
      final miles = km * 0.621371;
      return '${miles.toStringAsFixed(decimals)} mi';
    }
    return '${km.toStringAsFixed(decimals)} km';
  }

  static double displayDistance(double km, UnitSystem unit) =>
      unit == UnitSystem.imperial ? km * 0.621371 : km;

  static String distanceUnit(UnitSystem unit) =>
      unit == UnitSystem.imperial ? 'mi' : 'km';

  static String waterLiters(double liters) {
    if (liters >= 1) return '${liters.toStringAsFixed(2)} L';
    return '${(liters * 1000).round()} ml';
  }

  static String waterMl(int ml) {
    if (ml >= 1000) return '${(ml / 1000).toStringAsFixed(2)} L';
    return '$ml ml';
  }
}
