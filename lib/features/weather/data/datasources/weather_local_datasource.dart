import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/exceptions.dart';
import '../models/weather_model.dart';

/// Stores and retrieves the most recent successful observation.
abstract interface class WeatherLocalDataSource {
  Future<WeatherModel> getLastWeather();
  Future<void> cacheWeather(WeatherModel weather);
}

/// SharedPreferences implementation using a single JSON string.
class WeatherLocalDataSourceImpl implements WeatherLocalDataSource {
  const WeatherLocalDataSourceImpl(this._preferences);

  static const cacheKey = 'last fetched';
  final SharedPreferences _preferences;

  @override
  Future<void> cacheWeather(WeatherModel weather) async {
    final saved = await _preferences.setString(
      cacheKey,
      jsonEncode(weather.toJson()),
    );
    if (!saved) throw const CacheException();
  }

  @override
  Future<WeatherModel> getLastWeather() async {
    final value = _preferences.getString(cacheKey);
    if (value == null) throw const CacheException();
    try {
      final json = jsonDecode(value) as Map<String, dynamic>;
      return WeatherModel.fromJson(json).asCached();
    } catch (_) {
      throw const CacheException();
    }
  }
}
