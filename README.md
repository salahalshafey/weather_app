# Weather App

A current-weather Flutter app built as a complete Clean Architecture vertical
slice with Cubit state management.

## Architecture

- **Domain** contains the pure `Weather` entity, repository contract, and
  single-purpose `GetWeather` use case. It has no Flutter, HTTP, or storage
  concerns.
- **Data** implements the contract with Dio and WeatherAPI, then persists the
  last successful response as a JSON string in `SharedPreferences`.
- **Presentation** uses a Cubit to orchestrate the use case and small,
  theme-aware widgets to render initial, loading, loaded, and typed error
  states. A separate app-level `SettingsCubit` manages language and theme
  preferences without coupling them to the weather feature.
- **Core** holds shared failures, exceptions, connectivity, themes, and the
  generic use-case contract. `get_it` assembles these dependencies in
  `main.dart`.

## Run

1. Create a free WeatherAPI key.
2. Fetch dependencies:

   ```sh
   flutter pub get
   ```

3. Run while injecting the key at compile time:

   ```sh
   flutter run --dart-define=WEATHER_API_KEY=your_key_here
   ```

The key is read with `String.fromEnvironment` and is not committed to source
control. For production, inject it through the CI/CD secret store. Note that a
client-side key can still be extracted from a built app; a backend proxy is
needed when the provider requires a truly private credential.

## Included features

- English and Arabic localization using Flutter `gen-l10n`, including
  automatic RTL layout. Users can switch between English, Arabic, or the
  device language from the settings sheet.
- Light, dark, and system-following Material 3 themes, selectable from a
  responsive settings sheet in the app bar.
- Language and theme choices are managed by `SettingsCubit` and persisted with
  `SharedPreferences`, so they are restored after restarting the app.
- Responsive narrow and wide weather-card layouts.
- Connectivity detection, request timeouts, typed city/network errors, and a
  visibly marked last-result offline fallback with its saved timestamp.
