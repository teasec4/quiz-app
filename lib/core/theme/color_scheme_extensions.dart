import 'package:flutter/material.dart';

/// Helper function to convert opacity (0.0-1.0) to alpha value (0-255)
double _alphaFromOpacity(double opacity) => (opacity * 255).roundToDouble();

/// Extensions for ColorScheme to provide semantic color names and utilities
extension ColorSchemeExtensions on ColorScheme {
  /// Success color (alias for tertiary)
  Color get success => tertiary;

  /// Success container color (alias for tertiaryContainer)
  Color get successContainer => tertiaryContainer;

  /// On success color (alias for onTertiary)
  Color get onSuccess => onTertiary;

  /// On success container color (alias for onTertiaryContainer)
  Color get onSuccessContainer => onTertiaryContainer;

  /// Warning color (Amber-500 from Material Design palette)
  Color get warning => const Color(0xFFF59E0B);

  /// Warning container color (Amber-100 from Material Design palette)
  Color get warningContainer => const Color(0xFFFEF3C7);

  /// On warning color (Black for sufficient contrast on warning color)
  Color get onWarning => const Color(0xFF000000);

  /// On warning container color (Amber-900 for sufficient contrast)
  Color get onWarningContainer => const Color(0xFF78350F);

  /// Info color (Blue-500 from Material Design palette)
  Color get info => const Color(0xFF3B82F6);

  /// Info container color (Blue-100 from Material Design palette)
  Color get infoContainer => const Color(0xFFDBEAFE);

  /// On info color (White for sufficient contrast on info color)
  Color get onInfo => const Color(0xFFFFFFFF);

  /// On info container color (Blue-900 for sufficient contrast)
  Color get onInfoContainer => const Color(0xFF1E3A8A);

