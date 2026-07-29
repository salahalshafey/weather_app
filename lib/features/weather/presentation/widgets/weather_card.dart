import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/weather.dart';

/// Responsive card presenting a weather observation and cache status.
class WeatherCard extends StatelessWidget {
  const WeatherCard({required this.weather, super.key});

  final Weather weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = AppLocalizations.of(context)!;

    final icon = Image.network(
      weather.iconUrl,
      width: 112,
      height: 112,
      errorBuilder: (_, _, _) => Icon(
        Icons.cloud_outlined,
        size: 88,
        color: theme.colorScheme.primary,
      ),
    );

    final details = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(weather.city, style: theme.textTheme.headlineMedium),
        const SizedBox(height: 8),
        Text(
          strings.temperature(
            NumberFormat.decimalPattern(
              Localizations.localeOf(context).toLanguageTag(),
            ).format(weather.temperatureC),
          ),
          style: theme.textTheme.displaySmall?.copyWith(
            color: theme.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 4),
        Text(weather.description, style: theme.textTheme.titleMedium),
      ],
    );

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final content = constraints.maxWidth >= 520
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      icon,
                      const SizedBox(width: 32),
                      Flexible(child: details),
                    ],
                  )
                : Column(children: [icon, details]);
            return Column(
              children: [
                content,
                if (weather.isCached) ...[
                  const SizedBox(height: 20),
                  _CachedStatus(fetchedAt: weather.fetchedAt),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}

class _CachedStatus extends StatelessWidget {
  const _CachedStatus({required this.fetchedAt});

  final DateTime fetchedAt;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = AppLocalizations.of(context)!;
    final locale = Localizations.localeOf(context).toLanguageTag();
    final formatted = DateFormat.yMd(
      locale,
    ).add_jm().format(fetchedAt.toLocal());

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.tertiaryContainer,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Text(
            strings.noInternet,
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onTertiaryContainer,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            strings.offlineLastUpdated(formatted),
            textAlign: TextAlign.center,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onTertiaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
