import 'package:equatable/equatable.dart';

/// Base value object for failures crossing into the domain layer.
sealed class Failure extends Equatable {
  const Failure();

  @override
  List<Object?> get props => const [];
}

/// Represents an unexpected response or configuration problem.
final class ServerFailure extends Failure {
  const ServerFailure();
}

/// Represents an unavailable connection with no usable cached result.
final class NetworkFailure extends Failure {
  const NetworkFailure();
}

/// Represents a city query rejected by WeatherAPI.
final class CityNotFoundFailure extends Failure {
  const CityNotFoundFailure();
}

/// Represents a build that omitted the required WeatherAPI key.
final class MissingApiKeyFailure extends Failure {
  const MissingApiKeyFailure();
}
