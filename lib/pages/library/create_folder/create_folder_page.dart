import 'package:flutter/material.dart';

class CreateFolderPage extends StatelessWidget {
  const CreateFolderPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Folder")),
      body: Center(
        child: Text("CREATING FOLDER")
      ),
    );
  }
}