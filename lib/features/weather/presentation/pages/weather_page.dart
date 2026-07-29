import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../../../settings/presentation/widgets/settings_sheet.dart';
import '../cubit/weather_cubit.dart';
import '../cubit/weather_state.dart';
import '../widgets/weather_card.dart';
import '../widgets/weather_error_view.dart';
import '../widgets/weather_search_field.dart';

/// Main search page connecting widgets to [WeatherCubit].
class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(strings.appTitle),
        actions: [
          IconButton(
            onPressed: () => SettingsSheet.show(context),
            tooltip: strings.settings,
            icon: const Icon(Icons.settings_outlined),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 760),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: WeatherSearchField(
                    onSearch: context.read<WeatherCubit>().search,
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(20),
                    child: BlocBuilder<WeatherCubit, WeatherState>(
                      builder: (context, state) => switch (state) {
                        WeatherInitial() => const SizedBox.shrink(),
                        WeatherLoading() => Column(
                          children: [
                            const CircularProgressIndicator(),
                            const SizedBox(height: 12),
                            Text(strings.loading),
                          ],
                        ),
                        WeatherLoaded(:final weather) => WeatherCard(
                          weather: weather,
                        ),
                        WeatherError(:final isNetworkError) => WeatherErrorView(
                          isNetworkError: isNetworkError,
                        ),
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
