import 'package:bookexample/domain/models/deck.dart';
import 'package:bookexample/domain/models/flash_card.dart';
import 'package:bookexample/domain/models/folder.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  final LibraryRepository repository;

  AppState(this.repository);

  List<Folder> get folders => repository.getFolders();

  List<Deck> get decks {
    final folders = repository.getFolders();
    final allDecks = <Deck>[];
    for (var folder in folders) {
      allDecks.addAll(repository.getDecksByFolder(folder.id));
    }
    return allDecks;
  }

  List<Deck> getDecks(String folderId) =>
      repository.getDecksByFolder(folderId);

  Deck? getDeckById(String deckId) {
    try {
      return decks.firstWhere((d) => d.id == deckId);
    } catch (e) {
      return null;
    }
  }

  List<FlashCard> getCards(String deckId) =>
      repository.getCardsByDeck(deckId);

  // Alias for backward compatibility
  List<FlashCard> getCardsByDeck(String deckId) =>
      getCards(deckId);

  void addFolder(String name) {
    final folder = Folder(
      id: const Uuid().v4(),
      name: name,
    );

    repository.addFolder(folder);
    notifyListeners();
  }

  void renameFolder(String id, String newName) {
    repository.renameFolder(id, newName);
    notifyListeners();
  }

  void deleteFolder(String id) {
    repository.deleteFolder(id);
    notifyListeners();
  }

  void deleteDeck(String deckId) {
    repository.deleteDeck(deckId);
    notifyListeners();
  }

  void addDeckWithCards(String folderId, String title, List<FlashCard> cards) {
    repository.addDeckWithCards(folderId, title, cards);
    notifyListeners();
  }

  void updateDeckWithCards(String deckId, String title, List<FlashCard> newCards) {
    repository.updateDeckWithCards(deckId, title, newCards);
    notifyListeners();
  }
}