// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Anufit';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get settings => 'Settings';

  @override
  String get backup => 'Backup & Restore';

  @override
  String get export => 'Export';

  @override
  String get cloudSync => 'Cloud Sync';

  @override
  String get widgets => 'Home Widgets';

  @override
  String get security => 'Security';

  @override
  String get releaseInfo => 'Release Info';

  @override
  String get backupExport => 'Export Backup';

  @override
  String get backupRestore => 'Restore Backup';

  @override
  String get backupEncrypted => 'Encrypted backup';

  @override
  String get stepsToday => 'Steps today';

  @override
  String get goalProgress => 'Goal progress';

  @override
  String get waterIntake => 'Water intake';

  @override
  String get currentWeight => 'Current weight';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageHindi => 'Hindi';

  @override
  String get languageGujarati => 'Gujarati';

  @override
  String accessibilityStepsLabel(int count) {
    return 'Today\'s step count: $count';
  }
}
