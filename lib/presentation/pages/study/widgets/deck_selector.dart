import 'package:bookexample/presentation/view_models/library_view_model.dart';
import 'package:bookexample/core/widgets/empty_state_widget.dart';
import 'package:bookexample/core/theme/spacing.dart';
import 'package:bookexample/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DeckSelector extends StatefulWidget {
  final Function(int deckId, int folderId) onDeckSelected;

  const DeckSelector({super.key, required this.onDeckSelected});

  @override
  State<DeckSelector> createState() => _DeckSelectorState();
}

class _DeckSelectorState extends State<DeckSelector> {
  int? selectedFolderId;
  int? selectedDeckId;

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (context, scrollController) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(AppSpacing.md),
            ),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: AppSpacing.cardPadding,
                child: Row(
                  children: [
                    SizedBox(
                      width: 48,
                      height: 48,
                      child: selectedFolderId != null
                          ? IconButton(
                              icon: const Icon(Icons.arrow_back),
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                setState(() {
                                  selectedFolderId = null;
                                  selectedDeckId = null;
                                });
                              },
                            )
                          : null,
                    ),
                    Expanded(
                      child: Text(
                        selectedFolderId == null
                            ? 'Select a Folder'
                            : 'Select a Deck',
                        textAlign: TextAlign.center,
                        style: context.titleLargeBold,
                      ),
                    ),
                    SizedBox(width: AppSpacing.xxl),
                  ],
                ),
              ),
              // Content
              Expanded(
                child: selectedFolderId == null
                    ? _buildFolderList()
                    : _buildDeckList(selectedFolderId ?? 0),
              ),
              Padding(
                padding: AppSpacing.cardPadding,
                child: ElevatedButton(
                  onPressed: selectedDeckId == null
                      ? null
                      : () {
                          widget.onDeckSelected(
                            selectedDeckId!,
                            selectedFolderId!,
                          );
                        },

                  child: const Text("Start Session"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFolderList() {
    return Consumer<LibraryViewModel>(
      builder: (context, viewModel, child) {
        final folders = viewModel.folders;
        if (folders.isEmpty) {
          return _buildEmptyStateFolder();
        }
        return ListView.builder(
          itemCount: folders.length,
          itemBuilder: (context, index) {
            final folder = folders[index];
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                ),
              ),
              child: ListTile(
                leading: Icon(
                  Icons.folder,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(folder.name),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  setState(() {
                    selectedFolderId = folder.id;
                    viewModel.ensureDecksWatched(folder.id);
                  });
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildDeckList(int folderId) {
    return Consumer<LibraryViewModel>(
      builder: (context, viewModel, child) {
        final decks = viewModel.getDecksForFolder(folderId);
        if (decks.isEmpty) {
          return _buildEmptyStateDeck();
        }
        return ListView.builder(
          itemCount: decks.length,
          itemBuilder: (context, index) {
            final deck = decks[index];
            final isSelected = selectedDeckId == deck.id;
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                borderRadius: AppSpacing.borderRadiusMd,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondaryContainer,
                  width: isSelected ? 2 : 1,
                ),
                color: isSelected
                    ? Theme.of(
                        context,
                      ).colorScheme.primaryContainer.withValues(alpha: 0.3)
                    : Colors.transparent,
              ),
              child: ListTile(
                leading: Icon(
                  Icons.school,
                  color: Theme.of(context).colorScheme.primary,
                ),
                title: Text(
                  deck.title,
                  style: context.bodyLarge.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
                trailing: isSelected
                    ? Icon(
                        Icons.check_circle,
                        color: Theme.of(context).colorScheme.primary,
                      )
                    : const Icon(Icons.radio_button_unchecked),
                onTap: () {
                  setState(() {
                    selectedDeckId = isSelected ? null : deck.id;
                  });
                },
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildEmptyStateFolder() {
    return EmptyStateWidget.folders(subtitle: null);
  }

  Widget _buildEmptyStateDeck() {
    return EmptyStateWidget.decks(subtitle: null);
  }
}
