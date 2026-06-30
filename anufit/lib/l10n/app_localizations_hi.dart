// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Step Counter - Pedometer';

  @override
  String get dashboard => 'डैशबोर्ड';

  @override
  String get settings => 'सेटिंग्स';

  @override
  String get backup => 'बैकअप और पुनर्स्थापना';

  @override
  String get export => 'निर्यात';

  @override
  String get cloudSync => 'क्लाउड सिंक';

  @override
  String get widgets => 'होम विजेट';

  @override
  String get security => 'सुरक्षा';

  @override
  String get releaseInfo => 'रिलीज़ जानकारी';

  @override
  String get backupExport => 'बैकअप निर्यात करें';

  @override
  String get backupRestore => 'बैकअप पुनर्स्थापित करें';

  @override
  String get backupEncrypted => 'एन्क्रिप्टेड बैकअप';

  @override
  String get stepsToday => 'आज के कदम';

  @override
  String get goalProgress => 'लक्ष्य प्रगति';

  @override
  String get waterIntake => 'पानी का सेवन';

  @override
  String get currentWeight => 'वर्तमान वजन';

  @override
  String get languageEnglish => 'अंग्रेज़ी';

  @override
  String get languageHindi => 'हिंदी';

  @override
  String get languageGujarati => 'गुजराती';

  @override
  String accessibilityStepsLabel(int count) {
    return 'आज के कदम: $count';
  }
}
