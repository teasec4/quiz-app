import 'package:flutter/material.dart';

/// Extensions for showing snackbars with consistent styling.
extension SnackBarX on BuildContext {
  /// Shows an error snackbar with red background.
  void showErrorSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 4),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Theme.of(this).colorScheme.onError),
        ),
        backgroundColor: Theme.of(this).colorScheme.error,
        duration: duration,
        action: onAction != null && actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: onAction,
                textColor: Theme.of(this).colorScheme.onError,
              )
            : null,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  /// Shows a success snackbar with green background.
  void showSuccessSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Theme.of(this).colorScheme.onTertiary),
        ),
        backgroundColor: Theme.of(this).colorScheme.tertiary,
        duration: duration,
        action: onAction != null && actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: onAction,
                textColor: Theme.of(this).colorScheme.onTertiary,
              )
            : null,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  /// Shows an informational snackbar with primary color background.
  void showInfoSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onAction,
    String? actionLabel,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: Theme.of(this).colorScheme.onPrimary),
        ),
        backgroundColor: Theme.of(this).colorScheme.primary,
        duration: duration,
        action: onAction != null && actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: onAction,
                textColor: Theme.of(this).colorScheme.onPrimary,
              )
            : null,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }

  /// Shows a snackbar with custom styling.
  void showCustomSnackBar({
    required String message,
    required Color backgroundColor,
    required Color textColor,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onAction,
    String? actionLabel,
    Color? actionTextColor,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    double borderRadius = 8.0,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: textColor)),
        backgroundColor: backgroundColor,
        duration: duration,
        action: onAction != null && actionLabel != null
            ? SnackBarAction(
                label: actionLabel,
                onPressed: onAction,
                textColor: actionTextColor ?? textColor,
              )
            : null,
        behavior: behavior,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }

  /// Clears all current snackbars.
  void clearSnackBars() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }

  /// Shows a snackbar for operation errors with retry option.
  void showOperationErrorSnackBar({
    required String operation,
    required Object error,
    VoidCallback? onRetry,
  }) {
    String errorMessage;

    if (error is String) {
      errorMessage = error;
    } else if (error.toString().contains('userFriendlyMessage')) {
      // Try to extract user-friendly message if available
      errorMessage = error.toString();
    } else {
      errorMessage = 'Failed to $operation';
    }

    showErrorSnackBar(
      'Error $operation: $errorMessage',
      duration: const Duration(seconds: 5),
      onAction: onRetry,
      actionLabel: 'Retry',
    );
  }

  /// Shows a snackbar for successful operations.
  void showOperationSuccessSnackBar({
    required String operation,
    String? customMessage,
  }) {
    final message = customMessage ?? '$operation successful!';
    showSuccessSnackBar(message, duration: const Duration(seconds: 2));
  }
}
