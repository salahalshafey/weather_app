import 'package:flutter/material.dart';

/// Centralized light and dark Material themes.
abstract final class AppTheme {
  static const _seedColor = Color(0xFF176B87);

  static final ThemeData light = _create(Brightness.light);
  static final ThemeData dark = _create(Brightness.dark);

  static ThemeData _create(Brightness brightness) {
    final scheme = ColorScheme.fromSeed(
      seedColor: _seedColor,
      brightness: brightness,
    );
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      scaffoldBackgroundColor: scheme.surface,
      cardTheme: CardThemeData(
        color: scheme.surfaceContainer,
        elevation: 2,
        margin: EdgeInsets.zero,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
