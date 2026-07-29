import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';

/// Theme-aware error panel with distinct city and connectivity messages.
class WeatherErrorView extends StatelessWidget {
  const WeatherErrorView({required this.isNetworkError, super.key});

  final bool isNetworkError;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = AppLocalizations.of(context)!;

    return Semantics(
      liveRegion: true,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: theme.colorScheme.errorContainer,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isNetworkError ? Icons.cloud_off : Icons.location_off,
              color: theme.colorScheme.onErrorContainer,
            ),
            const SizedBox(height: 8),
            Text(
              isNetworkError ? strings.noInternet : strings.cityNotFound,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
