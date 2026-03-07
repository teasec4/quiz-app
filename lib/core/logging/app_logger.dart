import 'package:logger/logger.dart';

/// Centralized logging utility for the application.
///
/// Provides static methods for logging at different levels:
/// - debug: Detailed information for debugging
/// - info: General informational messages
/// - warning: Warning messages for potentially harmful situations
/// - error: Error messages with stack traces
class AppLogger {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // Number of method calls to be displayed
      errorMethodCount: 8, // Number of method calls for errors
      lineLength: 120, // Width of the output
      colors: true, // Colorful log messages
      printEmojis: true, // Print emojis for log levels
      printTime: true, // Print timestamp
    ),
  );

  /// Log a debug message.
  ///
  /// Use for detailed information that is useful during development
  /// and debugging but not needed in production.
  ///
  /// Example:
  /// ```dart
  /// AppLogger.debug('User tapped button', {'buttonId': 'submit'});
  /// ```
  static void debug(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  /// Log an informational message.
  ///
  /// Use for important events that should be logged in production,
  /// such as successful operations or state changes.
  ///
  /// Example:
  /// ```dart
  /// AppLogger.info('Folder created successfully', folderId);
  /// ```
  static void info(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  /// Log a warning message.
  ///
  /// Use for potentially harmful situations that don't prevent
  /// the application from functioning but should be investigated.
  ///
  /// Example:
  /// ```dart
  /// AppLogger.warning('Deprecated API called', deprecatedMethod);
  /// ```
  static void warning(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  /// Log an error message.
  ///
  /// Use for error conditions that should be logged with full context
  /// including stack traces for debugging.
  ///
  /// Example:
  /// ```dart
  /// AppLogger.error('Failed to save data', exception, stackTrace);
  /// ```
  static void error(String message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }
}
