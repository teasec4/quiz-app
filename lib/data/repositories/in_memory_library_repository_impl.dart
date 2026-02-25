import 'package:bookexample/domain/models/deck.dart';
import 'package:bookexample/domain/models/flash_card.dart';
import 'package:bookexample/domain/models/folder.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';

class InMemoryLibraryRepositoryImpl implements LibraryRepository{
  @override
  void addCard(FlashCard card) {
    // TODO: implement addCard
  }

  @override
  void addDeck(Deck deck) {
    // TODO: implement addDeck
  }

  @override
  void addFolder(Folder folder) {
    // TODO: implement addFolder
  }

  @override
  void deleteCard(String cardId) {
    // TODO: implement deleteCard
  }

  @override
  void deleteDeck(String deckId) {
    // TODO: implement deleteDeck
  }

  @override
  void deleteFolder(String folderId) {
    // TODO: implement deleteFolder
  }

  @override
  List<FlashCard> getCardsByDeck(String deckId) {
    // TODO: implement getCardsByDeck
    throw UnimplementedError();
  }

  @override
  List<Deck> getDecksByFolder(String folderId) {
    // TODO: implement getDecksByFolder
    throw UnimplementedError();
  }

  @override
  List<Folder> getFolders() {
    // TODO: implement getFolders
    throw UnimplementedError();
  }

  @override
  void renameDeck(String deckId, String newTitle) {
    // TODO: implement renameDeck
  }

  @override
  void renameFolder(String folderId, String newName) {
    // TODO: implement renameFolder
  }
  
}