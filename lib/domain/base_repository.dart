import 'package:bookexample/core/exceptions/app_exceptions.dart';
import 'package:bookexample/core/logging/app_logger.dart';
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
    } on AppException catch (e) {
      rethrow;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to $operationName', e, stackTrace);
      throw DatabaseException(
        'Failed to $operationName',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }
}
