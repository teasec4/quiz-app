import 'package:bookexample/view_models/library_view_model.dart';
import 'package:bookexample/pages/library/widgets/create_folder_sheet.dart';
import 'package:bookexample/pages/library/widgets/folder_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});
  
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
      final vm = context.read<LibraryViewModel>();
      await vm.createFolder(newFolderName);
      
      if (!context.mounted) return;
      
      if (vm.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error creating folder: ${vm.errorMessage}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: Text('Folder "$newFolderName" created!'),
          ),
        );
      }
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
      final vm = context.read<LibraryViewModel>();
      await vm.renameFolder(folderId, newFolderName);
      
      if (!context.mounted) return;
      
      if (vm.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error renaming folder: ${vm.errorMessage}'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: const Duration(seconds: 1),
            content: Text('Folder "$oldName" renamed to "$newFolderName"'),
          ),
        );
      }
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
            onPressed: () async {
              final vm = context.read<LibraryViewModel>();
              await vm.deleteFolder(folderId);
              
              if (context.mounted) {
                Navigator.pop(context);
                
                if (vm.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error deleting folder: ${vm.errorMessage}'),
                      backgroundColor: Theme.of(context).colorScheme.error,
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Folder "$folderName" deleted')),
                  );
                }
              }
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LibraryViewModel>();

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
        stream: vm.watchFolders(),
        builder: (context, asyncSnapshot) {
          final folders = asyncSnapshot.data ?? [];
          return folders.isEmpty
              ? _buildEmptyState()
              : Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          'Folders',
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                      itemCount: folders.length,
                      itemBuilder: (context, index) {
                    final folder = folders[index];
                    
                    return FolderTile(
                      folderName: folder.name,
                      // deckCount: folder.decks.length,
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
                ),
                    ),
                  ],
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
