import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:isar_community/isar.dart';

class IsarLibraryRepositoryImpl implements LibraryRepository {
  final Isar isar;

  IsarLibraryRepositoryImpl(this.isar);

  @override
  Future<List<FolderEntity>> getAllFolders() async {
    return await isar.folderEntitys.where().findAll();
  }

  @override
  Future<FolderEntity> getFolderById(int id) async {
    final folder = await isar.folderEntitys.get(id);
    if (folder == null) {
      throw Exception('Folder not found');
    }
    return folder;
  }

  @override
  Future<void> addFolder(String name) async {
    final folder = FolderEntity()
      ..name = name
      ..createdAt = DateTime.now();

    await isar.writeTxn(() async {
      await isar.folderEntitys.put(folder);
    });
  }

  @override
  Future<void> renameFolder(int folderId, String newName) async {
    // need to test it
    await isar.writeTxn(() async {
      final folder = await isar.folderEntitys.get(folderId);
      if (folder == null) return;
      folder.name = newName;
      await isar.folderEntitys.put(folder);
    });
  }

  @override
  Future<void> deleteFolder(int folderId) async {
    await isar.writeTxn(() async {
      // Удалить все деки в папке
      final decks = await isar.deckEntitys
          .filter()
          .folderIdEqualTo(folderId)
          .findAll();

      for (var deck in decks) {
        // Удалить все карточки деки
        final cards = await isar.flashCardEntitys
            .filter()
            .deckIdEqualTo(deck.id)
            .findAll();

        for (var card in cards) {
          await isar.flashCardEntitys.delete(card.id);
        }

        // Удалить саму деку
        await isar.deckEntitys.delete(deck.id);
      }

      // Удалить саму папку
      await isar.folderEntitys.delete(folderId);
    });
  }

  @override
  Stream<List<FolderEntity>> watchFolders() {
    return isar.folderEntitys.where().watch(fireImmediately: true);
  }

  // StreamBuilder<List<FolderEntity>>(
  //   stream: repository.watchFolders(),
  //   builder: (context, snapshot) {
  //     final folders = snapshot.data ?? [];
  //     return ListView.builder(
  //       itemCount: folders.length,
  //       itemBuilder: (_, i) => Text(folders[i].name),
  //     );
  //   },
  // );

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
    final deck = await isar.deckEntitys.get(deckId);
    if (deck == null) {
      throw Exception('Deck not found');
    }
    // Загружаем все карточки для деки
    await deck.cards.load();
    return deck;
  }

  @override
  Future<void> createDeckWithCard(
    int folderId,
    String title,
    List<FlashCardEntity> flashCards,
  ) async {
    final folder = await isar.folderEntitys.get(folderId);

    final deck = DeckEntity()
      ..title = title
      ..createdAt = DateTime.now()
      ..folderId = folderId
      ..folder.value = folder;

    await isar.writeTxn(() async {
      await isar.deckEntitys.put(deck);

      for (var card in flashCards) {
        final cardEntity = FlashCardEntity()
          ..front = card.front
          ..back = card.back
          ..createdAt = DateTime.now()
          ..deckId = deck.id
          ..deck.value = deck;

        await isar.flashCardEntitys.put(cardEntity);
        deck.cards.add(cardEntity);
      }

      await deck.cards.save();
      isar.deckEntitys.put(deck);
    });
  }

  @override
  Future<void> deleteDeck(int deckId) async {
    await isar.writeTxn(() async {
      // Удалить все карточки деки
      final cards = await isar.flashCardEntitys
          .filter()
          .deckIdEqualTo(deckId)
          .findAll();

      for (var card in cards) {
        await isar.flashCardEntitys.delete(card.id);
      }

      // Удалить саму деку
      await isar.deckEntitys.delete(deckId);
    });
  }

  @override
  Future<void> updateDeckWithCards(
    int deckId,
    String title,
    List<FlashCardEntity> newCards,
  ) async {
    await isar.writeTxn(() async {
      final deck = await isar.deckEntitys.get(deckId);
      if (deck == null) return;

      // Обновить название деки
      deck.title = title;

      // Удалить старые карточки
      final oldCards = await isar.flashCardEntitys
          .filter()
          .deckIdEqualTo(deckId)
          .findAll();

      for (var card in oldCards) {
        await isar.flashCardEntitys.delete(card.id);
      }

      // Добавить новые карточки
      for (var card in newCards) {
        final cardEntity = FlashCardEntity()
          ..front = card.front
          ..back = card.back
          ..createdAt = DateTime.now()
          ..deckId = deckId
          ..deck.value = deck;

        await isar.flashCardEntitys.put(cardEntity);
        deck.cards.add(cardEntity);
      }

      await isar.deckEntitys.put(deck);
      await deck.cards.save();
    });
  }

  @override
  Future<List<FlashCardEntity>> getCardsByDeck(int deckId) async {
    return await isar.flashCardEntitys.filter().deckIdEqualTo(deckId).findAll();
  }

  @override
  Future<void> setCardsLearned(List<int> cardIds, bool isLearned) async {
    await isar.writeTxn(() async {
      for (var cardId in cardIds) {
        final card = await isar.flashCardEntitys.get(cardId);
        if (card != null) {
          card.isLearned = isLearned;
          await isar.flashCardEntitys.put(card);
        }
      }
    });
  }
}
