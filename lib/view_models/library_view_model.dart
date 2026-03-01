import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/pages/session/models/study_session_draft.dart';
import 'package:flutter/foundation.dart';

class LibraryViewModel extends ChangeNotifier {
  final LibraryRepository repository;
  LibraryViewModel(this.repository);

  String? errorMessage;

  Stream<List<FolderEntity>> watchFolders() {
    return repository.watchFolders();
  }

  Stream<List<DeckEntity>> watchDecksByFolder(int folderId) {
    return repository.watchDecksByFolder(folderId);
  }

  Future<FolderEntity> getFolderById(int id) {
    return repository.getFolderById(id);
  }

  Future<DeckEntity> getDeckById(int deckId) {
    return repository.getDeckById(deckId);
  }

  Future<void> createFolder(String name) async {
    try {
      await repository.addFolder(name);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();

      notifyListeners();
    }
  }

  Future<void> deleteFolder(int folderId) async {
    try {
      await repository.deleteFolder(folderId);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> renameFolder(int folderId, String newName) async {
    try {
      await repository.renameFolder(folderId, newName);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> addDeck(
    int folderId,
    String title,
    List<FlashCardEntity> cards,
  ) async {
    try {
      await repository.createDeckWithCard(folderId, title, cards);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteDeck(int deckId) async {
    try {
      await repository.deleteDeck(deckId);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateDeckWithCards(
    int deckId,
    String title,
    List<FlashCardEntity> cards,
  ) async {
    try {
      await repository.updateDeckWithCards(deckId, title, cards);
      errorMessage = null;
    } catch (e) {
      errorMessage = e.toString();
      notifyListeners();
    }
  }

  Future<List<FlashCardEntity>> getCardsByDeck(int deckId) async {
    return await repository.getCardsByDeck(deckId);
  }

  Future<void> setCardsLearned(List<AnswerDraft> answeredCards) async {
    await repository.setCardsLearned(answeredCards);
  }
}
