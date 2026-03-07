import 'package:flutter/material.dart';

/// A reusable widget for displaying a loading overlay with semi-transparent background.
class LoadingOverlayWidget extends StatelessWidget {
  /// The opacity of the overlay background (0.0 to 1.0)
  final double opacity;

  /// The color of the overlay background. If null, uses Theme.of(context).colorScheme.scrim
  final Color? backgroundColor;

  /// The color of the progress indicator. If null, uses Theme.of(context).colorScheme.primary
  final Color? progressColor;

  /// The size of the progress indicator
  final double progressSize;

  /// Whether to show the progress indicator
  final bool showProgressIndicator;

  /// Optional custom widget to display instead of the default progress indicator
  final Widget? customLoader;

  /// Creates a LoadingOverlayWidget
  const LoadingOverlayWidget({
    super.key,
    this.opacity = 0.3,
    this.backgroundColor,
    this.progressColor,
    this.progressSize = 36.0,
    this.showProgressIndicator = true,
    this.customLoader,
  });

  /// Creates a LoadingOverlayWidget with default scrim background
  factory LoadingOverlayWidget.scrim({
    Key? key,
    double opacity = 0.3,
    Color? progressColor,
    double progressSize = 36.0,
    bool showProgressIndicator = true,
    Widget? customLoader,
  }) {
    return LoadingOverlayWidget(
      key: key,
      opacity: opacity,
      progressColor: progressColor,
      progressSize: progressSize,
      showProgressIndicator: showProgressIndicator,
      customLoader: customLoader,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bgColor = backgroundColor ?? colorScheme.scrim;
    final progressIndicatorColor = progressColor ?? colorScheme.primary;

    return Container(
      color: bgColor.withValues(alpha: opacity),
      child: Center(
        child:
            customLoader ??
            (showProgressIndicator
                ? CircularProgressIndicator(
                    color: progressIndicatorColor,
                    strokeWidth: 3.0,
                  )
                : const SizedBox.shrink()),
      ),
    );
  }
}
