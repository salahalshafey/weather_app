import 'package:equatable/equatable.dart';

/// Domain representation of current weather, independent of persistence.
class Weather extends Equatable {
  const Weather({
    required this.city,
    required this.temperatureC,
    required this.description,
    required this.iconUrl,
    required this.fetchedAt,
    this.isCached = false,
  });

  final String city;
  final double temperatureC;
  final String description;
  final String iconUrl;
  final DateTime fetchedAt;
  final bool isCached;

  @override
  List<Object?> get props => [
    city,
    temperatureC,
    description,
    iconUrl,
    fetchedAt,
    isCached,
  ];
}
