import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'settings_state.dart';

export 'settings_state.dart';

/// Owns and persists the user's language and appearance choices.
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._preferences) : super(_restore(_preferences));

  static const _themeKey = 'theme_mode';
  static const _localeKey = 'locale';
  final SharedPreferences _preferences;

  /// Applies and persists a theme choice.
  Future<void> setThemeMode(ThemeMode mode) async {
    emit(state.copyWith(themeMode: mode));
    await _preferences.setString(_themeKey, mode.name);
  }

  /// Applies a language, or follows the device when [locale] is null.
  Future<void> setLocale(Locale? locale) async {
    emit(state.copyWith(locale: locale, useSystemLocale: locale == null));
    if (locale == null) {
      await _preferences.remove(_localeKey);
    } else {
      await _preferences.setString(_localeKey, locale.languageCode);
    }
  }

  static SettingsState _restore(SharedPreferences preferences) {
    final savedTheme = preferences.getString(_themeKey);
    final themeMode = ThemeMode.values.firstWhere(
      (mode) => mode.name == savedTheme,
      orElse: () => ThemeMode.system,
    );

    final languageCode = preferences.getString(_localeKey);
    return SettingsState(
      themeMode: themeMode,
      locale: languageCode == null ? null : Locale(languageCode),
    );
  }
}
