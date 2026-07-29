import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/weather.dart';
import '../repositories/weather_repository.dart';

/// Retrieves weather for one normalized city query.
class GetWeather
    implements UseCase<Either<Failure, Weather>, GetWeatherParams> {
  const GetWeather(this._repository);

  final WeatherRepository _repository;

  @override
  Future<Either<Failure, Weather>> call(GetWeatherParams params) {
    return _repository.getWeather(params.city.trim());
  }
}

/// Input value for [GetWeather].
class GetWeatherParams extends Equatable {
  const GetWeatherParams({required this.city});

  final String city;

  @override
  List<Object> get props => [city];
}
