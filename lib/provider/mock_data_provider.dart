import 'package:bookexample/provider/mock_data_models.dart';
import 'package:bookexample/service/deck_service.dart';
import 'package:bookexample/service/folder_service.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  final List<Folder> folders = [];
  final List<Deck> decks = [];
  final List<FlashCard> cards = [];

  final FolderService _folderService = FolderService();
  final DeckService _deckService = DeckService();

  
  // === FOLDER OPERATIONS ===

  void addFolder(String name) {
    final folder = _folderService.createFolder(name);
    folders.add(folder);
    notifyListeners();
  }

  void deleteFolder(String folderId) {
    // удалить деки этой папки
    final folderDecks = decks.where((d) => d.folderId == folderId).toList();
    for (final deck in folderDecks) {
      // удалить карточки этой деки
      cards.removeWhere((c) => c.deckId == deck.id);
    }
    // удалить деки
    decks.removeWhere((d) => d.folderId == folderId);
    // удалить папку
    folders.removeWhere((f) => f.id == folderId);
    notifyListeners();
  }

  void renameFolder(String folderId, String newName) {
    final index = folders.indexWhere((f) => f.id == folderId);
    if (index == -1) return;
    folders[index] = folders[index].copyWith(name: newName);
    notifyListeners();
  }

  // === DECK OPERATIONS ===

  void addDeckWithCards(
    String folderId,
    String deckTitle,
    List<FlashCard> newCards,
  ) {
    // create deck
    final deck = _deckService.createDeck(folderId, deckTitle);
    decks.add(deck);
    
    // update cards with correct deckId
    final cardsWithDeckId = newCards.map((card) {
      return card.copyWith(deckId: deck.id);
    }).toList();
    cards.addAll(cardsWithDeckId);
    
    // update deck cardCount
    final index = decks.indexWhere((d) => d.id == deck.id);
    if (index != -1) {
      decks[index] = decks[index].copyWith(cardCount: cardsWithDeckId.length);
    }
    notifyListeners();
  }

  void deleteDeck(String deckId) {
    // удалить карточки деки
    cards.removeWhere((c) => c.deckId == deckId);
    // удалить деку
    decks.removeWhere((d) => d.id == deckId);
    notifyListeners();
  }

  // === CARD OPERATIONS ===

  void addCard(String deckId, String front, String back) {
    final card = _deckService.createCard(deckId, front, back);
    cards.add(card);
    // update deck cardCount
    final deckIndex = decks.indexWhere((d) => d.id == deckId);
    if (deckIndex != -1) {
      final newCount = getCardsByDeck(deckId).length + 1;
      decks[deckIndex] = decks[deckIndex].copyWith(cardCount: newCount);
    }
    notifyListeners();
  }

  void deleteCard(String cardId) {
    final card = cards.firstWhere((c) => c.id == cardId);
    cards.remove(card);
    // update deck cardCount
    final deckIndex = decks.indexWhere((d) => d.id == card.deckId);
    if (deckIndex != -1) {
      final newCount = getCardsByDeck(card.deckId).length;
      decks[deckIndex] = decks[deckIndex].copyWith(cardCount: newCount);
    }
    notifyListeners();
  }

  // === QUERIES ===

  List<Deck> getDecksByFolder(String folderId) =>
      decks.where((d) => d.folderId == folderId).toList();

  List<FlashCard> getCardsByDeck(String deckId) =>
      cards.where((c) => c.deckId == deckId).toList();

  Folder? getFolderById(String folderId) =>
      folders.firstWhere((f) => f.id == folderId);

  Deck? getDeckById(String deckId) =>
      decks.firstWhere((d) => d.id == deckId);
}
