import 'package:bookexample/core/exceptions/app_exceptions.dart';
import 'package:bookexample/core/validation/validators.dart';
import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/pages/session/models/study_session_draft.dart';
import 'package:isar_community/isar.dart';

class IsarLibraryRepositoryImpl implements LibraryRepository {
  final Isar isar;
  final FolderValidator _folderValidator = FolderValidator();
  final DeckValidator _deckValidator = DeckValidator();

  IsarLibraryRepositoryImpl(this.isar);

  @override
  Future<List<FolderEntity>> getAllFolders() async {
    return await isar.folderEntitys.where().findAll();
  }

  @override
  Future<List<DeckEntity>> getAllDecksById(int folderId) async {
    return await isar.deckEntitys.where().folderIdEqualTo(folderId).findAll();
  }

  @override
  Future<FolderEntity> getFolderById(int id) async {
    try {
      final folder = await isar.folderEntitys.get(id);
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

      await isar.writeTxn(() async {
        await isar.folderEntitys.put(folder);
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
      await isar.writeTxn(() async {
        final folder = await isar.folderEntitys.get(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }
        folder.name = newName.trim();
        await isar.folderEntitys.put(folder);
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
      await isar.writeTxn(() async {
        // Verify folder exists
        final folder = await isar.folderEntitys.get(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }

        // Batch delete: Get all deck IDs first
        final deckIds = await isar.deckEntitys
            .filter()
            .folderIdEqualTo(folderId)
            .idProperty()
            .findAll();

        // Batch delete: Get all card IDs for these decks
        final cardIds = await isar.flashCardEntitys
            .filter()
            .anyOf(deckIds, (q, deckId) => q.deckIdEqualTo(deckId))
            .idProperty()
            .findAll();

        // Batch delete all cards
        await isar.flashCardEntitys.deleteAll(cardIds);

        // Batch delete all decks
        await isar.deckEntitys.deleteAll(deckIds);

        // Delete folder
        await isar.folderEntitys.delete(folderId);
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
    return isar.folderEntitys.where().watch(fireImmediately: true);
  }

  @override
  Stream<List<DeckEntity>> watchAllDecks() {
    return isar.deckEntitys.where().watch(fireImmediately: true);
  }

  @override
  Stream<List<DeckEntity>> watchDecksByFolder(int folderId) {
    return isar.deckEntitys
        .filter()
        .folderIdEqualTo(folderId)
        .watch(fireImmediately: true);
  }

  @override
  Future<List<DeckEntity>> getDecksByFolder(int folderId) async {
    return await isar.deckEntitys.filter().folderIdEqualTo(folderId).findAll();
  }

  @override
  Future<DeckEntity> getDeckById(int deckId) async {
    try {
      final deck = await isar.deckEntitys.get(deckId);
      if (deck == null) {
        throw DeckNotFoundException(deckId);
      }
      // Загружаем карточки через IsarLink
      await deck.cards.load();
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
      await isar.writeTxn(() async {
        // Verify parent folder exists
        final folder = await isar.folderEntitys.get(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }

        final deck = DeckEntity()
          ..title = title.trim()
          ..createdAt = DateTime.now()
          ..folderId = folderId
          ..folder.value = folder;

        await isar.deckEntitys.put(deck);

        // Batch create cards using putAll
        final cardEntities = flashCards.map((card) {
          return FlashCardEntity()
            ..front = card.front.trim()
            ..back = card.back.trim()
            ..createdAt = DateTime.now()
            ..deckId = deck.id
            ..deck.value = deck;
        }).toList();

        await isar.flashCardEntitys.putAll(cardEntities);
        deck.cards.addAll(cardEntities);
        await deck.cards.save();
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
      await isar.writeTxn(() async {
        // Verify deck exists
        final deck = await isar.deckEntitys.get(deckId);
        if (deck == null) {
          throw DeckNotFoundException(deckId);
        }

        // Batch delete: Get all card IDs for this deck
        final cardIds = await isar.flashCardEntitys
            .filter()
            .deckIdEqualTo(deckId)
            .idProperty()
            .findAll();

        // Batch delete all cards
        await isar.flashCardEntitys.deleteAll(cardIds);

        // Delete the deck
        await isar.deckEntitys.delete(deckId);
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
      await isar.writeTxn(() async {
        final deck = await isar.deckEntitys.get(deckId);
        if (deck == null) {
          throw DeckNotFoundException(deckId);
        }

        // Update deck title
        deck.title = title.trim();

        // Batch delete old cards
        final oldCardIds = await isar.flashCardEntitys
            .filter()
            .deckIdEqualTo(deckId)
            .idProperty()
            .findAll();

        await isar.flashCardEntitys.deleteAll(oldCardIds);

        // Batch create new cards
        final cardEntities = newCards.map((card) {
          return FlashCardEntity()
            ..front = card.front.trim()
            ..back = card.back.trim()
            ..createdAt = DateTime.now()
            ..deckId = deckId
            ..deck.value = deck;
        }).toList();

        await isar.flashCardEntitys.putAll(cardEntities);
        deck.cards.clear();
        deck.cards.addAll(cardEntities);

        await isar.deckEntitys.put(deck);
        await deck.cards.save();
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
    return await isar.flashCardEntitys.filter().deckIdEqualTo(deckId).findAll();
  }

  @override
  Future<void> setCardsLearned(List<AnswerDraft> answeredCards) async {
    await isar.writeTxn(() async {
      for (var card in answeredCards) {
        final cardEntityFromDB = await isar.flashCardEntitys.get(card.cardId);
        if (cardEntityFromDB != null) {
          cardEntityFromDB.isLearned = card.isCorrect;
          await isar.flashCardEntitys.put(cardEntityFromDB);
        }
      }
    });
  }
}
