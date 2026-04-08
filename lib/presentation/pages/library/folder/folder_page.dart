import 'package:bookexample/data/models/library/deck_entity.dart';
import 'package:bookexample/l10n/app_localizations.dart';
import 'package:bookexample/presentation/view_models/library_view_model.dart';
import 'package:bookexample/presentation/pages/library/widgets/deck_tile.dart';
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
  void _deleteDeck(
    BuildContext context,
    LibraryViewModel vm,
    int deckId,
    String deckTitle,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    await vm.deleteDeck(deckId);

    if (context.mounted) {
      if (vm.hasError && vm.error != null) {
        context.showOperationErrorSnackBar(
          operation: l10n.deletingDeck,
          error: vm.error!,
          onRetry: () => _deleteDeck(context, vm, deckId, deckTitle),
        );
      } else if (vm.isSuccess) {
        context.showOperationSuccessSnackBar(
          operation: l10n.deckDeleted(deckTitle),
        );
        vm.resetSuccess();
      }
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    LibraryViewModel vm,
    int deckId,
    String deckTitle,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(dialogContext).colorScheme.errorContainer,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.delete_outline,
                    color: Theme.of(dialogContext).colorScheme.error,
                    size: 32,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  l10n.deleteDeckTitle,
                  style: Theme.of(
                    dialogContext,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  l10n.deleteDeckMessage(deckTitle),
                  style: Theme.of(dialogContext).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(dialogContext).colorScheme.onSurfaceVariant,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(dialogContext),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(l10n.cancel),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.pop(dialogContext);
                          _deleteDeck(context, vm, deckId, deckTitle);
                        },
                        style: FilledButton.styleFrom(
                          backgroundColor: Theme.of(
                            dialogContext,
                          ).colorScheme.error,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: Text(l10n.delete),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<LibraryViewModel>(
      builder: (context, vm, child) {
        // Initialize stream subscription on first build
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            vm.ensureDecksWatched(widget.folderId);
          }
        });

        final decks = vm.getDecksForFolder(widget.folderId);
        final folder = vm.getFolderByIdSync(widget.folderId);
        final folderTitle = folder?.name ?? l10n.loading;

        return Scaffold(
          appBar: AppBar(title: Text(folderTitle)),
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
              _buildDecksList(context, vm, decks),
              if (vm.isLoading) LoadingOverlayWidget.scrim(opacity: 0.3),
              if (vm.hasError && vm.error != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ErrorBannerWidget.fromError(
                    error: vm.error!,
                    onClose: vm.clearError,
                    onTap: () {},
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDecksList(
    BuildContext context,
    LibraryViewModel vm,
    List<DeckEntity> decks,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return decks.isEmpty
        ? EmptyStateWidget.decks()
        : Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(l10n.decks, style: context.titleLargeBold),
                ),
              ),
              if (decks.isEmpty)
                Center(
                  child: EmptyStateWidget(
                    icon: Icons.menu_book,
                    title: l10n.noDecks,
                    subtitle: l10n.createFirstItem('deck'),
                  ),
                )
              else
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
                            context.go(
                              '/library/folder/${widget.folderId}/editdeck/${deck.id}',
                            );
                          },
                          onDelete: () {
                            _showDeleteConfirmation(
                              context,
                              vm,
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
  }
}
