import 'package:bookexample/pages/library/widgets/create_folder_sheet.dart';
import 'package:bookexample/pages/library/widgets/folder_tile.dart';
import 'package:bookexample/provider/mock_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  // creating folder bottom sheet
  Future<void> _showCreateFolder() async {
    final newFolderName = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => const CreateFolderSheet(),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    // avoid async gap
    if (!mounted) return;

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
  Future<void> _showRenameFolder(String folderId, String oldName) async {
    final newFolderName = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => CreateFolderSheet(oldName:oldName),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    // avoid async gap
    if (!mounted) return;

    if (newFolderName != null) {
      // here is creating logic
      context.read<AppState>().renameFolder(folderId, newFolderName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 1),
          content: Text('Folder "$oldName" renamed to "$newFolderName"'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final folders = context.watch<AppState>().folders;

    return Scaffold(
      appBar: AppBar(title: const Text("Library")),
      floatingActionButton: FloatingActionButton(
        onPressed: _showCreateFolder,
        mini: true,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        child: folders.isEmpty
            ? _buildEmptyState()
            : ListView.builder(
                itemCount: folders.length,
                itemBuilder: (context, index) {
                  final folder = folders[index];
                  final decks = context.watch<AppState>().decks;
                  final deckCount = decks.where((d) => d.folderId == folder.id).length;
                  return FolderTile(
                    folderName: folder.name,
                    deckCount: deckCount,
                    onTap: () {
                      context.go('/library/folder/${folder.id}');
                    },
                    onDelete: () {
                      context.read<AppState>().deleteFolder(folder.id);
                    },
                    onEdit: () {
                      _showRenameFolder(folder.id ,folder.name);
                    },
                  );
                },
              ),
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
