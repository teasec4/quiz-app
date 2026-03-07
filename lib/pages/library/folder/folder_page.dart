import 'package:bookexample/view_models/library_view_model.dart';
import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/pages/library/folder/widgets/deck_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class FolderPage extends StatefulWidget {
  final int folderId;
  const FolderPage({super.key, required this.folderId});

  @override
  State<FolderPage> createState() => _FolderPageState();
}

class _FolderPageState extends State<FolderPage> {
  late Future _folderFuture;

  @override
  void initState() {
    super.initState();
    final vm = context.read<LibraryViewModel>();
    _folderFuture = vm.getFolderById(widget.folderId);
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
              final vm = context.read<LibraryViewModel>();
              await vm.deleteDeck(deckId);

              if (context.mounted) {
                Navigator.pop(context);

                if (vm.hasError && vm.error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Error deleting deck: ${vm.error!.userFriendlyMessage}',
                      ),
                      backgroundColor: Theme.of(context).colorScheme.error,
                      action: SnackBarAction(
                        label: 'Retry',
                        onPressed: () {
                          _showDeleteConfirmation(context, deckId, deckTitle);
                        },
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Deck "$deckTitle" deleted')),
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
    final vm = context.watch<LibraryViewModel>();
    return FutureBuilder(
      future: _folderFuture,
      builder: (context, asyncSnapshot) {
        final folder = asyncSnapshot.data;
        final folderTitle = folder?.name;
        return Scaffold(
          appBar: AppBar(title: Text(folderTitle ?? "Loading")),
          floatingActionButton: FloatingActionButton(
            onPressed: vm.isLoading
                ? null
                : () {
                    context.go('/library/folder/${widget.folderId}/createdeck');
                  },
            mini: true,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: Stack(
            children: [
              Builder(
                builder: (context) {
                  final vm = context.watch<LibraryViewModel>();
                  return StreamBuilder<List<DeckEntity>>(
                    stream: vm.watchDecksByFolder(widget.folderId),
                    builder: (context, asyncSnapshot) {
                      final decks = asyncSnapshot.data ?? [];
                      return decks.isEmpty
                          ? _buildEmptyState()
                          : Column(
                              children: [
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.all(16),
                                    child: Text(
                                      'Decks',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge
                                          ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
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
                                  ),
                                ),
                              ],
                            );
                    },
                  );
                },
              ),
              if (vm.isLoading)
                Container(
                  color: Theme.of(context).colorScheme.scrim.withOpacity(0.3),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              if (vm.hasError && vm.error != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Material(
                    color: Theme.of(context).colorScheme.errorContainer,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Theme.of(context).colorScheme.error,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              vm.error!.userFriendlyMessage,
                              style: TextStyle(
                                color: Theme.of(
                                  context,
                                ).colorScheme.onErrorContainer,
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              // Retry loading folder
                              setState(() {});
                            },
                            child: const Text('Retry'),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () {
                              vm.clearError();
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.card_giftcard,
            size: 64,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No Decks yet',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Tap + to create your first decks',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
