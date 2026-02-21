import 'package:bookexample/pages/library/widgets/folder_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final folders = [
      {'name': 'Biology', 'count': 15, 'id': "1"},
      {'name': 'History', 'count': 8, 'id': "2"},
      {'name': 'Physics', 'count': 12, 'id': "3"},
      {'name': 'Chemistry', 'count': 20, 'id': "4"},
      {'name': 'Mathematics', 'count': 25, 'id': "5"},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text("Library")),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go('/library/create-folder');
        },
        mini: true,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: ListView.builder(
        itemCount: folders.length,
        itemBuilder: (context, index) {
          final folder = folders[index];
          return FolderTile(
            folderName: folder['name'] as String,
            itemCount: folder['count'] as int,
            onTap: () {
              context.go('/library/folder/${folder["id"]}');
            },
          );
        },
      ),
    );
  }
}
