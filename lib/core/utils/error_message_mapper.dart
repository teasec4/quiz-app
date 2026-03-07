import 'package:bookexample/core/exceptions/app_exceptions.dart';

class ErrorMessageMapper {
  static String getUserFriendlyMessage(AppException exception) {
    if (exception is ValidationException) {
      return exception.fieldErrors.values.join('\n');
    } else if (exception is FolderNotFoundException) {
      return 'The folder you\'re looking for doesn\'t exist';
    } else if (exception is DeckNotFoundException) {
      return 'The deck you\'re looking for doesn\'t exist';
    } else if (exception is DatabaseException) {
      return 'A database error occurred. Please try again';
    }
    return 'An unexpected error occurred';
  }
}
