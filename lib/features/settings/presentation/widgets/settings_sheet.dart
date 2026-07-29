import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../l10n/generated/app_localizations.dart';
import '../cubit/settings_cubit.dart';

/// A themed bottom sheet for language and appearance preferences.
class SettingsSheet extends StatelessWidget {
  const SettingsSheet({super.key});

  /// Opens the sheet while retaining access to the app-level settings Cubit.
  static Future<void> show(BuildContext context) {
    final cubit = context.read<SettingsCubit>();

    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      useSafeArea: true,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: const SettingsSheet()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settings) => Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Icon(Icons.tune, color: theme.colorScheme.primary),
                const SizedBox(width: 12),
                Text(strings.settings, style: theme.textTheme.headlineSmall),
              ],
            ),
            const SizedBox(height: 24),
            _SectionTitle(
              icon: Icons.palette_outlined,
              title: strings.appearance,
            ),
            const SizedBox(height: 12),
            SegmentedButton<ThemeMode>(
              segments: [
                ButtonSegment(
                  value: ThemeMode.system,
                  icon: const Icon(Icons.brightness_auto_outlined),
                  label: Text(strings.systemDefault),
                ),
                ButtonSegment(
                  value: ThemeMode.light,
                  icon: const Icon(Icons.light_mode_outlined),
                  label: Text(strings.lightTheme),
                ),
                ButtonSegment(
                  value: ThemeMode.dark,
                  icon: const Icon(Icons.dark_mode_outlined),
                  label: Text(strings.darkTheme),
                ),
              ],
              selected: {settings.themeMode},
              onSelectionChanged: (selection) {
                context.read<SettingsCubit>().setThemeMode(selection.first);
              },
              showSelectedIcon: false,
            ),
            const SizedBox(height: 28),
            _SectionTitle(icon: Icons.language, title: strings.language),
            const SizedBox(height: 12),
            _LanguageOption(
              title: strings.systemDefault,
              subtitle: strings.deviceLanguage,
              value: null,
              selected: settings.locale == null,
            ),
            const SizedBox(height: 8),
            _LanguageOption(
              title: strings.english,
              value: const Locale('en'),
              selected: settings.locale?.languageCode == 'en',
            ),
            const SizedBox(height: 8),
            _LanguageOption(
              title: strings.arabic,
              value: const Locale('ar'),
              selected: settings.locale?.languageCode == 'ar',
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.secondary),
        const SizedBox(width: 8),
        Text(title, style: theme.textTheme.titleMedium),
      ],
    );
  }
}

class _LanguageOption extends StatelessWidget {
  const _LanguageOption({
    required this.title,
    required this.value,
    required this.selected,
    this.subtitle,
  });

  final String title;
  final String? subtitle;
  final Locale? value;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Material(
      color: selected
          ? theme.colorScheme.secondaryContainer
          : theme.colorScheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(14),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => context.read<SettingsCubit>().setLocale(value),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: theme.textTheme.bodyLarge),
                    if (subtitle != null)
                      Text(subtitle!, style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 180),
                child: selected
                    ? Icon(
                        Icons.check_circle,
                        key: const ValueKey(true),
                        color: theme.colorScheme.primary,
                      )
                    : const SizedBox(
                        key: ValueKey(false),
                        width: 24,
                        height: 24,
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
