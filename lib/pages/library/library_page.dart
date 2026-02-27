import 'package:bookexample/core/service_locator.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/pages/library/widgets/create_folder_sheet.dart';
import 'package:bookexample/pages/library/widgets/folder_tile.dart';
import 'package:bookexample/provider/mock_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatelessWidget {
  final LibraryRepository repository;
  const LibraryPage({super.key, required this.repository});

  // creating folder bottom sheet
  Future<void> _showCreateFolder(BuildContext context) async {
    final newFolderName = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => const CreateFolderSheet(),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    // avoid async gap
    if (!context.mounted) return;

    if (newFolderName != null) {
      // here is creating logic
      context.read<AppState>().addFolder(newFolderName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Folder "${newFolderName}" created!'),
        ),
      );
    }
  }

  // rename folder bottom sheet
  Future<void> _showRenameFolder(
    BuildContext context,
    int folderId,
    String oldName,
  ) async {
    final newFolderName = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => CreateFolderSheet(oldName: oldName),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    // avoid async gap
    if (!context.mounted) return;

    if (newFolderName != null) {
      // here is creating logic
      repository.renameFolder(folderId, newFolderName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Folder "$oldName" renamed to "$newFolderName"'),
        ),
      );
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    int folderId,
    String folderName,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Folder - $folderName?'),
        content: const Text(
          'This will also delete all decks and cards inside.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              repository.deleteFolder(folderId);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Folder "$folderName" deleted')),
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
    return Scaffold(
      appBar: AppBar(title: const Text("Library")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showCreateFolder(context);
        },
        mini: true,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: StreamBuilder(
        stream: getIt<LibraryRepository>().watchFolders(),
        builder: (context, asyncSnapshot) {
          final folders = asyncSnapshot.data ?? [];
          return folders.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    final folder = folders[index];
                    // final decks = await isar.deckEntitys.where().findAll();
                    // .filter().projectIdEqualTo(id)
                    // and .lenght() - deckCount
                    return FolderTile(
                      folderName: folder.name,
                      deckCount: 1,
                      onTap: () {
                        context.go('/library/folder/${folder.id}');
                      },
                      onDelete: () {
                        _showDeleteConfirmation(
                          context,
                          folder.id,
                          folder.name,
                        );
                      },
                      onEdit: () {
                        _showRenameFolder(context, folder.id, folder.name);
                      },
                    );
                  },
                );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
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
          SizedBox(height: 8),
          Text(
            'Tap + to create your first folder',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
