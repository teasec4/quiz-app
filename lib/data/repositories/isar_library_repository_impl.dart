import 'package:bookexample/core/exceptions/app_exceptions.dart';
import 'package:bookexample/core/validation/validators.dart';
import 'package:bookexample/data/isar_db_extension.dart';
import 'package:bookexample/domain/base_repository.dart';
import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/pages/session/models/study_session_draft.dart';
import 'package:isar_community/isar.dart';

class IsarLibraryRepositoryImpl extends BaseRepository
    implements LibraryRepository {
  final FolderValidator _folderValidator = FolderValidator();
  final DeckValidator _deckValidator = DeckValidator();

  IsarLibraryRepositoryImpl(super.isar);

  @override
  Future<List<FolderEntity>> getAllFolders() async {
    return await executeDbOperation(() async {
      return await isar.folderEntitys.where().findAll();
    }, 'getAllFolders');
  }

  @override
  Future<List<DeckEntity>> getAllDecksById(int folderId) async {
    return await executeDbOperation(() async {
      return await isar.getDecksByFolder(folderId);
    }, 'getAllDecksById');
  }

  @override
  Future<FolderEntity> getFolderById(int id) async {
    return await executeDbOperation(() async {
      final folder = await isar.folderEntitys.get(id);
      if (folder == null) {
        throw FolderNotFoundException(id);
      }
      return folder;
    }, 'getFolderById');
  }

  @override
  Future<void> addFolder(String name) async {
    final validation = _folderValidator.validate(name);
    if (!validation.isValid) {
      throw ValidationException('Invalid folder data', validation.errors);
    }

    return await executeDbOperation(() async {
      final folder = FolderEntity()
        ..name = name.trim()
        ..createdAt = DateTime.now();

      await isar.writeTxn(() async {
        await isar.folderEntitys.put(folder);
      });
    }, 'addFolder');
  }

  @override
  Future<void> renameFolder(int folderId, String newName) async {
    final validation = _folderValidator.validate(newName);
    if (!validation.isValid) {
      throw ValidationException('Invalid folder name', validation.errors);
    }

    return await executeDbOperation(() async {
      await isar.writeTxn(() async {
        final folder = await isar.folderEntitys.get(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }
        folder.name = newName.trim();
        await isar.folderEntitys.put(folder);
      });
    }, 'renameFolder');
  }

  @override
  Future<void> deleteFolder(int folderId) async {
    return await executeDbOperation(() async {
      await isar.writeTxn(() async {
        final folder = await isar.folderEntitys.get(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }

        final decks = await isar.getDecksByFolder(folderId);

        if (decks.isNotEmpty) {
          final deckIds = decks.map((deck) => deck.id).toList();

          final cards = await isar.getCardsByDecks(deckIds);

          if (cards.isNotEmpty) {
            final cardIds = cards.map((card) => card.id).toList();
            await isar.flashCardEntitys.deleteAll(cardIds);
          }

          await isar.deckEntitys.deleteAll(deckIds);
        }

        await isar.folderEntitys.delete(folderId);
      });
    }, 'deleteFolder');
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
    return isar.watchDecksByFolder(folderId);
  }

  @override
  Stream<List<FlashCardEntity>> watchAllFlashcards() {
    return isar.flashCardEntitys.where().watch(fireImmediately: true);
  }

  @override
  Future<List<DeckEntity>> getDecksByFolder(int folderId) async {
    return await isar.getDecksByFolder(folderId);
  }

  @override
  Future<DeckEntity> getDeckById(int deckId) async {
    return await executeDbOperation(() async {
      final deck = await isar.deckEntitys.get(deckId);
      if (deck == null) {
        throw DeckNotFoundException(deckId);
      }
      await isar.loadDeckLinks(deck);
      return deck;
    }, 'getDeckById');
  }

  @override
  Future<void> createDeckWithCard(
    int folderId,
    String title,
    List<FlashCardEntity> flashCards,
  ) async {
    final validation = _deckValidator.validate(title, flashCards);
    if (!validation.isValid) {
      throw ValidationException('Invalid deck data', validation.errors);
    }

    return await executeDbOperation(() async {
      await isar.writeTxn(() async {
        final folder = await isar.folderEntitys.get(folderId);
        if (folder == null) {
          throw FolderNotFoundException(folderId);
        }

        final deck = DeckEntity()
          ..title = title.trim()
          ..createdAt = DateTime.now()
          ..folderId = folderId
          ..folder.value = folder;

        final deckId = await isar.deckEntitys.put(deck);

        deck.id = deckId;

        final cardEntities = flashCards.map((card) {
          return FlashCardEntity()
            ..front = card.front.trim()
            ..back = card.back.trim()
            ..createdAt = DateTime.now()
            ..deckId = deckId
            ..deck.value = deck;
        }).toList();

        await isar.flashCardEntitys.putAll(cardEntities);
        deck.cards.addAll(cardEntities);
        await isar.saveDeckLinks(deck);
      });
    }, 'createDeckWithCard');
  }

  @override
  Future<void> deleteDeck(int deckId) async {
    return await executeDbOperation(() async {
      await isar.writeTxn(() async {
        final deck = await isar.deckEntitys.get(deckId);
        if (deck == null) {
          throw DeckNotFoundException(deckId);
        }

        final cards = await isar.getCardsByDeck(deckId);
        final cardIds = cards.map((card) => card.id).toList();

        if (cardIds.isNotEmpty) {
          await isar.flashCardEntitys.deleteAll(cardIds);
        }

        await isar.deckEntitys.delete(deckId);
      });
    }, 'deleteDeck');
  }

  @override
  Future<void> updateDeckWithCards(
    int deckId,
    String title,
    List<FlashCardEntity> newCards,
  ) async {
    final validation = _deckValidator.validate(title, newCards);
    if (!validation.isValid) {
      throw ValidationException('Invalid deck data', validation.errors);
    }

    return await executeDbOperation(() async {
      await isar.writeTxn(() async {
        final deck = await isar.deckEntitys.get(deckId);
        if (deck == null) {
          throw DeckNotFoundException(deckId);
        }

        deck.title = title.trim();
        await isar.deckEntitys.put(deck);

        final oldCards = await isar.getCardsByDeck(deckId);
        final oldCardIds = oldCards.map((card) => card.id).toList();

        if (oldCardIds.isNotEmpty) {
          await isar.flashCardEntitys.deleteAll(oldCardIds);
        }

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
        await isar.saveDeckLinks(deck);
      });
    }, 'updateDeckWithCards');
  }

  @override
  Future<List<FlashCardEntity>> getCardsByDeck(int deckId) async {
    return await executeDbOperation(() async {
      return await isar.getCardsByDeck(deckId);
    }, 'getCardsByDeck');
  }

  @override
  Future<void> setCardsLearned(List<AnswerDraft> answeredCards) async {
    return await executeDbOperation(() async {
      await isar.writeTxn(() async {
        for (var card in answeredCards) {
          final cardEntityFromDB = await isar.flashCardEntitys.get(card.cardId);
          if (cardEntityFromDB != null) {
            cardEntityFromDB.isLearned = card.isCorrect;
            await isar.flashCardEntitys.put(cardEntityFromDB);
          }
        }
      });
    }, 'setCardsLearned');
  }
}
