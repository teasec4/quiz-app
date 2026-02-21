import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Library")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            context.go('/library/create-folder');
          },
          child: Text("Create Folder"),
        ),
      ),
    );
  }
}
