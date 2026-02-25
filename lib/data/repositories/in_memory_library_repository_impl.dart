import 'package:bookexample/domain/models/deck.dart';
import 'package:bookexample/domain/models/flash_card.dart';
import 'package:bookexample/domain/models/folder.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:uuid/uuid.dart';

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
  void deleteDeck(String deckId) {
    _cards.removeWhere((c) => c.deckId == deckId);
    _decks.removeWhere((d) => d.id == deckId);
  }

  @override
  void addDeckWithCards(String folderId, String title, List<FlashCard> cards) {
    final deckId = const Uuid().v4();
    final deck = Deck(
      id: deckId,
      folderId: folderId,
      title: title,
      cardCount: cards.length,
    );

    _decks.add(deck);
    for (var card in cards) {
      final cardWithDeckId = card.copyWith(deckId: deckId);
      _addCard(cardWithDeckId);
    }
  }

  @override
  void updateDeckWithCards(String deckId, String title, List<FlashCard> newCards) {
    final deckIndex = _decks.indexWhere((d) => d.id == deckId);
    if (deckIndex != -1) {
      final oldDeck = _decks[deckIndex];
      _decks[deckIndex] = oldDeck.copyWith(
        title: title,
        cardCount: newCards.length,
      );

      // Delete old cards
      for (var card in _cards.where((c) => c.deckId == deckId).toList()) {
        _deleteCard(card.id);
      }

      // Add new cards
      for (var card in newCards) {
        final cardWithDeckId = card.copyWith(deckId: deckId);
        _addCard(cardWithDeckId);
      }
    }
  }

  // CARD
  @override
  List<FlashCard> getCardsByDeck(String deckId) {
    return _cards.where((c) => c.deckId == deckId).toList();
  }

  void _addCard(FlashCard card) {
    _cards.add(card);
  }

  void _deleteCard(String cardId) {
    _cards.removeWhere((c) => c.id == cardId);
  }
}
