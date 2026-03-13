import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookexample/view_models/theme_view_model.dart';
import 'package:bookexample/view_models/locale_view_model.dart';
import 'package:bookexample/core/theme/app_theme.dart';
import 'package:bookexample/core/theme/spacing.dart';
import 'package:bookexample/core/theme/text_styles.dart';
import 'package:bookexample/core/theme/color_scheme_extensions.dart';
import 'package:bookexample/l10n/app_localizations.dart';
import 'package:bookexample/core/theme/semantic_color_demo.dart';

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
        padding: AppSpacing.screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Theme Section
            _buildThemeSection(context, themeViewModel, l10n),
            AppSpacing.verticalLg,

            // Language Section
            _buildLanguageSection(context, localeViewModel, l10n),
            AppSpacing.verticalLg,

            // Developer Section
            _buildDeveloperSection(context, l10n),
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
          style: context.titleLarge,
        ),

        // Theme Card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: AppSpacing.cardPadding,
            child: Column(
              children: [
                // Dark Mode Toggle
                _buildDarkModeToggle(context, themeViewModel, l10n),
                AppSpacing.verticalMd,

                // Divider
                Divider(color: theme.colorScheme.outlineVariant, height: 1),
                AppSpacing.verticalMd,

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
                style: context.bodyLargeMedium,
              ),
              AppSpacing.verticalXs,
              Text(
                l10n?.toggleDarkTheme ?? 'Toggle dark theme',
                style: context.bodySmall.copyWith(
                  color: theme.colorScheme.textSecondary,
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
          trackColor: WidgetStateProperty.all(
            theme.colorScheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }

  Widget _buildThemeVariants(
    BuildContext context,
    ThemeViewModel themeViewModel,
    AppLocalizations? l10n,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
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
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? theme.colorScheme.selected
              : theme.colorScheme.surfaceContainerHighest,
          borderRadius: AppSpacing.borderRadiusMd,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.colorScheme.cardBorder,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: theme.colorScheme.primary.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                    spreadRadius: 0.5,
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
                borderRadius: AppSpacing.borderRadiusSm,
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
          style: context.titleLarge,
        ),

        // Language Card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: AppSpacing.cardPadding,
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
            padding: EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: isSelected
                  ? theme.colorScheme.selected
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
                        style: context.bodyLargeMedium.copyWith(
                          color: isSelected
                              ? theme.colorScheme.onSelected
                              : theme.colorScheme.textPrimary,
                        ),
                        child: Text(localeInfo['displayName'] as String),
                      ),
                      AppSpacing.verticalXs,
                      AnimatedDefaultTextStyle(
                        duration: const Duration(milliseconds: 300),
                        style: context.bodySmall.copyWith(
                          color: isSelected
                              ? theme.colorScheme.onSelected.withOpacity(0.8)
                              : theme.colorScheme.textSecondary,
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
                      : Icon(
                          Icons.circle_outlined,
                          color: theme.colorScheme.textDisabled,
                          size: 24,
                          key: UniqueKey(),
                        ),
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

  Widget _buildDeveloperSection(BuildContext context, AppLocalizations? l10n) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Text('Developer Tools', style: context.titleLarge),

        // Developer Card
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: AppSpacing.cardPadding,
            child: Column(
              children: [
                // Semantic Colors Demo
                ListTile(
                  leading: Icon(
                    Icons.color_lens_outlined,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    'Semantic Colors Demo',
                    style: context.bodyLargeMedium,
                  ),
                  subtitle: Text(
                    'View all semantic colors and their usage',
                    style: context.bodySmall.copyWith(
                      color: theme.colorScheme.textSecondary,
                    ),
                  ),
                  trailing: Icon(
                    Icons.chevron_right,
                    color: theme.colorScheme.textSecondary,
                  ),
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SemanticColorDemo(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
