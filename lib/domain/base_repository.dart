import 'package:bookexample/core/exceptions/app_exceptions.dart';
import 'package:bookexample/core/logging/logger.dart';
import 'package:isar_community/isar.dart';

abstract class BaseRepository {
  final Isar isar;

  BaseRepository(this.isar);

  Future<T> executeDbOperation<T>(
    Future<T> Function() operation,
    String operationName,
  ) async {
    try {
      return await operation();
    } on AppException catch (_) {
      rethrow;
    } catch (error, stackTrace) {
      AppLogger.error('Failed to $operationName', error, stackTrace);
      throw DatabaseException(
        'Failed to $operationName',
        originalError: error,
        stackTrace: stackTrace,
      );
    }
  }
}
