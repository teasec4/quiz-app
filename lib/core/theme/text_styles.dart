import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// AppTextStyles provides a semantic typography system for consistent text styling
class AppTextStyles {
  // Font family
  static const String fontFamily = 'Inter';

  // Display styles (largest text, for hero sections)
  static TextStyle displayLarge(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).displayLarge;
    return baseStyle?.copyWith(
          fontSize: 57.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        ) ??
        const TextStyle(
          fontSize: 57.0,
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
          height: 1.12,
        );
  }

  static TextStyle displayMedium(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).displayMedium;
    return baseStyle?.copyWith(
          fontSize: 45.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.16,
        ) ??
        const TextStyle(
          fontSize: 45.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.16,
        );
  }

  static TextStyle displaySmall(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).displaySmall;
    return baseStyle?.copyWith(
          fontSize: 36.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.22,
        ) ??
        const TextStyle(
          fontSize: 36.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.22,
        );
  }

  // Headline styles (for page titles)
  static TextStyle headlineLarge(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).headlineLarge;
    return baseStyle?.copyWith(
          fontSize: 32.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.25,
        ) ??
        const TextStyle(
          fontSize: 32.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.25,
        );
  }

  static TextStyle headlineMedium(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).headlineMedium;
    return baseStyle?.copyWith(
          fontSize: 28.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.29,
        ) ??
        const TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.29,
        );
  }

  static TextStyle headlineSmall(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).headlineSmall;
    return baseStyle?.copyWith(
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.33,
        ) ??
        const TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.33,
        );
  }

  // Title styles (for section headers)
  static TextStyle titleLarge(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).titleLarge;
    return baseStyle?.copyWith(
          fontSize: 22.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.27,
        ) ??
        const TextStyle(
          fontSize: 22.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.0,
          height: 1.27,
        );
  }

  static TextStyle titleMedium(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).titleMedium;
    return baseStyle?.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.5,
        ) ??
        const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.15,
          height: 1.5,
        );
  }

  static TextStyle titleSmall(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).titleSmall;
    return baseStyle?.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ) ??
        const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        );
  }

  // Body styles (for regular text content)
  static TextStyle bodyLarge(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).bodyLarge;
    return baseStyle?.copyWith(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        ) ??
        const TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.5,
          height: 1.5,
        );
  }

  static TextStyle bodyMedium(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).bodyMedium;
    return baseStyle?.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        ) ??
        const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.25,
          height: 1.43,
        );
  }

  static TextStyle bodySmall(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).bodySmall;
    return baseStyle?.copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        ) ??
        const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          letterSpacing: 0.4,
          height: 1.33,
        );
  }

  // Label styles (for buttons, captions, overlines)
  static TextStyle labelLarge(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).labelLarge;
    return baseStyle?.copyWith(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        ) ??
        const TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
          height: 1.43,
        );
  }

  static TextStyle labelMedium(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).labelMedium;
    return baseStyle?.copyWith(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        ) ??
        const TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.33,
        );
  }

  static TextStyle labelSmall(BuildContext context) {
    final baseStyle = GoogleFonts.interTextTheme(
      Theme.of(context).textTheme,
    ).labelSmall;
    return baseStyle?.copyWith(
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        ) ??
        const TextStyle(
          fontSize: 11.0,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.5,
          height: 1.45,
        );
  }

  // Helper methods for common variations

  /// Returns titleLarge with bold weight (commonly used for section headers)
  static TextStyle titleLargeBold(BuildContext context) {
    return titleLarge(context).copyWith(fontWeight: FontWeight.w700);
  }

  /// Returns titleMedium with semibold weight
  static TextStyle titleMediumSemiBold(BuildContext context) {
    return titleMedium(context).copyWith(fontWeight: FontWeight.w600);
  }

  /// Returns bodyLarge with medium weight
  static TextStyle bodyLargeMedium(BuildContext context) {
    return bodyLarge(context).copyWith(fontWeight: FontWeight.w500);
  }

  /// Returns bodyMedium with medium weight
  static TextStyle bodyMediumMedium(BuildContext context) {
    return bodyMedium(context).copyWith(fontWeight: FontWeight.w500);
  }

  /// Returns bodySmall with medium weight
  static TextStyle bodySmallMedium(BuildContext context) {
    return bodySmall(context).copyWith(fontWeight: FontWeight.w500);
  }

  /// Helper to get text style from theme with AppTextStyles fallback
  static TextStyle fromTheme(BuildContext context, TextStyle? style) {
    if (style != null) return style;
    return bodyMedium(context);
  }

  /// Creates a complete TextTheme using AppTextStyles
  static TextTheme createTextTheme(BuildContext context) {
    return TextTheme(
      displayLarge: displayLarge(context),
      displayMedium: displayMedium(context),
      displaySmall: displaySmall(context),
      headlineLarge: headlineLarge(context),
      headlineMedium: headlineMedium(context),
      headlineSmall: headlineSmall(context),
      titleLarge: titleLarge(context),
      titleMedium: titleMedium(context),
      titleSmall: titleSmall(context),
      bodyLarge: bodyLarge(context),
      bodyMedium: bodyMedium(context),
      bodySmall: bodySmall(context),
      labelLarge: labelLarge(context),
      labelMedium: labelMedium(context),
      labelSmall: labelSmall(context),
    );
  }
}

