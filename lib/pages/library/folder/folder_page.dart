import 'package:bookexample/view_models/library_view_model.dart';
import 'package:bookexample/pages/library/folder/widgets/deck_tile.dart';
import 'package:bookexample/core/widgets/empty_state_widget.dart';
import 'package:bookexample/core/widgets/loading_overlay_widget.dart';
import 'package:bookexample/core/widgets/error_banner_widget.dart';
import 'package:bookexample/core/extensions/snackbar_extensions.dart';
import 'package:bookexample/core/theme/text_styles.dart';
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
    vm.ensureDecksWatched(widget.folderId);
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
      builder: (context) {
        final vm = context.read<LibraryViewModel>();
        return AlertDialog(
          title: const Text('Delete Deck?'),
          content: Text('All $deckTitle cards will be deleted.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                await vm.deleteDeck(deckId);

                if (context.mounted) {
                  Navigator.pop(context);

                  if (vm.hasError && vm.error != null) {
                    context.showOperationErrorSnackBar(
                      operation: 'deleting deck',
                      error: vm.error!,
                      onRetry: () =>
                          _showDeleteConfirmation(context, deckId, deckTitle),
                    );
                  } else if (vm.isSuccess) {
                    context.showOperationSuccessSnackBar(
                      operation: 'Deck "$deckTitle" deleted',
                    );
                    vm.resetSuccess();
                  }
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        );
      },
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
              _buildDecksList(context, vm),
              if (vm.isLoading) LoadingOverlayWidget.scrim(opacity: 0.3),
              if (vm.hasError && vm.error != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ErrorBannerWidget.fromError(
                    error: vm.error!,
                    onClose: vm.clearError,
                    onTap: () {
                      // Retry loading folder
                      setState(() {});
                    },
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDecksList(BuildContext context, LibraryViewModel vm) {
    final decks = vm.getDecksForFolder(widget.folderId);
    return decks.isEmpty
        ? EmptyStateWidget.decks()
        : Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text('Decks', style: context.titleLargeBold),
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
                          _showDeleteConfirmation(context, deck.id, deck.title);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}
