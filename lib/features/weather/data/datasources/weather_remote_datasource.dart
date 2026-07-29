import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../models/weather_model.dart';

/// Fetches current weather from the remote API.
abstract interface class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(String city);
}

/// Dio implementation of the WeatherAPI current-weather endpoint.
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  const WeatherRemoteDataSourceImpl({
    required Dio client,
    required String apiKey,
  }) : _client = client,
       _apiKey = apiKey;

  final Dio _client;
  final String _apiKey;

  @override
  Future<WeatherModel> getWeather(String city) async {
    if (_apiKey.isEmpty) throw const ServerException();

    try {
      final response = await _client.get<Map<String, dynamic>>(
        '/current.json',
        queryParameters: {'key': _apiKey, 'q': city},
      );

      final data = response.data;
      if (data == null) throw const ServerException();

      return WeatherModel.fromJson(data);
    } on DioException catch (error) {
      final data = error.response?.data;
      debugPrint('DioException: ${error.message}, data: $data');

      final apiError = data is Map<String, dynamic> ? data['error'] : null;
      final code = apiError is Map<String, dynamic> ? apiError['code'] : null;

      if (code == 1006) throw const CityNotFoundException();
      throw const ServerException();
    } on CityNotFoundException {
      rethrow;
    } on ServerException {
      rethrow;
    } catch (_) {
      throw const ServerException();
    }
  }
}
