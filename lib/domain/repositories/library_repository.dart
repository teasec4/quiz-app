import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/models/deck.dart';

abstract class LibraryRepository {
  // Folders
  Future<List<FolderEntity>> getAllFolders();
  Future<FolderEntity> getFolderById(int id);
  Future<void> addFolder(String name);
  Future<void> deleteFolder(int folderId);
  Future<void> renameFolder(int folderId, String newName);

  // helpers method
  Future<int> deckCount(int folderId);
  // Stream
  Stream<List<FolderEntity>> watchFolders();

  // Decks
  // Stream All Deck for UI updates
  Stream<List<DeckEntity>> watchDecksByFolder(int folderId);
  Future<List<DeckEntity>> getDecksByFolder(int folderId);
  Future<void> deleteDeck(String deckId);
  Future<void> addDeckWithCards(
    String folderId,
    String title,
    List<FlashCardEntity> cards,
  );
  Future<void> updateDeckWithCards(
    String deckId,
    String title,
    List<FlashCardEntity> newCards,
  );

  // Cards
  // Stream all Card for UI updates
  Future<List<FlashCardEntity>> getCardsByDeck(String deckId);
  Future<void> setCardLearned(String cardId, bool isLearned);
}
