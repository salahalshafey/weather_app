/// Thrown when the remote service cannot complete a request.
class ServerException implements Exception {
  const ServerException();
}

/// Thrown when WeatherAPI cannot resolve the requested city.
class CityNotFoundException implements Exception {
  const CityNotFoundException();
}

/// Thrown when the required WeatherAPI key was not supplied at build time.
class MissingApiKeyException implements Exception {
  const MissingApiKeyException();
}

/// Thrown when no valid cached weather value exists.
class CacheException implements Exception {
  const CacheException();
}
