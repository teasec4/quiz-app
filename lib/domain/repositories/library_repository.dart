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
  void addDeck(Deck deck);
  void deleteDeck(String deckId);
  void updateDeck(String deckId, Deck updatedDeck);

  // Cards
  List<FlashCard> getCardsByDeck(String deckId);
  void addCard(FlashCard card);
  void updateCard(String cardId, String front, String back);
  void deleteCard(String cardId);
}