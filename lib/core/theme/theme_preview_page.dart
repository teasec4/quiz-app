import 'package:flutter/material.dart';


class ThemePreviewPage extends StatelessWidget {
  const ThemePreviewPage({super.key});

  Widget _colorBox(String label, Color color, Color textColor) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        color: color,
        child: Text(
          label,
          style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Theme Preview"),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // === PRIMARY COLORS ===
            Text("Primary Colors", style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                _colorBox("Primary", colorScheme.primary, colorScheme.onPrimary),
                const SizedBox(width: 8),
                _colorBox(
                  "On Primary",
                  colorScheme.onPrimary,
                  colorScheme.primary,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _colorBox(
                  "Primary\nContainer",
                  colorScheme.primaryContainer,
                  colorScheme.onPrimaryContainer,
                ),
                const SizedBox(width: 8),
                _colorBox(
                  "On Primary\nContainer",
                  colorScheme.onPrimaryContainer,
                  colorScheme.primaryContainer,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // === SECONDARY COLORS ===
            Text("Secondary Colors", style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                _colorBox(
                  "Secondary",
                  colorScheme.secondary,
                  colorScheme.onSecondary,
                ),
                const SizedBox(width: 8),
                _colorBox(
                  "On Secondary",
                  colorScheme.onSecondary,
                  colorScheme.secondary,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _colorBox(
                  "Secondary\nContainer",
                  colorScheme.secondaryContainer,
                  colorScheme.onSecondaryContainer,
                ),
                const SizedBox(width: 8),
                _colorBox(
                  "On Secondary\nContainer",
                  colorScheme.onSecondaryContainer,
                  colorScheme.secondaryContainer,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // === TERTIARY COLORS ===
            Text("Tertiary Colors", style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                _colorBox(
                  "Tertiary",
                  colorScheme.tertiary,
                  colorScheme.onTertiary,
                ),
                const SizedBox(width: 8),
                _colorBox(
                  "On Tertiary",
                  colorScheme.onTertiary,
                  colorScheme.tertiary,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _colorBox(
                  "Tertiary\nContainer",
                  colorScheme.tertiaryContainer,
                  colorScheme.onTertiaryContainer,
                ),
                const SizedBox(width: 8),
                _colorBox(
                  "On Tertiary\nContainer",
                  colorScheme.onTertiaryContainer,
                  colorScheme.tertiaryContainer,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // === ERROR COLORS ===
            Text("Error Colors", style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                _colorBox("Error", colorScheme.error, colorScheme.onError),
                const SizedBox(width: 8),
                _colorBox(
                  "On Error",
                  colorScheme.onError,
                  colorScheme.error,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _colorBox(
                  "Error\nContainer",
                  colorScheme.errorContainer,
                  colorScheme.onErrorContainer,
                ),
                const SizedBox(width: 8),
                _colorBox(
                  "On Error\nContainer",
                  colorScheme.onErrorContainer,
                  colorScheme.errorContainer,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // === SURFACE COLORS ===
            Text("Surface Colors", style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                _colorBox(
                  "Surface",
                  colorScheme.surface,
                  colorScheme.onSurface,
                ),
                const SizedBox(width: 8),
                _colorBox(
                  "On Surface",
                  colorScheme.onSurface,
                  colorScheme.surface,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                _colorBox(
                  "Surface\nVariant",
                  colorScheme.surfaceVariant,
                  colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 8),
                _colorBox(
                  "On Surface\nVariant",
                  colorScheme.onSurfaceVariant,
                  colorScheme.surfaceVariant,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // === OUTLINE COLORS ===
            Text("Outline Colors", style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                _colorBox(
                  "Outline",
                  colorScheme.outline,
                  colorScheme.surface,
                ),
                const SizedBox(width: 8),
                _colorBox(
                  "Outline\nVariant",
                  colorScheme.outlineVariant,
                  colorScheme.surface,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // === SCRIM & SHADOW ===
            Text("Scrim & Shadow", style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Row(
              children: [
                _colorBox(
                  "Scrim",
                  colorScheme.scrim,
                  colorScheme.surface,
                ),
                const SizedBox(width: 8),
                _colorBox(
                  "Shadow",
                  colorScheme.shadow,
                  colorScheme.surface,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // === BUTTONS DEMO ===
            Text("Button Examples", style: textTheme.titleLarge),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Primary"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary,
                    foregroundColor: colorScheme.onSecondary,
                  ),
                  onPressed: () {},
                  child: const Text("Secondary"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.tertiary,
                    foregroundColor: colorScheme.onTertiary,
                  ),
                  onPressed: () {},
                  child: const Text("Tertiary"),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.error,
                    foregroundColor: colorScheme.onError,
                  ),
                  onPressed: () {},
                  child: const Text("Error"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}