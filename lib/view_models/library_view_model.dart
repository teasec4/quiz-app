import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/pages/session/models/study_session_draft.dart';
import 'package:bookexample/core/view_models/base_view_model.dart';

class LibraryViewModel extends BaseViewModel {
  final LibraryRepository repository;
  LibraryViewModel(this.repository);

  Stream<List<FolderEntity>> watchFolders() {
    return repository.watchFolders();
  }

  Stream<List<DeckEntity>> watchDecksByFolder(int folderId) {
    return repository.watchDecksByFolder(folderId);
  }

  Future<List<FolderEntity>> getAllFolder() async {
    return executeAsync(
      () => repository.getAllFolders(),
      operationName: 'Get all folders',
    );
  }

  Future<FolderEntity> getFolderById(int id) {
    return executeAsync(
      () => repository.getFolderById(id),
      operationName: 'Get folder by id: $id',
    );
  }

  Future<List<DeckEntity>> getAllDecksById(int folderId) async {
    return executeAsync(
      () => repository.getAllDecksById(folderId),
      operationName: 'Get all decks by folder: $folderId',
    );
  }

  Future<DeckEntity> getDeckById(int deckId) {
    return executeAsync(
      () => repository.getDeckById(deckId),
      operationName: 'Get deck by id: $deckId',
    );
  }

  Future<void> createFolder(String name) async {
    await executeAsync(
      () => repository.addFolder(name),
      operationName: 'Create folder: $name',
    );
  }

  Future<void> deleteFolder(int folderId) async {
    await executeAsync(
      () => repository.deleteFolder(folderId),
      operationName: 'Delete folder: $folderId',
    );
  }

  Future<void> renameFolder(int folderId, String newName) async {
    await executeAsync(
      () => repository.renameFolder(folderId, newName),
      operationName: 'Rename folder: $folderId to $newName',
    );
  }

  Future<void> addDeck(
    int folderId,
    String title,
    List<FlashCardEntity> cards,
  ) async {
    await executeAsync(
      () => repository.createDeckWithCard(folderId, title, cards),
      operationName: 'Create deck: $title',
    );
  }

  Future<void> deleteDeck(int deckId) async {
    await executeAsync(
      () => repository.deleteDeck(deckId),
      operationName: 'Delete deck: $deckId',
    );
  }

  Future<void> updateDeckWithCards(
    int deckId,
    String title,
    List<FlashCardEntity> cards,
  ) async {
    await executeAsync(
      () => repository.updateDeckWithCards(deckId, title, cards),
      operationName: 'Update deck: $deckId',
    );
  }

  Future<List<FlashCardEntity>> getCardsByDeck(int deckId) async {
    return executeAsync(
      () => repository.getCardsByDeck(deckId),
      operationName: 'Get cards by deck: $deckId',
    );
  }

  Future<void> setCardsLearned(List<AnswerDraft> answeredCards) async {
    await executeAsync(
      () => repository.setCardsLearned(answeredCards),
      operationName: 'Set cards learned',
    );
  }
}
