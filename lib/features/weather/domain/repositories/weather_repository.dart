import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/weather.dart';

/// Domain contract for obtaining current weather.
abstract interface class WeatherRepository {
  Future<Either<Failure, Weather>> getWeather(String city);
}
