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

  List<Deck> getDecks(String folderId) =>
      repository.getDecksByFolder(folderId);

  List<FlashCard> getCards(String deckId) =>
      repository.getCardsByDeck(deckId);

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

  void addDeck(String folderId, String title) {
    final deck = Deck(
      id: const Uuid().v4(),
      folderId: folderId,
      title: title,
    );

    repository.addDeck(deck);
    notifyListeners();
  }

  void updateDeck(String deckId, Deck updatedDeck) {
    repository.updateDeck(deckId, updatedDeck);
    notifyListeners();
  }

  void deleteDeck(String deckId) {
    repository.deleteDeck(deckId);
    notifyListeners();
  }

  void addCard(String deckId, String front, String back) {
    final card = FlashCard(
      id: const Uuid().v4(),
      deckId: deckId,
      front: front,
      back: back,
    );

    repository.addCard(card);
    notifyListeners();
  }

  void updateCard(String cardId, String front, String back) {
    repository.updateCard(cardId, front, back);
    notifyListeners();
  }

  void deleteCard(String cardId) {
    repository.deleteCard(cardId);
    notifyListeners();
  }
}