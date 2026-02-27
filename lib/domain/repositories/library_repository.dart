import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';

abstract class LibraryRepository {
  // Folders
  Future<List<FolderEntity>> getAllFolders();
  Future<FolderEntity> getFolderById(int id);
  Future<void> addFolder(String name);
  Future<void> deleteFolder(int folderId);
  Future<void> renameFolder(int folderId, String newName);
  // Stream
  Stream<List<FolderEntity>> watchFolders();

  // Decks
  // Stream All Deck for UI updates
  Stream<List<DeckEntity>> watchDecksByFolder(int folderId);
  Stream<List<DeckEntity>> watchAllDecks();
  Future<List<DeckEntity>> getDecksByFolder(int folderId);
  Future<DeckEntity> getDeckById(int deckId);
  Future<void> createDeckWithCard(
    int folderId,
    String title,
    List<FlashCardEntity> flashCards,
  );
  Future<void> updateDeckWithCards(
    int deckId,
    String title,
    List<FlashCardEntity> newCards,
  );
  Future<void> deleteDeck(int deckId);

  // Cards
  // Stream all Card for UI updates
  Future<List<FlashCardEntity>> getCardsByDeck(int deckId);
  Future<void> setCardsLearned(List<int> cardIds, bool isLearned);
}
