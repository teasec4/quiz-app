import 'package:bookexample/data/data_source.dart' as data_source;
import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/isar_model/session/study_answer_entity.dart';
import 'package:bookexample/domain/isar_model/session/study_session_entity.dart';
import 'package:bookexample/domain/isar_model/user_stats/user_stats_entity.dart';
import 'package:isar_community/isar.dart';

class IsarDataSource implements data_source.DataSource {
  final Isar isar;

  IsarDataSource(this.isar);

  // Helper method to get the collection for a type
  IsarCollection<T> _getCollection<T>() {
    if (T == FolderEntity) {
      return isar.folderEntitys as IsarCollection<T>;
    } else if (T == DeckEntity) {
      return isar.deckEntitys as IsarCollection<T>;
    } else if (T == FlashCardEntity) {
      return isar.flashCardEntitys as IsarCollection<T>;
    } else if (T == StudySessionEntity) {
      return isar.studySessionEntitys as IsarCollection<T>;
    } else if (T == StudyAnswerEntity) {
      return isar.studyAnswerEntitys as IsarCollection<T>;
    } else if (T == UserStatsEntity) {
      return isar.userStatsEntitys as IsarCollection<T>;
    }
    throw ArgumentError('Unsupported type: $T');
  }

  @override
  Future<T?> get<T>(int id) async {
    final collection = _getCollection<T>();
    return await collection.get(id);
  }

  @override
  Future<List<T>> getAll<T>() async {
    final collection = _getCollection<T>();
    return await collection.where().findAll();
  }

  @override
  Future<int> insert<T>(T entity) async {
    final collection = _getCollection<T>();
    return await collection.put(entity);
  }

  @override
  Future<void> update<T>(T entity) async {
    final collection = _getCollection<T>();
    await collection.put(entity);
  }

  @override
  Future<void> delete<T>(int id) async {
    final collection = _getCollection<T>();
    final deleted = await collection.delete(id);
    if (!deleted) {
      throw Exception('Entity with id $id not found');
    }
  }

  @override
  Stream<List<T>> watchAll<T>() {
    final collection = _getCollection<T>();
    return collection.where().watch(fireImmediately: true);
  }

  @override
  Future<void> insertAll<T>(List<T> entities) async {
    final collection = _getCollection<T>();
    await collection.putAll(entities);
  }

  @override
  Future<void> deleteAll<T>(List<int> ids) async {
    final collection = _getCollection<T>();
    await collection.deleteAll(ids);
  }

  @override
  Future<R> executeTransaction<R>(Future<R> Function() operation) async {
    return await isar.writeTxn(operation);
  }

  @override
  Future<List<T>> filter<T>(data_source.FilterQuery<T> query) async {
    final collection = _getCollection<T>();
    // For Isar, we need to handle specific filter types
    // This is a simplified implementation
    final queryBuilder = collection.where();
    final appliedQuery = query.apply(queryBuilder);
    return await appliedQuery.findAll();
  }

  @override
  Stream<List<T>> watchFilter<T>(data_source.FilterQuery<T> query) {
    final collection = _getCollection<T>();
    final queryBuilder = collection.where();
    final appliedQuery = query.apply(queryBuilder);
    return appliedQuery.watch(fireImmediately: true);
  }

  @override
  Future<void> loadLinks<T>(T entity) async {
    // This is a simplified implementation
    // In practice, you'd need to handle each entity type separately
    if (entity is DeckEntity) {
      await entity.cards.load();
      await entity.folder.load();
    } else if (entity is FlashCardEntity) {
      await entity.deck.load();
    } else if (entity is FolderEntity) {
      await entity.decks.load();
    } else if (entity is StudySessionEntity) {
      await entity.answers.load();
    } else if (entity is StudyAnswerEntity) {
      await entity.session.load();
    }
  }

  @override
  Future<void> saveLinks<T>(T entity) async {
    // This is a simplified implementation
    // In practice, you'd need to handle each entity type separately
    if (entity is DeckEntity) {
      await entity.cards.save();
      await entity.folder.save();
    } else if (entity is FlashCardEntity) {
      await entity.deck.save();
    } else if (entity is FolderEntity) {
      await entity.decks.save();
    } else if (entity is StudySessionEntity) {
      await entity.answers.save();
    } else if (entity is StudyAnswerEntity) {
      await entity.session.save();
    }
  }

  // Additional Isar-specific helper methods

  Future<List<T>> where<T>() async {
    final collection = _getCollection<T>();
    return await collection.where().findAll();
  }

  Future<List<T>> filterByProperty<T, V>(String property, V value) async {
    final collection = _getCollection<T>();
    // This is a simplified implementation
    // In practice, you'd need to handle each property type separately
    if (T == DeckEntity && property == 'folderId' && value is int) {
      return await (collection as IsarCollection<DeckEntity>)
              .filter()
              .folderIdEqualTo(value)
              .findAll()
          as List<T>;
    } else if (T == FlashCardEntity && property == 'deckId' && value is int) {
      return await (collection as IsarCollection<FlashCardEntity>)
              .filter()
              .deckIdEqualTo(value)
              .findAll()
          as List<T>;
    }
    throw ArgumentError('Unsupported filter: $property for type $T');
  }

  Future<List<T>> filterByPropertyIn<T, V>(
    String property,
    List<V> values,
  ) async {
    final collection = _getCollection<T>();

    if (values.isEmpty) {
      return <T>[];
    }

    // For Isar, we need to build OR conditions manually
    if (T == DeckEntity && property == 'folderId') {
      final intValues = values.cast<int>();
      final query = (collection as IsarCollection<DeckEntity>).where();

      if (intValues.length == 1) {
        return await query.filter().folderIdEqualTo(intValues.first).findAll()
            as List<T>;
      }

      // Build OR condition by combining multiple queries
      final results = <DeckEntity>[];
      for (final value in intValues) {
        final deckResults = await query
            .filter()
            .folderIdEqualTo(value)
            .findAll();
        results.addAll(deckResults);
      }
      return results as List<T>;
    } else if (T == FlashCardEntity && property == 'deckId') {
      final intValues = values.cast<int>();
      final query = (collection as IsarCollection<FlashCardEntity>).where();

      if (intValues.length == 1) {
        return await query.filter().deckIdEqualTo(intValues.first).findAll()
            as List<T>;
      }

      // Build OR condition by combining multiple queries
      final results = <FlashCardEntity>[];
      for (final value in intValues) {
        final cardResults = await query.filter().deckIdEqualTo(value).findAll();
        results.addAll(cardResults);
      }
      return results as List<T>;
    }
    throw ArgumentError(
      'Unsupported filter: $property for type $T with multiple values',
    );
  }

  Stream<List<T>> watchByProperty<T, V>(String property, V value) {
    final collection = _getCollection<T>();
    // This is a simplified implementation
    if (T == DeckEntity && property == 'folderId' && value is int) {
      return (collection as IsarCollection<DeckEntity>)
              .filter()
              .folderIdEqualTo(value)
              .watch(fireImmediately: true)
          as Stream<List<T>>;
    } else if (T == FlashCardEntity && property == 'deckId' && value is int) {
      return (collection as IsarCollection<FlashCardEntity>)
              .filter()
              .deckIdEqualTo(value)
              .watch(fireImmediately: true)
          as Stream<List<T>>;
    }
    throw ArgumentError('Unsupported filter: $property for type $T');
  }
}
