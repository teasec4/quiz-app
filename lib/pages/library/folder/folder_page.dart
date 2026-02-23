import 'package:bookexample/pages/library/folder/widgets/deck_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FolderPage extends StatelessWidget {
  final String folderId;
  const FolderPage({super.key, required this.folderId});

  @override
  Widget build(BuildContext context) {
    // only for testing
    final folders = [
      {'name': 'Biology', 'count': 15, 'id': "1"},
      
    ];

    final decks = [
      {'name': 'Basic Concepts', 'cardCount': 24, 'learned': 18, 'id': "1"},
      
    ];

    final folder = folders.firstWhere((f) => f['id'] == folderId);
    final folderName = folder['name'];

    return Scaffold(
      appBar: AppBar(title: Text("${folderName}")),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          context.go('/library/folder/${folderId}/createdeck');
        },
        mini: true,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            childAspectRatio: 1,
          ),
          itemCount: decks.length,
          itemBuilder: (context, index) {
            final deck = decks[index];
            return DeckTile(
              deckName: deck['name'] as String,
              cardCount: deck['cardCount'] as int,
              learnedCount: deck['learned'] as int,
              onTap: () {
                context.go('/library/folder/${folderId}/deck/${deck["id"]}');
              },
            );
          },
        ),
      ),
    );
  }
}
