import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../app/locale_controller.dart';
import '../../../app/theme_controller.dart';
import '../../../l10n/app_localizations.dart';

class AccountSettingsView extends StatelessWidget {
  const AccountSettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final localeController = context.watch<LocaleController>();
    final themeController = context.watch<ThemeController>();

    return Scaffold(
      appBar: AppBar(title: Text(strings.accountSettings)),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            strings.language,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            initialValue: localeController.locale?.languageCode ?? 'system',
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.language_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            items: [
              DropdownMenuItem(
                value: 'system',
                child: Text(strings.systemLanguage),
              ),
              const DropdownMenuItem(value: 'en', child: Text('English')),
              const DropdownMenuItem(value: 'he', child: Text('עברית')),
              const DropdownMenuItem(value: 'ru', child: Text('Русский')),
            ],
            onChanged: (code) => localeController.setLocale(
              code == null || code == 'system' ? null : Locale(code),
            ),
          ),
          const SizedBox(height: 28),
          Text(
            strings.appearance,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 10),
          SegmentedButton<ThemeMode>(
            segments: [
              ButtonSegment(
                value: ThemeMode.system,
                icon: const Icon(Icons.settings_suggest_rounded),
                label: Text(strings.systemTheme),
              ),
              ButtonSegment(
                value: ThemeMode.light,
                icon: const Icon(Icons.light_mode_rounded),
                label: Text(strings.lightTheme),
              ),
              ButtonSegment(
                value: ThemeMode.dark,
                icon: const Icon(Icons.dark_mode_rounded),
                label: Text(strings.darkTheme),
              ),
            ],
            selected: {themeController.themeMode},
            onSelectionChanged: (selection) =>
                themeController.setThemeMode(selection.first),
          ),
        ],
      ),
    );
  }
}
