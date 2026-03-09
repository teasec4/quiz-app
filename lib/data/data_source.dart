abstract class DataSource {
  // Basic CRUD operations
  Future<T?> get<T>(int id);
  Future<List<T>> getAll<T>();
  Future<int> insert<T>(T entity);
  Future<void> update<T>(T entity);
  Future<void> delete<T>(int id);
  Stream<List<T>> watchAll<T>();

  // Batch operations
  Future<void> insertAll<T>(List<T> entities);
  Future<void> deleteAll<T>(List<int> ids);

  // Transaction support
  Future<R> executeTransaction<R>(Future<R> Function() operation);

  // Query operations
  Future<List<T>> filter<T>(FilterQuery<T> query);
  Stream<List<T>> watchFilter<T>(FilterQuery<T> query);

  // Specific operations for Isar
  Future<void> loadLinks<T>(T entity);
  Future<void> saveLinks<T>(T entity);
}

/// Generic filter query interface that can be implemented for specific ORMs
abstract class FilterQuery<T> {
  const FilterQuery();

  /// Apply this filter to a query builder
  dynamic apply(dynamic queryBuilder);
}

/// Simple equality filter for demonstration
class EqualityFilter<T, V> extends FilterQuery<T> {
  final String property;
  final V value;

  const EqualityFilter(this.property, this.value);

  @override
  dynamic apply(dynamic queryBuilder) {
    // This would be implemented differently for each ORM
    // For Isar, we would use the generated filter methods
    return queryBuilder;
  }
}
