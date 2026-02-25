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
  void renameDeck(String deckId, String newTitle);
  // только тут не просто ринейм а еще и изменение карточек может быть

  // Cards
  List<FlashCard> getCardsByDeck(String deckId);
  void addCard(FlashCard card);
  void deleteCard(String cardId);
}