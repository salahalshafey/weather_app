import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Immutable application appearance and language preferences.
class SettingsState extends Equatable {
  const SettingsState({required this.themeMode, required this.locale});

  final ThemeMode themeMode;

  /// A null value makes Flutter follow the device language.
  final Locale? locale;

  SettingsState copyWith({
    ThemeMode? themeMode,
    Locale? locale,
    bool useSystemLocale = false,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      locale: useSystemLocale ? null : locale ?? this.locale,
    );
  }

  @override
  List<Object?> get props => [themeMode, locale];
}
