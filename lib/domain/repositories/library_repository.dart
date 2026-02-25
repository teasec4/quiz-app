import 'package:bookexample/domain/models/deck.dart';
import 'package:bookexample/domain/models/flash_card.dart';
import 'package:bookexample/domain/models/folder.dart';

abstract class LibraryRepository {
  // Folders
  List<Folder> getFolders();
  void addFolder(Folder folder);
  void deleteFolder(String folderId);
  void renameFolder(String folderId, String newName);

  // Decks
  List<Deck> getDecksByFolder(String folderId);
  void deleteDeck(String deckId);
  void addDeckWithCards(String folderId, String title, List<FlashCard> cards);
  void updateDeckWithCards(String deckId, String title, List<FlashCard> newCards);

  // Cards
  List<FlashCard> getCardsByDeck(String deckId);
  void setCardLearned(String cardId, bool isLearned);
}