import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookexample/view_models/theme_view_model.dart';
import 'package:bookexample/view_models/locale_view_model.dart';
import 'package:bookexample/core/theme/app_theme.dart';
import 'package:bookexample/l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();
    final localeViewModel = context.watch<LocaleViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)?.settingsTitle ?? 'Settings'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Theme Section
                _buildThemeSection(themeViewModel),
                const SizedBox(height: 16),

                // Language Section
                _buildLanguageSection(localeViewModel),
              ],
            ),
          ),

          // App Version
          Padding(
            padding: const EdgeInsets.only(bottom: 32, top: 16),
            child: Center(
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of(context)?.applicationVersion ??
                        'Application Version',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 4),
                  Text('1.0.0', style: Theme.of(context).textTheme.titleMedium),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeSection(ThemeViewModel themeViewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.themeSettings ?? 'Theme Settings',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)?.customizeAppearance ??
                  'Customize the appearance of the application',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),

            // Dark Mode Switch
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                AppLocalizations.of(context)?.darkMode ?? 'Dark Mode',
              ),
              subtitle: Text(
                AppLocalizations.of(context)?.toggleDarkTheme ??
                    'Toggle dark theme',
              ),
              trailing: Switch(
                value: themeViewModel.isDarkMode,
                onChanged: (value) async {
                  await themeViewModel.setDarkMode(value);
                },
              ),
            ),
            const SizedBox(height: 16),

            // Theme Variants
            Text(
              AppLocalizations.of(context)?.themeVariant ?? 'Theme Variant',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ...themeViewModel.availableVariants.map((variant) {
              return _buildThemeVariantTile(variant, themeViewModel);
            }).toList(),
            const SizedBox(height: 16),

            // Reset Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await themeViewModel.resetToDefaults();
                },
                child: Text(
                  AppLocalizations.of(context)?.resetToDefaults ??
                      'Reset to Defaults',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(LocaleViewModel localeViewModel) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)?.languageSettings ??
                  'Language Settings',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              AppLocalizations.of(context)?.selectAppLanguage ??
                  'Select application language',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),

            // Language Selection
            ...localeViewModel.supportedLocales.map((locale) {
              return _buildLocaleTile(locale, localeViewModel);
            }).toList(),
            const SizedBox(height: 16),

            // Reset Button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () async {
                  await localeViewModel.resetToDefault();
                },
                child: Text(
                  AppLocalizations.of(context)?.resetToEnglish ??
                      'Reset to English',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocaleTile(Locale locale, LocaleViewModel localeViewModel) {
    final isSelected = localeViewModel.isLocaleSelected(locale);
    final localeInfo = localeViewModel.getLocaleInfo(locale, context);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isSelected
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.surface,
      child: ListTile(
        leading: Text(
          localeInfo['flag'] as String,
          style: const TextStyle(fontSize: 24),
        ),
        title: Text(
          localeInfo['displayName'] as String,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : null,
          ),
        ),
        subtitle: Text(
          locale.languageCode.toUpperCase(),
          style: Theme.of(context).textTheme.bodySmall,
        ),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
        onTap: () async {
          await localeViewModel.setLocale(locale);
        },
      ),
    );
  }

  Widget _buildThemeVariantTile(
    AppThemeVariant variant,
    ThemeViewModel themeViewModel,
  ) {
    final isSelected = themeViewModel.isSelected(variant);
    final preview = themeViewModel.getThemePreview(variant);

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      color: isSelected
          ? Theme.of(context).colorScheme.primaryContainer
          : Theme.of(context).colorScheme.surface,
      child: ListTile(
        leading: Icon(
          preview['icon'] as IconData,
          color: isSelected
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : preview['primaryColor'] as Color,
        ),
        title: Text(
          preview['name'] as String,
          style: TextStyle(
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected
                ? Theme.of(context).colorScheme.onPrimaryContainer
                : null,
          ),
        ),
        subtitle: Row(
          children: [
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: preview['primaryColor'] as Color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: preview['secondaryColor'] as Color,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: preview['surfaceColor'] as Color,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
          ],
        ),
        trailing: isSelected
            ? Icon(
                Icons.check_circle,
                color: Theme.of(context).colorScheme.primary,
              )
            : null,
        onTap: () async {
          await themeViewModel.changeThemeVariant(variant);
        },
      ),
    );
  }
}
