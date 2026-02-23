import 'package:bookexample/provider/mock_data_models.dart';
import 'package:flutter/material.dart';

class AppState extends ChangeNotifier{
  final List<Folder> folders = [];
  final List<Deck> decks = [];
  final List<FlashCard> cards = [];
}