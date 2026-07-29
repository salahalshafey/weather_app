import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/core/error/failures.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather.dart';
import 'package:weather_app/features/weather/presentation/cubit/weather_cubit.dart';
import 'package:weather_app/features/weather/presentation/pages/weather_page.dart';
import 'package:weather_app/features/weather/presentation/widgets/weather_card.dart';
import 'package:weather_app/l10n/generated/app_localizations.dart';

class _Repository implements WeatherRepository {
  @override
  Future<Either<Failure, Weather>> getWeather(String city) async => Right(
    Weather(
      city: city,
      temperatureC: 24,
      description: 'Sunny',
      iconUrl: 'https://example.com/icon.png',
      fetchedAt: DateTime(2026),
    ),
  );
}

void main() {
  testWidgets('search renders loaded weather', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider(
          create: (_) => WeatherCubit(GetWeather(_Repository())),
          child: const WeatherPage(),
        ),
      ),
    );

    await tester.enterText(find.byType(TextField), 'Cairo');
    await tester.tap(find.text('Search'));
    await tester.pumpAndSettle();

    expect(
      find.descendant(
        of: find.byType(WeatherCard),
        matching: find.text('Cairo'),
      ),
      findsOneWidget,
    );
    expect(find.text('Sunny'), findsOneWidget);
    expect(find.textContaining('24'), findsOneWidget);
  });
}
