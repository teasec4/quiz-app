import 'package:bookexample/core/exceptions/app_exceptions.dart';
import 'package:bookexample/core/validation/validators.dart';
import 'package:bookexample/data/data_source.dart';
import 'package:bookexample/data/isar_data_source.dart';
import 'package:bookexample/domain/base_repository.dart';
import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/pages/session/models/study_session_draft.dart';

class IsarLibraryRepositoryImpl extends BaseRepository
    implements LibraryRepository {
  final FolderValidator _folderValidator = FolderValidator();
  final DeckValidator _deckValidator = DeckValidator();

  IsarLibraryRepositoryImpl(DataSource dataSource) : super(dataSource);

  IsarDataSource get _isarDataSource => dataSource as IsarDataSource;

  @override
  Future<List<FolderEntity>> getAllFolders() async {
    return await executeDbOperation(() async {
      return await dataSource.getAll<FolderEntity>();
    }, 'getAllFolders');
  }

  @override
  Future<List<DeckEntity>> getAllDecksById(int folderId) async {
    return await _isarDataSource.filterByProperty<DeckEntity, int>(
      'folderId',
      folderId,
    );
  }

  @override
  Future<FolderEntity> getFolderById(int id) async {
    try {
      final folder = await dataSource.get<FolderEntity>(id);
      if (folder == null) {
        throw FolderNotFoundException(id);
      }
      return folder;
    } catch (e, stackTrace) {
      if (e is AppException) rethrow;
      throw DatabaseException(
        'Failed to get folder',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> addFolder(String name) async {
    // Validate input
    final validation = _folderValidator.validate(name);
    if (!validation.isValid) {
      throw ValidationException('Invalid folder data', validation.errors);
    }

    try {
      final folder = FolderEntity()
        ..name = name.trim()
        ..createdAt = DateTime.now();

      await dataSource.executeTransaction(() async {
        await dataSource.insert<FolderEntity>(folder);
      });
    } catch (e, stackTrace) {
      if (e is AppException) rethrow;
      throw DatabaseException(
        'Failed to create folder',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> renameFolder(int folderId, String newName) async {
    // Validate input
    final validation = _folderValidator.validate(newName);
    if (!validation.isValid) {
      throw ValidationException('Invalid folder name', validation.errors);
    }

    try {
      await dataSource.executeTransaction(() async {
        final folder = await dataSource.get<FolderEntity>(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }
        folder.name = newName.trim();
        await dataSource.update<FolderEntity>(folder);
      });
    } catch (e, stackTrace) {
      if (e is AppException) rethrow;
      throw DatabaseException(
        'Failed to rename folder',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> deleteFolder(int folderId) async {
    try {
      await dataSource.executeTransaction(() async {
        // Verify folder exists
        final folder = await dataSource.get<FolderEntity>(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }

        // Get all deck IDs for this folder
        final deckIds = await _isarDataSource
            .filterByProperty<DeckEntity, int>('folderId', folderId)
            .then((decks) => decks.map((deck) => deck.id).toList());

        if (deckIds.isNotEmpty) {
          // Get all card IDs for these decks
          final cardIds = <int>[];
          for (final deckId in deckIds) {
            final cards = await _isarDataSource
                .filterByProperty<FlashCardEntity, int>('deckId', deckId);
            cardIds.addAll(cards.map((card) => card.id));
          }

          // Batch delete all cards
          if (cardIds.isNotEmpty) {
            await dataSource.deleteAll<FlashCardEntity>(cardIds);
          }

          // Batch delete all decks
          await dataSource.deleteAll<DeckEntity>(deckIds);
        }

        // Delete folder
        await dataSource.delete<FolderEntity>(folderId);
      });
    } catch (e, stackTrace) {
      if (e is AppException) rethrow;
      throw DatabaseException(
        'Failed to delete folder',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Stream<List<FolderEntity>> watchFolders() {
    return dataSource.watchAll<FolderEntity>();
  }

  @override
  Stream<List<DeckEntity>> watchAllDecks() {
    return dataSource.watchAll<DeckEntity>();
  }

  @override
  Stream<List<DeckEntity>> watchDecksByFolder(int folderId) {
    return _isarDataSource.watchByProperty<DeckEntity, int>(
      'folderId',
      folderId,
    );
  }

  @override
  Future<List<DeckEntity>> getDecksByFolder(int folderId) async {
    return await _isarDataSource.filterByProperty<DeckEntity, int>(
      'folderId',
      folderId,
    );
  }

  @override
  Future<DeckEntity> getDeckById(int deckId) async {
    try {
      final deck = await dataSource.get<DeckEntity>(deckId);
      if (deck == null) {
        throw DeckNotFoundException(deckId);
      }
      // Load cards through DataSource
      await _isarDataSource.loadLinks(deck);
      return deck;
    } catch (e, stackTrace) {
      if (e is AppException) rethrow;
      throw DatabaseException(
        'Failed to get deck',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> createDeckWithCard(
    int folderId,
    String title,
    List<FlashCardEntity> flashCards,
  ) async {
    // Validate input
    final validation = _deckValidator.validate(title, flashCards);
    if (!validation.isValid) {
      throw ValidationException('Invalid deck data', validation.errors);
    }

    try {
      await dataSource.executeTransaction(() async {
        // Verify parent folder exists
        final folder = await dataSource.get<FolderEntity>(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }

        final deck = DeckEntity()
          ..title = title.trim()
          ..createdAt = DateTime.now()
          ..folderId = folderId
          ..folder.value = folder;

        final deckId = await dataSource.insert<DeckEntity>(deck);

        // Update deck with the actual ID
        deck.id = deckId;

        // Batch create cards
        final cardEntities = flashCards.map((card) {
          return FlashCardEntity()
            ..front = card.front.trim()
            ..back = card.back.trim()
            ..createdAt = DateTime.now()
            ..deckId = deckId
            ..deck.value = deck;
        }).toList();

        await dataSource.insertAll<FlashCardEntity>(cardEntities);
        deck.cards.addAll(cardEntities);
        await _isarDataSource.saveLinks(deck);
      });
    } catch (e, stackTrace) {
      if (e is AppException) rethrow;
      throw DatabaseException(
        'Failed to create deck',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> deleteDeck(int deckId) async {
    try {
      await dataSource.executeTransaction(() async {
        // Verify deck exists
        final deck = await dataSource.get<DeckEntity>(deckId);
        if (deck == null) {
          throw DeckNotFoundException(deckId);
        }

        // Get all card IDs for this deck
        final cards = await _isarDataSource
            .filterByProperty<FlashCardEntity, int>('deckId', deckId);
        final cardIds = cards.map((card) => card.id).toList();

        // Batch delete all cards
        if (cardIds.isNotEmpty) {
          await dataSource.deleteAll<FlashCardEntity>(cardIds);
        }

        // Delete the deck
        await dataSource.delete<DeckEntity>(deckId);
      });
    } catch (e, stackTrace) {
      if (e is AppException) rethrow;
      throw DatabaseException(
        'Failed to delete deck',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> updateDeckWithCards(
    int deckId,
    String title,
    List<FlashCardEntity> newCards,
  ) async {
    // Validate input
    final validation = _deckValidator.validate(title, newCards);
    if (!validation.isValid) {
      throw ValidationException('Invalid deck data', validation.errors);
    }

    try {
      await dataSource.executeTransaction(() async {
        final deck = await dataSource.get<DeckEntity>(deckId);
        if (deck == null) {
          throw DeckNotFoundException(deckId);
        }

        // Update deck title
        deck.title = title.trim();
        await dataSource.update<DeckEntity>(deck);

        // Get old card IDs
        final oldCards = await _isarDataSource
            .filterByProperty<FlashCardEntity, int>('deckId', deckId);
        final oldCardIds = oldCards.map((card) => card.id).toList();

        // Batch delete old cards
        if (oldCardIds.isNotEmpty) {
          await dataSource.deleteAll<FlashCardEntity>(oldCardIds);
        }

        // Batch create new cards
        final cardEntities = newCards.map((card) {
          return FlashCardEntity()
            ..front = card.front.trim()
            ..back = card.back.trim()
            ..createdAt = DateTime.now()
            ..deckId = deckId
            ..deck.value = deck;
        }).toList();

        await dataSource.insertAll<FlashCardEntity>(cardEntities);
        deck.cards.clear();
        deck.cards.addAll(cardEntities);
        await _isarDataSource.saveLinks(deck);
      });
    } catch (e, stackTrace) {
      if (e is AppException) rethrow;
      throw DatabaseException(
        'Failed to update deck',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<List<FlashCardEntity>> getCardsByDeck(int deckId) async {
    return await _isarDataSource.filterByProperty<FlashCardEntity, int>(
      'deckId',
      deckId,
    );
  }

  @override
  Future<void> setCardsLearned(List<AnswerDraft> answeredCards) async {
    await dataSource.executeTransaction(() async {
      for (var card in answeredCards) {
        final cardEntityFromDB = await dataSource.get<FlashCardEntity>(
          card.cardId,
        );
        if (cardEntityFromDB != null) {
          cardEntityFromDB.isLearned = card.isCorrect;
          await dataSource.update<FlashCardEntity>(cardEntityFromDB);
        }
      }
    });
  }
}
