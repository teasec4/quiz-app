import 'package:flutter/material.dart';

class DeckPage extends StatelessWidget {
  final String folderId;
  final String deckId;
  const DeckPage({super.key,required this.folderId ,required this.deckId});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Some Deck's Title")),
      body: Center(child: Text("Deck's center")),
    );
  }
}
