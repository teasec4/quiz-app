import 'package:bookexample/core/theme/app_colors.dart';
import 'package:flutter/material.dart';


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

      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: Colors.white,
        elevation: 4,
        hoverElevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
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
          return const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
          );
        }),

        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return IconThemeData(
              size: 26,
              color: scheme.primary,
            );
          }
          return IconThemeData(
            size: 24,
            color: scheme.onSurfaceVariant,
          );
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

enum AppThemeVariant{
  minimal,
  tech,
  modern,
}

class AppThemeFactory {
  static ThemeData getTheme(AppThemeVariant variant) {
    final scheme = getColorScheme(variant);
    return AppTheme.lightTheme(scheme);
  }

  static ColorScheme getColorScheme(AppThemeVariant variant) {
    switch (variant) {
      case AppThemeVariant.minimal:
        return ColorScheme.fromSeed(
          seedColor: const Color(0xFF334155),
          secondary: const Color(0xFF64748B),
          brightness: Brightness.light,
        ).copyWith(
          error: AppColors.error,
          tertiary: AppColors.success,
        );
        

      case AppThemeVariant.tech:
        return ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5),
          secondary: const Color(0xFF9333EA),
          brightness: Brightness.light,
        ).copyWith(
          error: AppColors.error,
          tertiary: AppColors.success,
        );

      case AppThemeVariant.modern:
        return ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          secondary: const Color(0xFF14B8A6),
          brightness: Brightness.light,
        ).copyWith(
          error: AppColors.error,
          tertiary: AppColors.success,
        );
    }
  }
}