/// Extension for easy access to AppTextStyles from BuildContext
extension AppTextStylesExtension on BuildContext {
  /// Get displayLarge text style
  TextStyle get displayLarge => AppTextStyles.displayLarge(this);

  /// Get displayMedium text style
  TextStyle get displayMedium => AppTextStyles.displayMedium(this);

  /// Get displaySmall text style
  TextStyle get displaySmall => AppTextStyles.displaySmall(this);

  /// Get headlineLarge text style
  TextStyle get headlineLarge => AppTextStyles.headlineLarge(this);

  /// Get headlineMedium text style
  TextStyle get headlineMedium => AppTextStyles.headlineMedium(this);

  /// Get headlineSmall text style
  TextStyle get headlineSmall => AppTextStyles.headlineSmall(this);

  /// Get titleLarge text style
  TextStyle get titleLarge => AppTextStyles.titleLarge(this);

  /// Get titleMedium text style
  TextStyle get titleMedium => AppTextStyles.titleMedium(this);

  /// Get titleSmall text style
  TextStyle get titleSmall => AppTextStyles.titleSmall(this);

  /// Get bodyLarge text style
  TextStyle get bodyLarge => AppTextStyles.bodyLarge(this);

  /// Get bodyMedium text style
  TextStyle get bodyMedium => AppTextStyles.bodyMedium(this);

  /// Get bodySmall text style
  TextStyle get bodySmall => AppTextStyles.bodySmall(this);

  /// Get labelLarge text style
  TextStyle get labelLarge => AppTextStyles.labelLarge(this);

  /// Get labelMedium text style
  TextStyle get labelMedium => AppTextStyles.labelMedium(this);

  /// Get labelSmall text style
  TextStyle get labelSmall => AppTextStyles.labelSmall(this);

  /// Get titleLarge with bold weight
  TextStyle get titleLargeBold => AppTextStyles.titleLargeBold(this);

  /// Get titleMedium with semibold weight
  TextStyle get titleMediumSemiBold => AppTextStyles.titleMediumSemiBold(this);

  /// Get bodyLarge with medium weight
  TextStyle get bodyLargeMedium => AppTextStyles.bodyLargeMedium(this);

  /// Get bodyMedium with medium weight
  TextStyle get bodyMediumMedium => AppTextStyles.bodyMediumMedium(this);

  /// Get bodySmall with medium weight
  TextStyle get bodySmallMedium => AppTextStyles.bodySmallMedium(this);
}
