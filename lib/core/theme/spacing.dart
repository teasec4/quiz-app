import 'package:flutter/material.dart';

/// AppSpacing provides a unified spacing system based on 8px increments
class AppSpacing {
  // Spacing constants in logical pixels
  static const double xs = 4.0; // extra small
  static const double sm = 8.0; // small
  static const double md = 16.0; // medium
  static const double lg = 24.0; // large
  static const double xl = 32.0; // extra large
  static const double xxl = 48.0; // extra extra large

  // Standard padding configurations
  static const EdgeInsets screenPadding = EdgeInsets.all(md);
  static const EdgeInsets cardPadding = EdgeInsets.all(md);
  static const EdgeInsets listItemPadding = EdgeInsets.symmetric(
    vertical: sm,
    horizontal: md,
  );

  // Additional common padding configurations
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    vertical: sm,
    horizontal: md,
  );

  static const EdgeInsets inputFieldPadding = EdgeInsets.symmetric(
    vertical: sm,
    horizontal: md,
  );

  static const EdgeInsets dialogPadding = EdgeInsets.all(lg);

  static const EdgeInsets sectionPadding = EdgeInsets.only(
    top: lg,
    bottom: md,
    left: md,
    right: md,
  );

  // Spacing between widgets
  static const SizedBox verticalXs = SizedBox(height: xs);
  static const SizedBox verticalSm = SizedBox(height: sm);
  static const SizedBox verticalMd = SizedBox(height: md);
  static const SizedBox verticalLg = SizedBox(height: lg);
  static const SizedBox verticalXl = SizedBox(height: xl);
  static const SizedBox verticalXxl = SizedBox(height: xxl);

  static const SizedBox horizontalXs = SizedBox(width: xs);
  static const SizedBox horizontalSm = SizedBox(width: sm);
  static const SizedBox horizontalMd = SizedBox(width: md);
  static const SizedBox horizontalLg = SizedBox(width: lg);
  static const SizedBox horizontalXl = SizedBox(width: xl);
  static const SizedBox horizontalXxl = SizedBox(width: xxl);

  // Border radius constants
  static const BorderRadius borderRadiusSm = BorderRadius.all(
    Radius.circular(sm),
  );
  static const BorderRadius borderRadiusMd = BorderRadius.all(
    Radius.circular(md),
  );
  static const BorderRadius borderRadiusLg = BorderRadius.all(
    Radius.circular(lg),
  );

  // Gap widgets (for use in Row/Column)
  static const gapXs = SizedBox(width: xs, height: xs);
  static const gapSm = SizedBox(width: sm, height: sm);
  static const gapMd = SizedBox(width: md, height: md);
  static const gapLg = SizedBox(width: lg, height: lg);
  static const gapXl = SizedBox(width: xl, height: xl);
}
