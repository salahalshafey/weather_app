// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'الطقس';

  @override
  String get cityLabel => 'المدينة';

  @override
  String get cityHint => 'أدخل اسم المدينة';

  @override
  String get search => 'بحث';

  @override
  String get loading => 'جارٍ تحميل الطقس…';

  @override
  String get settings => 'الإعدادات';

  @override
  String get appearance => 'المظهر';

  @override
  String get language => 'اللغة';

  @override
  String get systemDefault => 'النظام';

  @override
  String get deviceLanguage => 'استخدام لغة الجهاز';

  @override
  String get lightTheme => 'فاتح';

  @override
  String get darkTheme => 'داكن';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get cityNotFound =>
      'لم يتم العثور على المدينة. تحقق من الكتابة وحاول مرة أخرى.';

  @override
  String get noInternet =>
      'لا يوجد اتصال بالإنترنت. يتم عرض آخر نتيجة محفوظة إن توفرت.';

  @override
  String offlineLastUpdated(String date) {
    return 'دون اتصال · آخر تحديث $date';
  }

  @override
  String temperature(String value) {
    return '$value °م';
  }
}
