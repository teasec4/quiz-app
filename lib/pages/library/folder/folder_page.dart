import 'package:flutter/material.dart';

class FolderPage extends StatelessWidget {
  final String folderId;
  const FolderPage({super.key, required this.folderId});
  @override
  Widget build(BuildContext context) {
    // only for testing
    final folders = [
      {'name': 'Biology', 'count': 15, 'id': "1"},
      {'name': 'History', 'count': 8, 'id': "2"},
      {'name': 'Physics', 'count': 12, 'id': "3"},
      {'name': 'Chemistry', 'count': 20, 'id': "4"},
      {'name': 'Mathematics', 'count': 25, 'id': "5"},
    ];
    final folder = folders.firstWhere((f) => f['id'] == folderId);
    final folderName = folder['name'];
    return Scaffold(
      appBar: AppBar(title: Text("${folderName}"),),
      body: Center(child: Text("hi")),
    );
  }
}
