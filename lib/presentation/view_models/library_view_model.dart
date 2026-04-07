import 'dart:async';

import 'package:collection/collection.dart';
import 'package:bookexample/data/models/library/deck_entity.dart';
import 'package:bookexample/data/models/library/flashcard_entity.dart';
import 'package:bookexample/data/models/library/folder_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/presentation/pages/session/models/study_session_draft.dart';
import 'package:bookexample/presentation/view_models/base_view_model.dart';

class LibraryViewModel extends BaseViewModel {
  final LibraryRepository repository;

  // Internal state for folders and decks
  List<FolderEntity> _folders = [];
  Map<int, List<DeckEntity>> _decksByFolder = {};

  // Stream subscriptions
  StreamSubscription<List<FolderEntity>>? _foldersSubscription;
  final Map<int, StreamSubscription<List<DeckEntity>>> _deckSubscriptions = {};
  StreamSubscription<List<FlashCardEntity>>? _flashcardsSubscription;

  LibraryViewModel(this.repository) {
    _initializeStreams();
  }

  // Getters for UI
  List<FolderEntity> get folders => _folders;

  List<DeckEntity> getDecksForFolder(int folderId) {
    return _decksByFolder[folderId] ?? [];
  }

  FolderEntity? getFolderByIdSync(int folderId) {
    return _folders.firstWhereOrNull((folder) => folder.id == folderId);
  }

  // Initialize stream subscriptions
  void _initializeStreams() {
    // Subscribe to folders stream
    _foldersSubscription = repository.watchFolders().listen(
      (folders) {
        _folders = folders;
        notifyListeners();
      },
      onError: (error) {
        setError('Failed to load folders: $error');
      },
    );

    // Subscribe to flashcards stream to detect changes in card status
    _flashcardsSubscription = repository.watchAllFlashcards().listen(
      (_) {
        // When flashcards change, refresh all deck data
        _refreshAllDecksData();
      },
      onError: (error) {
        setError('Failed to watch flashcards: $error');
      },
    );
  }

  // Subscribe to decks for a specific folder
  void _subscribeToDecksForFolder(int folderId) {
    if (_deckSubscriptions.containsKey(folderId)) {
      return; // Already subscribed
    }

    final subscription = repository
        .watchDecksByFolder(folderId)
        .listen(
          (decks) {
            _decksByFolder[folderId] = decks;
            notifyListeners();
          },
          onError: (error) {
            setError('Failed to load decks for folder $folderId: $error');
          },
        );

    _deckSubscriptions[folderId] = subscription;
  }

  // Unsubscribe from decks for a specific folder
  void _unsubscribeFromDecksForFolder(int folderId) {
    final subscription = _deckSubscriptions.remove(folderId);
    subscription?.cancel();
  }

  // Ensure decks for a folder are being watched
  void ensureDecksWatched(int folderId) {
    _subscribeToDecksForFolder(folderId);
  }

  // Clean up all subscriptions
  @override
  void dispose() {
    _foldersSubscription?.cancel();
    for (final subscription in _deckSubscriptions.values) {
      subscription.cancel();
    }
    _deckSubscriptions.clear();
    _flashcardsSubscription?.cancel();
    super.dispose();
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
    // Clean up deck subscriptions for the deleted folder
    // Only do this if the delete succeeded
    _unsubscribeFromDecksForFolder(folderId);
    _decksByFolder.remove(folderId);
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

  /// Refresh all deck data when flashcards change
  void _refreshAllDecksData() {
    for (final folderId in _deckSubscriptions.keys) {
      _forceRefreshFolderDecks(folderId);
    }
  }

  /// Force refresh decks for a specific folder
  Future<void> _forceRefreshFolderDecks(int folderId) async {
    try {
      final decks = await repository.getAllDecksById(folderId);
      _decksByFolder[folderId] = decks;
      notifyListeners();
    } catch (error) {
      setError('Failed to refresh decks for folder $folderId: $error');
    }
  }
}
