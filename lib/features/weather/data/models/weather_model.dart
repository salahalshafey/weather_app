import '../../domain/entities/weather.dart';

/// Serializable data-layer form of [Weather].
class WeatherModel extends Weather {
  const WeatherModel({
    required super.city,
    required super.temperatureC,
    required super.description,
    required super.iconUrl,
    required super.fetchedAt,
    super.isCached,
  });

  /// Maps either an API response or the local cache representation.
  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    if (json['location'] case final Map<String, dynamic> location) {
      final current = json['current'] as Map<String, dynamic>;
      final condition = current['condition'] as Map<String, dynamic>;
      final rawIcon = condition['icon'] as String;
      final updatedEpoch = current['last_updated_epoch'] as num?;

      return WeatherModel(
        city: location['name'] as String,
        temperatureC: (current['temp_c'] as num).toDouble(),
        description: condition['text'] as String,
        iconUrl: rawIcon.startsWith('//') ? 'https:$rawIcon' : rawIcon,
        fetchedAt: updatedEpoch == null
            ? DateTime.now()
            : DateTime.fromMillisecondsSinceEpoch(
                updatedEpoch.toInt() * 1000,
                isUtc: true,
              ),
      );
    }

    return WeatherModel(
      city: json['city'] as String,
      temperatureC: (json['temperatureC'] as num).toDouble(),
      description: json['description'] as String,
      iconUrl: json['iconUrl'] as String,
      fetchedAt: DateTime.parse(json['fetchedAt'] as String),
      isCached: json['isCached'] as bool? ?? false,
    );
  }

  /// Converts this model into the stable cache schema.
  Map<String, dynamic> toJson() => {
    'city': city,
    'temperatureC': temperatureC,
    'description': description,
    'iconUrl': iconUrl,
    'fetchedAt': fetchedAt.toIso8601String(),
    'isCached': isCached,
  };

  /// Returns the same observation marked as coming from local storage.
  WeatherModel asCached() => WeatherModel(
    city: city,
    temperatureC: temperatureC,
    description: description,
    iconUrl: iconUrl,
    fetchedAt: fetchedAt,
    isCached: true,
  );
}
