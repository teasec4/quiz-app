import 'package:bookexample/pages/library/widgets/create_folder_sheet.dart';
import 'package:bookexample/pages/library/widgets/folder_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Folder {
  final String id;
  final String name;
  final int count;

  Folder({required this.id, required this.name, this.count = 0});
}

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  final List<Folder> folders = [
    Folder(name: 'Biology', count: 15, id: "1"),
  ];

  Future<void> _showCreateFolder() async {
    final newFolder = await showModalBottomSheet<Folder?>(
      context: context,
      builder: (context) => const CreateFolderSheet(),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    if (newFolder != null) {
      setState(() {
        folders.add(newFolder);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Folder "${newFolder.name}" created!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            itemCount: folder.count,
            onTap: () {
              context.go('/library/folder/${folder.id}');
            },
          );
        },
      ),
    );
  }
}
