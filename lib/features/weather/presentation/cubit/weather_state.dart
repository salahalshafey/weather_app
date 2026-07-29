import 'package:equatable/equatable.dart';

import '../../domain/entities/weather.dart';

/// Semantic error categories mapped to localized text by the presentation.
enum WeatherErrorKind { cityNotFound, network, missingApiKey }

/// Base state for the weather search workflow.
sealed class WeatherState extends Equatable {
  const WeatherState();
}

final class WeatherInitial extends WeatherState {
  const WeatherInitial();

  @override
  List<Object?> get props => const [];
}

final class WeatherLoading extends WeatherState {
  const WeatherLoading();

  @override
  List<Object?> get props => const [];
}

final class WeatherLoaded extends WeatherState {
  const WeatherLoaded(this.weather);

  final Weather weather;

  @override
  List<Object?> get props => [weather];
}

final class WeatherError extends WeatherState {
  const WeatherError({required this.message, required this.isNetworkError});

  final WeatherErrorKind message;
  final bool isNetworkError;

  @override
  List<Object?> get props => [message, isNetworkError];
}
