import 'package:flutter/foundation.dart';
import 'package:bookexample/core/logging/app_logger.dart';
import 'package:bookexample/core/exceptions/app_exceptions.dart';

enum ViewState { idle, loading, success, error }

class ErrorState {
  final String message;
  final String? code;
  final AppException? exception;

  ErrorState(this.message, {this.code, this.exception});

  String get userFriendlyMessage {
    if (exception is ValidationException) {
      return message;
    } else if (exception is EntityNotFoundException) {
      return 'The requested item was not found';
    } else if (exception is DatabaseException) {
      return 'A database error occurred. Please try again';
    }
    return 'An unexpected error occurred';
  }
}

abstract class BaseViewModel extends ChangeNotifier {
  ViewState _state = ViewState.idle;
  ErrorState? _error;

  ViewState get state => _state;
  ErrorState? get error => _error;
  bool get isLoading => _state == ViewState.loading;
  bool get hasError => _state == ViewState.error;

  @protected
  void setState(ViewState newState) {
    _state = newState;
    notifyListeners();
  }

  @protected
  void setError(String message, {String? code, AppException? exception}) {
    _error = ErrorState(message, code: code, exception: exception);
    _state = ViewState.error;
    AppLogger.error(message, exception, exception?.stackTrace);
    notifyListeners();
  }

  @protected
  void clearError() {
    _error = null;
    if (_state == ViewState.error) {
      _state = ViewState.idle;
      notifyListeners();
    }
  }

  @protected
  Future<T> executeAsync<T>(
    Future<T> Function() operation, {
    String? operationName,
  }) async {
    try {
      setState(ViewState.loading);
      clearError();

      if (operationName != null) {
        AppLogger.info('Starting operation: $operationName');
      }

      final result = await operation();

      setState(ViewState.success);

      if (operationName != null) {
        AppLogger.info('Completed operation: $operationName');
      }

      return result;
    } on AppException catch (e) {
      setError(e.message, code: e.code, exception: e);
      rethrow;
    } catch (e, stackTrace) {
      final message = 'Unexpected error: $e';
      setError(message);
      AppLogger.error(message, e, stackTrace);
      rethrow;
    }
  }
}
