import 'package:bookexample/pages/library/folder/widgets/deck_tile.dart';
import 'package:bookexample/pages/library/widgets/create_folder_sheet.dart';
import 'package:bookexample/provider/mock_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FolderPage extends StatefulWidget {
  final String folderId;
  const FolderPage({super.key, required this.folderId});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  // edit deck
  void _editDeck(String deckId) {
    context.go('/library/folder/${widget.folderId}/editdeck/$deckId');
  }

  // delete deck
  void _showDeleteConfirmation(String deckId, String deckTitle) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Deck?'),
        content: Text('All $deckTitle cards will be deleted.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<AppState>().deleteDeck(deckId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Deck "$deckTitle" deleted')),
              );
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<AppState>();

    final folder = appState.folders.firstWhere((f) => f.id == widget.folderId);

    final decks = appState.getDecksByFolder(folder.id);

    return Scaffold(
      appBar: AppBar(title: Text(folder.name)),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/library/folder/${widget.folderId}/createdeck');
        },
        mini: true,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: decks.isEmpty
            ? _buildEmptyState()
            : Padding(
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
                      deckName: deck.title,
                      cardCount: deck.cardCount,
                      learnedCount: deck.learnedCount,
                      onTap: () {
                        context.go(
                          '/library/folder/${widget.folderId}/deck/${deck.id}',
                        );
                      },
                      onEdit: () {
                        _editDeck(deck.id);
                      },
                      onDelete: () {
                        _showDeleteConfirmation(deck.id, deck.title);
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.card_giftcard, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No Decks yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: 8),
          Text(
            'Tap + to create your first decks',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
