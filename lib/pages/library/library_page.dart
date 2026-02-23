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
  Future<void> _showCreateFolder() async {
    final newFolderName = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => const CreateFolderSheet(),
      isScrollControlled: true,
      useRootNavigator: true,
    );
    
    if (newFolderName != null) {
      // here is creating logic
      context.read<AppState>().addFolder(newFolderName);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Folder "${newFolderName}" created!')),
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
      body: ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) {
          final folder = folders[index];
          return FolderTile(
            folderName: folder.name,
            itemCount: folder.deckIds.length,
            onTap: () {
              context.go('/library/folder/${folder.id}');
            },
          );
        },
      ),
    );
  }
}
