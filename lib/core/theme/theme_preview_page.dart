import 'package:flutter/material.dart';


class ThemePreviewPage extends StatelessWidget {
  const ThemePreviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Theme Preview"),
        backgroundColor: colorScheme.primaryContainer,
        foregroundColor: colorScheme.onPrimaryContainer,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primary / Secondary
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: colorScheme.primary,
                    child: Text(
                      "Primary",
                      style: TextStyle(color: colorScheme.onPrimary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: colorScheme.secondary,
                    child: Text(
                      "Secondary",
                      style: TextStyle(color: colorScheme.onSecondary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Tertiary / Error
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: colorScheme.tertiary,
                    child: Text(
                      "Success / Tertiary",
                      style: TextStyle(color: colorScheme.onTertiary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    color: colorScheme.error,
                    child: Text(
                      "Error",
                      style: TextStyle(color: colorScheme.onError),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Surface / SurfaceVariant
            Card(
              color: colorScheme.surface,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "Surface (Card Background)",
                  style: TextStyle(color: colorScheme.onSurface),
                ),
              ),
            ),

            const SizedBox(height: 12),

            Card(
              color: colorScheme.surfaceVariant,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Text(
                  "Surface Variant",
                  style: TextStyle(color: colorScheme.onSurfaceVariant),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Buttons
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text("Primary Button"),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.secondary,
                    foregroundColor: colorScheme.onSecondary,
                  ),
                  onPressed: () {},
                  child: const Text("Secondary Button"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}