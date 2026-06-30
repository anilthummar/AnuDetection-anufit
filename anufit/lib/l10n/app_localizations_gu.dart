// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Gujarati (`gu`).
class AppLocalizationsGu extends AppLocalizations {
  AppLocalizationsGu([String locale = 'gu']) : super(locale);

  @override
  String get appTitle => 'Step Counter - Pedometer';

  @override
  String get dashboard => 'ડેશબોર્ડ';

  @override
  String get settings => 'સેટિંગ્સ';

  @override
  String get backup => 'બેકઅપ અને પુનઃસ્થાપના';

  @override
  String get export => 'નિકાસ';

  @override
  String get cloudSync => 'ક્લાઉડ સિંક';

  @override
  String get widgets => 'હોમ વિજેટ';

  @override
  String get security => 'સુરક્ષા';

  @override
  String get releaseInfo => 'રિલીઝ માહિતી';

  @override
  String get backupExport => 'બેકઅપ નિકાસ કરો';

  @override
  String get backupRestore => 'બેકઅપ પુનઃસ્થાપિત કરો';

  @override
  String get backupEncrypted => 'એન્ક્રિપ્ટેડ બેકઅપ';

  @override
  String get stepsToday => 'આજના પગલાં';

  @override
  String get goalProgress => 'ધ્યેય પ્રગતિ';

  @override
  String get waterIntake => 'પાણીનું સેવન';

  @override
  String get currentWeight => 'વર્તમાન વજન';

  @override
  String get languageEnglish => 'અંગ્રેજી';

  @override
  String get languageHindi => 'હિન્દી';

  @override
  String get languageGujarati => 'ગુજરાતી';

  @override
  String accessibilityStepsLabel(int count) {
    return 'આજના પગલાં: $count';
  }
}
