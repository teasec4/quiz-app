import 'package:bookexample/view_models/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:bookexample/core/theme/spacing.dart';

/// A reusable widget for displaying error banners at the top of the screen.
class ErrorBannerWidget extends StatelessWidget {
  /// The error message to display
  final String message;

  /// The background color of the banner. If null, uses Theme.of(context).colorScheme.errorContainer
  final Color? backgroundColor;

  /// The text color of the banner. If null, uses Theme.of(context).colorScheme.onErrorContainer
  final Color? textColor;

  /// The icon to display. If null, uses Icons.error_outline
  final IconData? icon;

  /// The color of the icon. If null, uses Theme.of(context).colorScheme.onErrorContainer
  final Color? iconColor;

  /// The size of the icon
  final double iconSize;

  /// Whether to show the icon
  final bool showIcon;

  /// The padding inside the banner
  final EdgeInsetsGeometry padding;

  /// The margin around the banner
  final EdgeInsetsGeometry margin;

  /// The border radius of the banner
  final double borderRadius;

  /// The elevation of the banner
  final double elevation;

  /// Callback when the banner is tapped
  final VoidCallback? onTap;

  /// Callback when the close button is tapped
  final VoidCallback? onClose;

  /// Whether to show a close button
  final bool showCloseButton;

  /// Creates an ErrorBannerWidget
  const ErrorBannerWidget({
    super.key,
    required this.message,
    this.backgroundColor,
    this.textColor,
    this.icon,
    this.iconColor,
    this.iconSize = 24.0,
    this.showIcon = true,
    this.padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
    this.margin = const EdgeInsets.all(AppSpacing.sm),
    this.borderRadius = AppSpacing.sm,
    this.elevation = 2.0,
    this.onTap,
    this.onClose,
    this.showCloseButton = true,
  });

  /// Creates an ErrorBannerWidget from an error object with user-friendly message
  factory ErrorBannerWidget.fromError({
    Key? key,
    required Object error,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
    Color? iconColor,
    double iconSize = 24.0,
    bool showIcon = true,
    EdgeInsetsGeometry padding = const EdgeInsets.symmetric(
      horizontal: AppSpacing.md,
      vertical: AppSpacing.sm,
    ),
    EdgeInsetsGeometry margin = const EdgeInsets.all(AppSpacing.sm),
    double borderRadius = AppSpacing.sm,
    double elevation = 2.0,
    VoidCallback? onTap,
    VoidCallback? onClose,
    bool showCloseButton = true,
  }) {
    String errorMessage;

    if (error is String) {
      errorMessage = error;
    } else if (error is ErrorState) {
      errorMessage = error.userFriendlyMessage;
    } else if (error.toString().contains('userFriendlyMessage')) {
      // Try to extract user-friendly message if available
      errorMessage = error.toString();
    } else {
      errorMessage = 'An error occurred. Please try again.';
    }

    return ErrorBannerWidget(
      key: key,
      message: errorMessage,
      backgroundColor: backgroundColor,
      textColor: textColor,
      icon: icon,
      iconColor: iconColor,
      iconSize: iconSize,
      showIcon: showIcon,
      padding: padding,
      margin: margin,
      borderRadius: borderRadius,
      elevation: elevation,
      onTap: onTap,
      onClose: onClose,
      showCloseButton: showCloseButton,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);

    return Padding(
      padding: margin,
      child: Material(
        elevation: elevation,
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: backgroundColor ?? colorScheme.errorContainer,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Row(
              children: [
                if (showIcon)
                  Padding(
                    padding: const EdgeInsets.only(right: 12.0),
                    child: Icon(
                      icon ?? Icons.error_outline,
                      color: iconColor ?? colorScheme.onErrorContainer,
                      size: iconSize,
                    ),
                  ),
                Expanded(
                  child: Text(
                    message,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: textColor ?? colorScheme.onErrorContainer,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (showCloseButton && onClose != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: IconButton(
                      icon: Icon(
                        Icons.close,
                        color: iconColor ?? colorScheme.onErrorContainer,
                        size: 20.0,
                      ),
                      onPressed: onClose,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 36,
                        minHeight: 36,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
