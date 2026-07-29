// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Weather';

  @override
  String get cityLabel => 'City';

  @override
  String get cityHint => 'Enter a city name';

  @override
  String get search => 'Search';

  @override
  String get loading => 'Loading weather…';

  @override
  String get settings => 'Settings';

  @override
  String get appearance => 'Appearance';

  @override
  String get language => 'Language';

  @override
  String get systemDefault => 'System';

  @override
  String get deviceLanguage => 'Use device language';

  @override
  String get lightTheme => 'Light';

  @override
  String get darkTheme => 'Dark';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get cityNotFound =>
      'City not found. Check the spelling and try again.';

  @override
  String get noInternet =>
      'No internet connection. Showing last saved result if available.';

  @override
  String offlineLastUpdated(String date) {
    return 'Offline · last updated $date';
  }

  @override
  String temperature(String value) {
    return '$value °C';
  }
}
