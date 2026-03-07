/// Validation framework for input validation across the application.
///
/// This module provides a consistent validation approach with typed results
/// and reusable validators for domain entities.

/// Result of a validation operation.
///
/// Contains validation status and any error messages for specific fields.
class ValidationResult {
  /// Whether the validation passed.
  final bool isValid;

  /// Map of field names to error messages.
  final Map<String, String> errors;

  /// Creates a successful validation result.
  ValidationResult.success() : isValid = true, errors = {};

  /// Creates a failed validation result with error messages.
  ValidationResult.failure(this.errors) : isValid = false;

  /// Gets the error message for a specific field.
  ///
  /// Returns null if no error exists for the field.
  String? getError(String field) => errors[field];
}

/// Base interface for validators.
///
/// Validators implement this interface to provide consistent validation
/// behavior across different entity types.
abstract class Validator<T> {
  /// Validates the given value.
  ///
  /// Returns a [ValidationResult] indicating success or failure with errors.
  ValidationResult validate(T value);
}

/// Validator for folder names.
///
/// Validates that folder names are not empty and within length constraints.
class FolderValidator implements Validator<String> {
  /// Maximum allowed length for folder names.
  static const int maxNameLength = 100;

  @override
  ValidationResult validate(String name) {
    final errors = <String, String>{};

    if (name.trim().isEmpty) {
      errors['name'] = 'Folder name cannot be empty';
    } else if (name.length > maxNameLength) {
      errors['name'] = 'Folder name cannot exceed $maxNameLength characters';
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }
}

/// Validator for deck data.
///
/// Validates deck titles and ensures decks contain at least one card.
class DeckValidator {
  /// Maximum allowed length for deck titles.
  static const int maxTitleLength = 200;

  /// Validates a deck's title and cards list.
  ///
  /// [title] The deck title to validate.
  /// [cards] The list of cards to validate.
  ///
  /// Returns a [ValidationResult] indicating success or failure with errors.
  ValidationResult validate(String title, List<dynamic> cards) {
    final errors = <String, String>{};

    if (title.trim().isEmpty) {
      errors['title'] = 'Deck title cannot be empty';
    } else if (title.length > maxTitleLength) {
      errors['title'] = 'Deck title cannot exceed $maxTitleLength characters';
    }

    if (cards.isEmpty) {
      errors['cards'] = 'Deck must contain at least one card';
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }
}

/// Validator for flashcard content.
///
/// Validates that both front and back content are not empty and within
/// length constraints.
class FlashCardValidator {
  /// Maximum allowed length for card content.
  static const int maxContentLength = 1000;

  /// Validates flashcard front and back content.
  ///
  /// [front] The front content to validate.
  /// [back] The back content to validate.
  ///
  /// Returns a [ValidationResult] indicating success or failure with errors.
  ValidationResult validate(String front, String back) {
    final errors = <String, String>{};

    if (front.trim().isEmpty) {
      errors['front'] = 'Card front cannot be empty';
    } else if (front.length > maxContentLength) {
      errors['front'] = 'Card front cannot exceed $maxContentLength characters';
    }

    if (back.trim().isEmpty) {
      errors['back'] = 'Card back cannot be empty';
    } else if (back.length > maxContentLength) {
      errors['back'] = 'Card back cannot exceed $maxContentLength characters';
    }

    return errors.isEmpty
        ? ValidationResult.success()
        : ValidationResult.failure(errors);
  }
}
