import 'package:flutter/material.dart';

class AppColors {
  // Success / Green (Emerald-600 palette - matches modern design)
  static const Color success = Color(0xFF059669);

  // Error / Red (Red-600 palette - matches modern design)
  static const Color error = Color(0xFFDC2626);
}

class AppTheme {
  static ThemeData lightTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,

      scaffoldBackgroundColor: scheme.surface,

      cardColor: scheme.surfaceContainerHighest,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        centerTitle: true,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 4,
        hoverElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: scheme.primary),
          foregroundColor: scheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),

        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              letterSpacing: 0.3,
            );
          }
          return const TextStyle(fontWeight: FontWeight.w400, fontSize: 12);
        }),

        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(size: 26, color: scheme.primary);
          }
          return IconThemeData(size: 24, color: scheme.onSurfaceVariant);
        }),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
        ),
      ),
    );
  }

  static ThemeData darkTheme(ColorScheme scheme) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: Brightness.dark,

      scaffoldBackgroundColor: scheme.surface,

      cardColor: scheme.surfaceContainerHighest,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        centerTitle: true,
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 4,
        hoverElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: scheme.outline),
          foregroundColor: scheme.onSurfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: scheme.secondaryContainer,
        overlayColor: WidgetStateProperty.all(Colors.transparent),

        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              letterSpacing: 0.3,
              color: scheme.onSecondaryContainer,
            );
          }
          return TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: scheme.onSurfaceVariant,
          );
        }),

        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(size: 26, color: scheme.onSecondaryContainer);
          }
          return IconThemeData(size: 24, color: scheme.onSurfaceVariant);
        }),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: scheme.primary,
          foregroundColor: scheme.onPrimary,
        ),
      ),
    );
  }
}

enum AppThemeVariant { minimal, tech, modern }

class AppThemeFactory {
  static ThemeData getTheme(AppThemeVariant variant, {bool darkMode = false}) {
    final scheme = getColorScheme(variant, darkMode: darkMode);
    return darkMode ? AppTheme.darkTheme(scheme) : AppTheme.lightTheme(scheme);
  }

  static ColorScheme getColorScheme(
    AppThemeVariant variant, {
    bool darkMode = false,
  }) {
    final brightness = darkMode ? Brightness.dark : Brightness.light;

    switch (variant) {
      case AppThemeVariant.minimal:
        return ColorScheme.fromSeed(
          seedColor: const Color(0xFF334155),
          secondary: const Color(0xFF94A3B8),
          brightness: brightness,
        ).copyWith(
          error: AppColors.error,
          tertiary: AppColors.success,
          onTertiary: Colors.white,
          surface: darkMode ? const Color(0xFF1E293B) : null,
          surfaceContainerHighest: darkMode ? const Color(0xFF334155) : null,
        );

      case AppThemeVariant.tech:
        return ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          secondary: const Color(0xFFA855F7),
          brightness: brightness,
        ).copyWith(
          error: AppColors.error,
          tertiary: AppColors.success,
          onTertiary: Colors.white,
          surface: darkMode ? const Color(0xFF1E1B4B) : null,
          surfaceContainerHighest: darkMode ? const Color(0xFF312E81) : null,
        );

      case AppThemeVariant.modern:
        return ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          secondary: const Color(0xFF0D9488),
          brightness: brightness,
        ).copyWith(
          error: AppColors.error,
          tertiary: AppColors.success,
          onTertiary: Colors.white,
          surface: darkMode ? const Color(0xFF0C4A6E) : null,
          surfaceContainerHighest: darkMode ? const Color(0xFF075985) : null,
        );
    }
  }
}
