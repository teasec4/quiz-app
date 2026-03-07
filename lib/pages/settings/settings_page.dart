import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bookexample/view_models/theme_view_model.dart';
import 'package:bookexample/core/theme/app_theme.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String _selectedLanguage = 'en';

  @override
  Widget build(BuildContext context) {
    final themeViewModel = context.watch<ThemeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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

                // Language Switch
                Card(
                  child: ListTile(
                    title: const Text('Language'),
                    subtitle: const Text('Select application language'),
                    trailing: DropdownButton<String>(
                      value: _selectedLanguage,
                      underline: const SizedBox(),
                      items: const [
                        DropdownMenuItem(value: 'en', child: Text('English')),
                        DropdownMenuItem(value: 'zh', child: Text('中文')),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedLanguage = value;
                          });
                        }
                      },
                    ),
                  ),
                ),
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
              'Theme Settings',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Customize the appearance of the application',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 16),

            // Dark Mode Switch
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('Dark Mode'),
              subtitle: const Text('Toggle dark theme'),
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
              'Theme Variant',
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
                child: const Text('Reset to Defaults'),
              ),
            ),
          ],
        ),
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
