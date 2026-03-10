import 'package:bookexample/core/exceptions/app_exceptions.dart';
import 'package:bookexample/core/logging/app_logger.dart';
import 'package:bookexample/data/data_source.dart';

abstract class BaseRepository {
  final DataSource dataSource;

  BaseRepository(this.dataSource);

  Future<T> executeDbOperation<T>(
    Future<T> Function() operation,
    String operationName,
  ) async {
    try {
      return await operation();
    } on AppException catch (e) {
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
