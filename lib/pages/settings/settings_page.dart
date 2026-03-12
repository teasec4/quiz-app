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

    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n?.settingsTitle ?? 'Settings')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Section
            _buildThemeSection(context, themeViewModel, l10n),
            const SizedBox(height: 24),

            // Language Section
            _buildLanguageSection(context, localeViewModel, l10n),
          ],
        ),
      ),
    );
  }

  Widget _buildThemeSection(
    BuildContext context,
    ThemeViewModel themeViewModel,
    AppLocalizations? l10n,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Text(
          l10n?.themeSettings ?? 'Theme Settings',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        // Theme Card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Dark Mode Toggle
                _buildDarkModeToggle(context, themeViewModel, l10n),
                const SizedBox(height: 16),

                // Divider
                Divider(color: theme.colorScheme.outlineVariant, height: 1),
                const SizedBox(height: 16),

                // Theme Variants
                _buildThemeVariants(context, themeViewModel, l10n),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDarkModeToggle(
    BuildContext context,
    ThemeViewModel themeViewModel,
    AppLocalizations? l10n,
  ) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n?.darkMode ?? 'Dark Mode',
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                l10n?.toggleDarkTheme ?? 'Toggle dark theme',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Switch.adaptive(
          value: themeViewModel.isDarkMode,
          onChanged: (value) async {
            await themeViewModel.setDarkMode(value);
          },
          activeColor: theme.colorScheme.primary,
        ),
      ],
    );
  }

  Widget _buildThemeVariants(
    BuildContext context,
    ThemeViewModel themeViewModel,
    AppLocalizations? l10n,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 16,
          runSpacing: 16,
          children: themeViewModel.availableVariants.map((variant) {
            return _buildThemeVariantChip(context, variant, themeViewModel);
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildThemeVariantChip(
    BuildContext context,
    AppThemeVariant variant,
    ThemeViewModel themeViewModel,
  ) {
    // Theme is used implicitly by Theme.of(context) in child widgets
    final theme = Theme.of(context);
    final isSelected = themeViewModel.isSelected(variant);
    final preview = themeViewModel.getThemePreview(variant);
    final color = preview['primaryColor'] as Color;

    return GestureDetector(
      onTap: () async {
        await themeViewModel.changeThemeVariant(variant);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        constraints: BoxConstraints(minWidth: 50, maxWidth: 70),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.primaryContainer
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Column(
          children: [
            // Color Preview
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 20,
                        key: UniqueKey(),
                      )
                    : SizedBox.shrink(key: UniqueKey()),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageSection(
    BuildContext context,
    LocaleViewModel localeViewModel,
    AppLocalizations? l10n,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Text(
          l10n?.languageSettings ?? 'Language Settings',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),

        // Language Card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: localeViewModel.supportedLocales.map((locale) {
                return _buildLanguageTile(context, locale, localeViewModel);
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageTile(
    BuildContext context,
    Locale locale,
    LocaleViewModel localeViewModel,
  ) {
    final theme = Theme.of(context);
    final isSelected = localeViewModel.isLocaleSelected(locale);
    final localeInfo = localeViewModel.getLocaleInfo(locale, context);

    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            await localeViewModel.setLocale(locale);
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                // Language Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: theme.textTheme.bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500,
                          color: isSelected
                              ? theme.colorScheme.onPrimaryContainer
                              : theme.colorScheme.onSurface,
                        ),
                        child: Text(localeInfo['displayName'] as String),
                      ),
                      const SizedBox(height: 2),
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: theme.textTheme.bodySmall!.copyWith(
                          color: isSelected
                              ? theme.colorScheme.onPrimaryContainer
                                    .withOpacity(0.8)
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                        child: Text(locale.languageCode.toUpperCase()),
                      ),
                    ],
                  ),
                ),
                // Selection Indicator
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isSelected
                      ? Icon(
                          Icons.check_circle,
                          color: theme.colorScheme.primary,
                          size: 24,
                          key: UniqueKey(),
                        )
                      : SizedBox(width: 24, height: 24, key: UniqueKey()),
                ),
              ],
            ),
          ),
        ),
        // Divider (except for last item)
        // if (locale != localeViewModel.supportedLocales.last)
        // Divider(color: theme.colorScheme.outlineVariant, height: 1),
      ],
    );
  }
}
