import 'package:bookexample/view_models/library_view_model.dart';
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
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          ),
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.all(16),
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
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 48),
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
                padding: const EdgeInsets.all(16),
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
    return FutureBuilder(
      future: context.read<LibraryViewModel>().getAllFolder(),
      builder: (context, asyncSnapshot) {
        final folders = asyncSnapshot.data;
        if (folders == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (folders.isEmpty) {
          return _buildEmptyStateFolder();
        }
        return ListView.builder(
          itemCount: folders.length,
          itemBuilder: (context, index) {
            final folder = folders[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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
    return FutureBuilder(
      future: context.read<LibraryViewModel>().getAllDecksById(folderId),
      builder: (context, snapshot) {
        final decks = snapshot.data;
        if (decks == null) {
          return Center(child: CircularProgressIndicator());
        }
        if (decks.isEmpty) {
          return _buildEmptyStateDeck();
        }
        return ListView.builder(
          itemCount: decks.length,
          itemBuilder: (context, index) {
            final deck = decks[index];
            final isSelected = selectedDeckId == deck.id;
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
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
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.folder_open, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No folders yet',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyStateDeck() {
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
        ],
      ),
    );
  }
}
