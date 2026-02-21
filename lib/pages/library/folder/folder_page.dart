import 'package:bookexample/pages/library/folder/widgets/deck_tile.dart';
import 'package:flutter/material.dart';

class FolderPage extends StatelessWidget {
  final String folderId;
  const FolderPage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    // only for testing
    final folders = [
      {'name': 'Biology', 'count': 15, 'id': "1"},
      {'name': 'History', 'count': 8, 'id': "2"},
      {'name': 'Physics', 'count': 12, 'id': "3"},
      {'name': 'Chemistry', 'count': 20, 'id': "4"},
      {'name': 'Mathematics', 'count': 25, 'id': "5"},
    ];

    final decks = [
      {'name': 'Basic Concepts', 'cardCount': 24, 'learned': 18},
      {'name': 'Advanced Topics', 'cardCount': 35, 'learned': 12},
      {'name': 'Quiz Practice', 'cardCount': 20, 'learned': 20},
      {'name': 'Vocabulary', 'cardCount': 50, 'learned': 25},
      {'name': 'Diagrams', 'cardCount': 15, 'learned': 8},
      {'name': 'Case Studies', 'cardCount': 10, 'learned': 5},
    ];

    final folder = folders.firstWhere((f) => f['id'] == folderId);
    final folderName = folder['name'];

    return Scaffold(
      appBar: AppBar(title: Text("${folderName}")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: decks.length,
          itemBuilder: (context, index) {
            final deck = decks[index];
            return DeckTile(
              deckName: deck['name'] as String,
              cardCount: deck['cardCount'] as int,
              learnedCount: deck['learned'] as int,
              onTap: () {},
            );
          },
        ),
      ),
    );
  }
}
