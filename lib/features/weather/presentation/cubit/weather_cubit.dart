import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/error/failures.dart';
import '../../domain/usecases/get_weather.dart';
import 'weather_state.dart';

/// Orchestrates searches through the domain use case.
class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._getWeather) : super(const WeatherInitial());

  final GetWeather _getWeather;

  /// Loads weather when [city] contains a meaningful query.
  Future<void> search(String city) async {
    final normalized = city.trim();
    if (normalized.isEmpty || state is WeatherLoading) return;

    emit(const WeatherLoading());
    final result = await _getWeather(GetWeatherParams(city: normalized));
    result.fold((failure) {
      final kind = switch (failure) {
        CityNotFoundFailure() => WeatherErrorKind.cityNotFound,
        MissingApiKeyFailure() => WeatherErrorKind.missingApiKey,
        _ => WeatherErrorKind.network,
      };
      emit(
        WeatherError(
          message: kind,
          isNetworkError: failure is NetworkFailure || failure is ServerFailure,
        ),
      );
    }, (weather) => emit(WeatherLoaded(weather)));
  }
}
