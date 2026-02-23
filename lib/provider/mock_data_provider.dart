import 'package:bookexample/provider/mock_data_models.dart';
import 'package:bookexample/service/folder_service.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  final List<Folder> folders = [];
  final List<Deck> decks = [];
  final List<FlashCard> cards = [];

  final FolderService _folderService = FolderService();

  void addFolder(String name){
    final folder =  _folderService.createFolder(name);
    folders.add(folder);
    notifyListeners();
  }
  
  void deleteFolder(String folderId) {
    // удалить деки этой папки
    final folderDecks =
        decks.where((d) => d.folderId == folderId).toList();
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
    final updatedFolder = folders[index].copyWith(name: newName);
  
    folders[index] = updatedFolder;
  
    notifyListeners();
  }

  void addDeck(String folderId, String title) {
    notifyListeners();
  }

  void addCard(String deckId, String front, String back) {
    notifyListeners();
  }

  List<Deck> getDecksByFolder(String folderId) =>
      decks.where((d) => d.folderId == folderId).toList();

  List<FlashCard> getCardsByDeck(String deckId) =>
      cards.where((c) => c.deckId == deckId).toList();
}
