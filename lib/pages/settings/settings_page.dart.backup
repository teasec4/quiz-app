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
            const SizedBox(height: 24),

            // Reset Settings Section
            _buildResetSettingsSection(
              context,
              themeViewModel,
              localeViewModel,
              l10n,
            ),
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
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Row(
            children: [
              Icon(Icons.palette, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n?.themeSettings ?? 'Theme Settings',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            themeViewModel.isDarkMode ? Icons.dark_mode : Icons.light_mode,
            color: theme.colorScheme.onPrimaryContainer,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
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
        Text(
          l10n?.themeVariant ?? 'Theme Variant',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
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
        constraints: BoxConstraints(minWidth: 110, maxWidth: 130),
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
              width: 40,
              height: 40,
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
            const SizedBox(height: 8),
            // Theme Name
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 300),
              style: theme.textTheme.labelMedium!.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected
                    ? theme.colorScheme.onPrimaryContainer
                    : theme.colorScheme.onSurface,
              ),
              child: Text(
                preview['name'] as String,
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Row(
            children: [
              Icon(Icons.language, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n?.languageSettings ?? 'Language Settings',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
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
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.primaryContainer
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                // Flag
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colorScheme.primary.withOpacity(0.1)
                        : theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    localeInfo['flag'] as String,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(width: 12),
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
        if (locale != localeViewModel.supportedLocales.last)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Divider(color: theme.colorScheme.outlineVariant, height: 1),
          ),
      ],
    );
  }

  Widget _buildResetSettingsSection(
    BuildContext context,
    ThemeViewModel themeViewModel,
    LocaleViewModel localeViewModel,
    AppLocalizations? l10n,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 12),
          child: Row(
            children: [
              Icon(Icons.settings, color: theme.colorScheme.primary, size: 20),
              const SizedBox(width: 8),
              Text(
                l10n?.resetSettings ?? 'Reset Settings',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),

        // Reset Settings Card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  l10n?.resetSettingsDescription ??
                      'Reset all settings to default values',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () async {
                      // Reset both theme and language
                      await themeViewModel.resetToDefaults();
                      await localeViewModel.resetToDefault();

                      _showSnackBar(
                        context,
                        l10n?.allSettingsReset ??
                            'All settings reset to defaults',
                      );
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: theme.colorScheme.primary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.restart_alt,
                          size: 20,
                          color: theme.colorScheme.onPrimary,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          l10n?.resetAllSettings ?? 'Reset All Settings',
                          style: theme.textTheme.bodyLarge?.copyWith(
                            color: theme.colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        action: SnackBarAction(
          label: 'OK',
          textColor: Theme.of(context).colorScheme.primary,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }
}
