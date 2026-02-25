import 'package:bookexample/domain/models/deck.dart';
import 'package:bookexample/domain/models/flash_card.dart';
import 'package:bookexample/domain/models/folder.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';

class InMemoryLibraryRepositoryImpl implements LibraryRepository {
  final List<Folder> _folders = [];
  final List<Deck> _decks = [];
  final List<FlashCard> _cards = [];

  // FOLDERS
  @override
  List<Folder> getFolders() {
    return _folders;
  }

  @override
  void addFolder(Folder folder) {
    _folders.add(folder);
  }

  @override
  void deleteFolder(String folderId) {
    _cards.removeWhere(
      (c) => _decks
          .where((d) => d.folderId == folderId)
          .map((d) => d.id)
          .contains(c.deckId),
    );

    _decks.removeWhere((d) => d.folderId == folderId);
    _folders.removeWhere((f) => f.id == folderId);
  }

  @override
  void renameFolder(String folderId, String newName) {
    final i = _folders.indexWhere((f) => f.id == folderId);
    if (i != -1) {
      _folders[i] = _folders[i].copyWith(name: newName);
    }
  }

  // DECKS
  @override
  List<Deck> getDecksByFolder(String folderId) {
    return _decks.where((d) => d.folderId == folderId).toList();
  }

  @override
  void addDeck(Deck deck) {
    _decks.add(deck);
  }

  @override
  void deleteDeck(String deckId) {
    _cards.removeWhere((c) => c.deckId == deckId);
    _decks.removeWhere((d) => d.id == deckId);
  }

  @override
  void updateDeck(String deckId, Deck updatedDeck) {
    final i = _decks.indexWhere((d) => d.id == deckId);
    if (i != -1) {
      _decks[i] = updatedDeck;
    }
  }

  // CARD
  @override
  List<FlashCard> getCardsByDeck(String deckId) {
    return _cards.where((c) => c.deckId == deckId).toList();
  }

  @override
  void addCard(FlashCard card) {
    _cards.add(card);
  }

  @override
  void updateCard(String cardId, String front, String back) {
    final i = _cards.indexWhere((c) => c.id == cardId);
    if (i != -1) {
      _cards[i] = _cards[i].copyWith(front: front, back: back);
    }
  }

  @override
  void deleteCard(String cardId) {
    _cards.removeWhere((c) => c.id == cardId);
  }
}
