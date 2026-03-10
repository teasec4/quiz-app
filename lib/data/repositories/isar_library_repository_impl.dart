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
    return await executeDbOperation(() async {
      return await _isarDataSource.filterByProperty<DeckEntity, int>(
        'folderId',
        folderId,
      );
    }, 'getAllDecksById');
  }

  @override
  Future<FolderEntity> getFolderById(int id) async {
    return await executeDbOperation(() async {
      final folder = await dataSource.get<FolderEntity>(id);
      if (folder == null) {
        throw FolderNotFoundException(id);
      }
      return folder;
    }, 'getFolderById');
  }

  @override
  Future<void> addFolder(String name) async {
    // Validate input
    final validation = _folderValidator.validate(name);
    if (!validation.isValid) {
      throw ValidationException('Invalid folder data', validation.errors);
    }

    return await executeDbOperation(() async {
      final folder = FolderEntity()
        ..name = name.trim()
        ..createdAt = DateTime.now();

      await dataSource.executeTransaction(() async {
        await dataSource.insert<FolderEntity>(folder);
      });
    }, 'addFolder');
  }

  @override
  Future<void> renameFolder(int folderId, String newName) async {
    // Validate input
    final validation = _folderValidator.validate(newName);
    if (!validation.isValid) {
      throw ValidationException('Invalid folder name', validation.errors);
    }

    return await executeDbOperation(() async {
      await dataSource.executeTransaction(() async {
        final folder = await dataSource.get<FolderEntity>(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }
        folder.name = newName.trim();
        await dataSource.update<FolderEntity>(folder);
      });
    }, 'renameFolder');
  }

  @override
  Future<void> deleteFolder(int folderId) async {
    return await executeDbOperation(() async {
      await dataSource.executeTransaction(() async {
        // Verify folder exists
        final folder = await dataSource.get<FolderEntity>(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }

        // Get all decks in this folder in one query
        final decks = await _isarDataSource.filterByProperty<DeckEntity, int>(
          'folderId',
          folderId,
        );

        if (decks.isNotEmpty) {
          // Get all deck IDs
          final deckIds = decks.map((deck) => deck.id).toList();

          // Get all cards for all decks using filterByPropertyIn
          final cards = await _isarDataSource
              .filterByPropertyIn<FlashCardEntity, int>('deckId', deckIds);

          // Batch delete all cards
          if (cards.isNotEmpty) {
            final cardIds = cards.map((card) => card.id).toList();
            await dataSource.deleteAll<FlashCardEntity>(cardIds);
          }

          // Batch delete all decks
          await dataSource.deleteAll<DeckEntity>(deckIds);
        }

        // Delete folder
        await dataSource.delete<FolderEntity>(folderId);
      });
    }, 'deleteFolder');
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
    return await executeDbOperation(() async {
      final deck = await dataSource.get<DeckEntity>(deckId);
      if (deck == null) {
        throw DeckNotFoundException(deckId);
      }
      // Load cards through DataSource
      await _isarDataSource.loadLinks(deck);
      return deck;
    }, 'getDeckById');
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

    return await executeDbOperation(() async {
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
    }, 'createDeckWithCard');
  }

  @override
  Future<void> deleteDeck(int deckId) async {
    return await executeDbOperation(() async {
      await dataSource.executeTransaction(() async {
        // Verify deck exists
        final deck = await dataSource.get<DeckEntity>(deckId);
        if (deck == null) {
          throw DeckNotFoundException(deckId);
        }

        // Get all card IDs for this deck using filterByPropertyIn for consistency
        final cards = await _isarDataSource
            .filterByPropertyIn<FlashCardEntity, int>('deckId', [deckId]);
        final cardIds = cards.map((card) => card.id).toList();

        // Batch delete all cards
        if (cardIds.isNotEmpty) {
          await dataSource.deleteAll<FlashCardEntity>(cardIds);
        }

        // Delete the deck
        await dataSource.delete<DeckEntity>(deckId);
      });
    }, 'deleteDeck');
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

    return await executeDbOperation(() async {
      await dataSource.executeTransaction(() async {
        final deck = await dataSource.get<DeckEntity>(deckId);
        if (deck == null) {
          throw DeckNotFoundException(deckId);
        }

        // Update deck title
        deck.title = title.trim();
        await dataSource.update<DeckEntity>(deck);

        // Get old card IDs using filterByPropertyIn for consistency
        final oldCards = await _isarDataSource
            .filterByPropertyIn<FlashCardEntity, int>('deckId', [deckId]);
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
    }, 'updateDeckWithCards');
  }

  @override
  Future<List<FlashCardEntity>> getCardsByDeck(int deckId) async {
    return await executeDbOperation(() async {
      return await _isarDataSource.filterByProperty<FlashCardEntity, int>(
        'deckId',
        deckId,
      );
    }, 'getCardsByDeck');
  }

  @override
  Future<void> setCardsLearned(List<AnswerDraft> answeredCards) async {
    return await executeDbOperation(() async {
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
    }, 'setCardsLearned');
  }
}
