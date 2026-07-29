/// Thrown when the remote service cannot complete a request.
class ServerException implements Exception {
  const ServerException();
}

/// Thrown when WeatherAPI cannot resolve the requested city.
class CityNotFoundException implements Exception {
  const CityNotFoundException();
}

/// Thrown when no valid cached weather value exists.
class CacheException implements Exception {
  const CacheException();
}