  /// Gets a slightly darker version of a color for hover states
  Color darken(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0).toDouble())
        .toColor();
  }

  /// Gets a slightly lighter version of a color for pressed states
  Color lighten(Color color, [double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(color);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0).toDouble())
        .toColor();
  }

  /// Gets a color with adjusted opacity (replacement for deprecated withOpacity)
  Color withAdjustedOpacity(Color color, double opacity) {
    assert(opacity >= 0 && opacity <= 1);
    return color.withValues(alpha: _alphaFromOpacity(opacity));
  }

  /// Checks if the color scheme is in dark mode
  bool get isDark => brightness == Brightness.dark;

  /// Gets the appropriate surface color variant based on elevation
  Color surfaceForElevation(double elevation) {
    if (elevation <= 0) return surface;
    if (elevation <= 1) return surfaceContainerLow;
    if (elevation <= 3) return surfaceContainer;
    if (elevation <= 6) return surfaceContainerHigh;
    return surfaceContainerHighest;
  }

  /// Gets text color for a given background color with proper contrast
  Color textColorForBackground(Color background) {
    // Calculate relative luminance
    final luminance = background.computeLuminance();
    // Use onSurface for dark backgrounds, onSurface for light backgrounds
    return luminance > 0.5 ? onSurface : onSurface;
  }

  /// Gets a color for disabled state
  Color get disabled => onSurface.withValues(alpha: _alphaFromOpacity(0.38));

  /// Gets a color for disabled container
  Color get disabledContainer =>
      surfaceContainerHighest.withValues(alpha: _alphaFromOpacity(0.12));

  /// Gets on color for disabled state
  Color get onDisabled => onSurface.withValues(alpha: _alphaFromOpacity(0.38));

  /// Gets a color for focus state
  Color get focus => primary.withValues(alpha: _alphaFromOpacity(0.12));

  /// Gets a color for hover state
  Color get hover => onSurface.withValues(alpha: _alphaFromOpacity(0.08));

  /// Gets a color for pressed state
  Color get pressed => onSurface.withValues(alpha: _alphaFromOpacity(0.12));

  /// Gets a color for selected state
  Color get selected => primaryContainer;

  /// Gets on color for selected state
  Color get onSelected => onPrimaryContainer;

  /// Gets a color for activated state
  Color get activated => secondaryContainer;

  /// Gets on color for activated state
  Color get onActivated => onSecondaryContainer;

  /// Gets a color for dragged state
  Color get dragged =>
      surfaceContainerHighest.withValues(alpha: _alphaFromOpacity(0.16));

  /// Utility to get a color with proper contrast for text
  Color get textPrimary => onSurface;

  /// Utility to get a secondary text color
  Color get textSecondary => onSurfaceVariant;

  /// Utility to get a disabled text color
  Color get textDisabled =>
      onSurface.withValues(alpha: _alphaFromOpacity(0.38));

  /// Utility to get a hint text color
  Color get textHint =>
      onSurfaceVariant.withValues(alpha: _alphaFromOpacity(0.6));

  /// Gets a border color for cards
  Color get cardBorder => outlineVariant;

  /// Gets a border color for inputs
  Color get inputBorder => outline;

  /// Gets a border color for focused inputs
  Color get inputFocusedBorder => primary;

  /// Gets a border color for error inputs
  Color get inputErrorBorder => error;

  /// Gets a fill color for inputs
  Color get inputFill => surfaceContainerHighest;

  /// Gets a fill color for disabled inputs
  Color get inputDisabledFill =>
      surfaceContainerHighest.withValues(alpha: _alphaFromOpacity(0.04));

  /// Gets a color for dividers
  Color get divider => outlineVariant;

  /// Gets a color for subtle dividers
  Color get dividerSubtle =>
      outlineVariant.withValues(alpha: _alphaFromOpacity(0.5));

  /// Gets a color for success badges
  Color get badgeSuccess => successContainer;

  /// Gets a color for warning badges
  Color get badgeWarning => warningContainer;

  /// Gets a color for error badges
  Color get badgeError => errorContainer;

  /// Gets a color for info badges
  Color get badgeInfo => infoContainer;

  /// Gets a color for neutral badges
  Color get badgeNeutral => surfaceContainerHighest;

  /// Gets text color for success badges
  Color get onBadgeSuccess => onSuccessContainer;

  /// Gets text color for warning badges
  Color get onBadgeWarning => onWarningContainer;

  /// Gets text color for error badges
  Color get onBadgeError => onErrorContainer;

  /// Gets text color for info badges
  Color get onBadgeInfo => onInfoContainer;

  /// Gets text color for neutral badges
  Color get onBadgeNeutral => onSurfaceVariant;
}

/// Extension for Color to provide utility methods
extension ColorExtensions on Color {
  /// Gets a slightly darker version of the color
  Color darken([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness - amount).clamp(0.0, 1.0).toDouble())
        .toColor();
  }

  /// Gets a slightly lighter version of the color
  Color lighten([double amount = 0.1]) {
    assert(amount >= 0 && amount <= 1);
    final hsl = HSLColor.fromColor(this);
    return hsl
        .withLightness((hsl.lightness + amount).clamp(0.0, 1.0).toDouble())
        .toColor();
  }

  /// Gets a color with adjusted opacity (replacement for deprecated withOpacity)
  Color withAdjustedOpacity(double opacity) {
    assert(opacity >= 0 && opacity <= 1);
    return withValues(alpha: _alphaFromOpacity(opacity));
  }

  /// Checks if the color is light (suitable for dark text)
  bool get isLight {
    final luminance = computeLuminance();
    return luminance > 0.5;
  }

  /// Checks if the color is dark (suitable for light text)
  bool get isDark {
    final luminance = computeLuminance();
    return luminance <= 0.5;
  }

  /// Gets an appropriate text color for this background color
  Color get contrastingText {
    return isLight ? const Color(0xFF000000) : const Color(0xFFFFFFFF);
  }

  /// Gets a color that contrasts well with this color
  Color get contrastingColor {
    return isLight ? darken(0.3) : lighten(0.3);
  }
}
