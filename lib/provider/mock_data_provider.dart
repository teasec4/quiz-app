import 'package:bookexample/provider/mock_data_models.dart';
import 'package:bookexample/service/folder_service.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier {
  final List<Folder> folders = [];
  final List<Deck> decks = [];
  final List<FlashCard> cards = [];

  final FolderService _folderService = FolderService();

  void addFolder(String name) {
    _folderService.createFolder(name);
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
