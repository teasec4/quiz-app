import 'package:bookexample/core/service_locator.dart';
import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/pages/library/folder/widgets/deck_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FolderPage extends StatefulWidget {
  final int folderId;
  final LibraryRepository repository;
  const FolderPage({super.key, required this.folderId, required this.repository});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  late Future<FolderEntity> _folderFuture;

  @override
  void initState() {
    super.initState();
    _folderFuture = widget.repository.getFolderById(widget.folderId);
  }

  // edit deck
  void _editDeck(BuildContext context, int deckId) {
    context.go('/library/folder/${widget.folderId}/editdeck/$deckId');
  }

  // delete deck
  void _showDeleteConfirmation(
    BuildContext context,
    int deckId,
    String deckTitle,
  ) {
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
            onPressed: () async {
              try {
                await widget.repository.deleteDeck(deckId);
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Deck "$deckTitle" deleted')),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error deleting deck: $e'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                }
              }
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FolderEntity>(
      future: _folderFuture,
      builder: (context, asyncSnapshot) {
        final folder = asyncSnapshot.data;
        return Scaffold(
          appBar: AppBar(title: Text(folder?.name ?? 'loading')),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.go('/library/folder/${widget.folderId}/createdeck');
            },
            mini: true,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: StreamBuilder<List<DeckEntity>>(
            stream: getIt<LibraryRepository>().watchDecksByFolder(
              widget.folderId,
            ),
            builder: (context, asyncSnapshot) {
              final decks = asyncSnapshot.data ?? [];
              return decks.isEmpty
                  ? _buildEmptyState()
                  : Padding(
                      padding: const EdgeInsets.all(12),
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                            cardCount: deck.cards.length,
                            learnedCount: deck.cards
                                .where((c) => c.isLearned)
                                .length,
                            onTap: () {
                              context.go(
                                '/library/folder/${widget.folderId}/deck/${deck.id}',
                              );
                            },
                            onEdit: () {
                              _editDeck(context, deck.id);
                            },
                            onDelete: () {
                              _showDeleteConfirmation(
                                context,
                                deck.id,
                                deck.title,
                              );
                            },
                          );
                        },
                      ),
                    );
            },
          ),
        );
      },
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
