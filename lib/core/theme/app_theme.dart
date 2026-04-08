import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'spacing.dart';

class AppColors {
  // Success / Green (Emerald-600 palette - matches modern design)
  static const Color success = Color(0xFF059669);

  // Error / Red (Red-600 palette - matches modern design)
  static const Color error = Color(0xFFDC2626);

  // Warning / Amber (Amber-500 palette)
  static const Color warning = Color(0xFFF59E0B);

  // Info / Blue (Blue-500 palette)
  static const Color info = Color(0xFF3B82F6);
}

class AppTheme {
  static ThemeData lightTheme(ColorScheme scheme) {
    final textTheme = GoogleFonts.interTextTheme();

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      textTheme: textTheme,
      scaffoldBackgroundColor: scheme.surface,

      cardColor: scheme.surfaceContainerHighest,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.primaryContainer,
        foregroundColor: scheme.onPrimaryContainer,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 4,
        hoverElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: scheme.outline),
          foregroundColor: scheme.onSurfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
        ),
      ),

      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: scheme.surface,
        indicatorColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),

        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              letterSpacing: 0.3,
              color: scheme.onSecondaryContainer,
              fontFamily: GoogleFonts.inter().fontFamily,
            );
          }
          return TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: scheme.onSurfaceVariant,
            fontFamily: GoogleFonts.inter().fontFamily,
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

  static ThemeData darkTheme(ColorScheme scheme) {
    final textTheme = GoogleFonts.interTextTheme(ThemeData.dark().textTheme);

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      brightness: Brightness.dark,
      textTheme: textTheme,

      scaffoldBackgroundColor: scheme.surface,

      cardColor: scheme.surfaceContainerHighest,

      appBarTheme: AppBarTheme(
        backgroundColor: scheme.surface,
        foregroundColor: scheme.onSurface,
        centerTitle: true,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        elevation: 4,
        hoverElevation: 8,
        shape: RoundedRectangleBorder(borderRadius: AppSpacing.borderRadiusMd),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: scheme.outline),
          foregroundColor: scheme.onSurfaceVariant,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
          ),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: scheme.primaryContainer,
          foregroundColor: scheme.onPrimaryContainer,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacing.borderRadiusMd,
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
              fontFamily: GoogleFonts.inter().fontFamily,
            );
          }
          return TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: scheme.onSurfaceVariant,
            fontFamily: GoogleFonts.inter().fontFamily,
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

class AppThemeFactory {
  static ThemeData getTheme({bool darkMode = false}) {
    final scheme = getColorScheme(darkMode: darkMode);
    return darkMode ? AppTheme.darkTheme(scheme) : AppTheme.lightTheme(scheme);
  }

  static ColorScheme getColorScheme({bool darkMode = false}) {
    final brightness = darkMode ? Brightness.dark : Brightness.light;

    return ColorScheme.fromSeed(
      seedColor: const Color(0xFF334155),
      secondary: const Color(0xFF94A3B8),
      brightness: brightness,
    ).copyWith(
      error: AppColors.error,
      tertiary: AppColors.success,
      surface: darkMode ? const Color(0xFF1E293B) : null,
      surfaceContainerHighest: darkMode ? const Color(0xFF334155) : null,
    );
  }
}
