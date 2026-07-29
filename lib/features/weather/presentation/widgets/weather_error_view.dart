import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../cubit/weather_state.dart';

/// Theme-aware error panel with distinct city and connectivity messages.
class WeatherErrorView extends StatelessWidget {
  const WeatherErrorView({required this.errorKind, super.key});

  final WeatherErrorKind errorKind;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final strings = AppLocalizations.of(context)!;
    final isMissingKey = errorKind == WeatherErrorKind.missingApiKey;

    final icon = switch (errorKind) {
      WeatherErrorKind.network => Icons.cloud_off,
      WeatherErrorKind.cityNotFound => Icons.location_off,
      WeatherErrorKind.missingApiKey => Icons.key_off_outlined,
    };
    final message = switch (errorKind) {
      WeatherErrorKind.network => strings.noInternet,
      WeatherErrorKind.cityNotFound => strings.cityNotFound,
      WeatherErrorKind.missingApiKey => strings.missingApiKey,
    };

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
            Icon(icon, color: theme.colorScheme.onErrorContainer),
            const SizedBox(height: 8),
            Text(
              message,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onErrorContainer,
              ),
            ),
            if (isMissingKey) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    // copy icon button
                    // IconButton(
                    //   icon: Icon(Icons.copy, color: theme.colorScheme.onSurface),
                    //   onPressed: () {
                    //     final command = strings.apiKeyRunCommand;
                    //     Clipboard.setData(ClipboardData(text: command));
                    //     ScaffoldMessenger.of(context).showSnackBar(
                    //       SnackBar(
                    //         content: Text(strings.copiedToClipboard),
                    //         duration: const Duration(seconds: 2),
                    //       ),
                    //     );
                    //   },
                    // ),
                    Expanded(
                      child: SelectableText(
                        strings.apiKeyRunCommand,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
