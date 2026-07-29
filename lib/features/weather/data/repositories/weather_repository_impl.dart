import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_local_datasource.dart';
import '../datasources/weather_remote_datasource.dart';

/// Coordinates connectivity, remote loading, caching, and failure mapping.
class WeatherRepositoryImpl implements WeatherRepository {
  const WeatherRepositoryImpl({
    required WeatherRemoteDataSource remoteDataSource,
    required WeatherLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _networkInfo = networkInfo;

  final WeatherRemoteDataSource _remoteDataSource;
  final WeatherLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  Future<Either<Failure, Weather>> getWeather(String city) async {
    if (await _networkInfo.isConnected) {
      try {
        final weather = await _remoteDataSource.getWeather(city);
        try {
          await _localDataSource.cacheWeather(weather);
        } on CacheException {
          // A cache write must not hide fresh remote data.
        }
        return Right(weather);
      } on CityNotFoundException {
        return const Left(CityNotFoundFailure());
      } on ServerException {
        return _cachedWeatherOrFailure();
      }
    }
    return _cachedWeatherOrFailure();
  }

  Future<Either<Failure, Weather>> _cachedWeatherOrFailure() async {
    try {
      return Right(await _localDataSource.getLastWeather());
    } on CacheException {
      return const Left(NetworkFailure());
    }
  }
}
