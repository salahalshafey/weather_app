import 'package:flutter/material.dart';

import '../../../../l10n/generated/app_localizations.dart';

/// City input and submit action with keyboard-search support.
class WeatherSearchField extends StatefulWidget {
  const WeatherSearchField({required this.onSearch, super.key});

  final ValueChanged<String> onSearch;

  @override
  State<WeatherSearchField> createState() => _WeatherSearchFieldState();
}

class _WeatherSearchFieldState extends State<WeatherSearchField> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() => widget.onSearch(_controller.text);

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;

    return LayoutBuilder(
      builder: (context, constraints) {
        final field = TextField(
          controller: _controller,
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            labelText: strings.cityLabel,
            hintText: strings.cityHint,
            prefixIcon: const Icon(Icons.location_city),
          ),
        );

        final button = FilledButton.icon(
          onPressed: _submit,
          icon: const Icon(Icons.search),
          label: Text(strings.search),
        );

        if (constraints.maxWidth < 520) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [field, const SizedBox(height: 12), button],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: field),
            const SizedBox(width: 12),
            SizedBox(height: 56, child: button),
          ],
        );
      },
    );
  }
}
