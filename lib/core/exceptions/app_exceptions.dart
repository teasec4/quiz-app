/// Base exception class for all application-specific exceptions.
///
/// This provides a consistent structure for error handling across the application,
/// including error codes, original error wrapping, and stack trace preservation.
abstract class AppException implements Exception {
  /// Human-readable error message
  final String message;

  /// Optional error code for categorization
  final String? code;

  /// Original error that caused this exception (if any)
  final dynamic originalError;

  /// Stack trace at the point where this exception was created
  final StackTrace? stackTrace;

  AppException(this.message, {this.code, this.originalError, this.stackTrace});

  @override
  String toString() => message;
}

/// Exception thrown when a requested entity is not found in the database.
///
/// This is a generic exception for any entity type. Use specific subclasses
/// like [FolderNotFoundException] or [DeckNotFoundException] when possible.
class EntityNotFoundException extends AppException {
  /// The type of entity that was not found (e.g., "Folder", "Deck")
  final String entityType;

  /// The ID of the entity that was not found
  final dynamic entityId;

  EntityNotFoundException(this.entityType, this.entityId, {String? code})
    : super(
        '$entityType with id $entityId not found',
        code: code ?? 'ENTITY_NOT_FOUND',
      );
}

/// Exception thrown when a folder is not found in the database.
class FolderNotFoundException extends EntityNotFoundException {
  FolderNotFoundException(int folderId)
    : super('Folder', folderId, code: 'FOLDER_NOT_FOUND');
}

/// Exception thrown when a deck is not found in the database.
class DeckNotFoundException extends EntityNotFoundException {
  DeckNotFoundException(int deckId)
    : super('Deck', deckId, code: 'DECK_NOT_FOUND');
}

/// Exception thrown when input validation fails.
///
/// Contains a map of field names to error messages, allowing for
/// detailed feedback on multiple validation failures.
class ValidationException extends AppException {
  /// Map of field names to their validation error messages
  final Map<String, String> fieldErrors;

  ValidationException(String message, this.fieldErrors, {String? code})
    : super(message, code: code ?? 'VALIDATION_ERROR');

  /// Get the error message for a specific field
  String? getFieldError(String fieldName) => fieldErrors[fieldName];

  /// Get all error messages as a single string
  String get allErrors => fieldErrors.values.join('\n');
}

/// Exception thrown when a database operation fails.
///
/// This wraps underlying database errors and provides context about
/// what operation was being performed.
class DatabaseException extends AppException {
  DatabaseException(
    String message, {
    String? code,
    dynamic originalError,
    StackTrace? stackTrace,
  }) : super(
         message,
         code: code ?? 'DATABASE_ERROR',
         originalError: originalError,
         stackTrace: stackTrace,
       );
}
