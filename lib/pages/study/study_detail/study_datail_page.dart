import 'package:flutter/material.dart';

class StudyDatailPage extends StatelessWidget {
  const StudyDatailPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Detail'),
       
      ),
      body: const Center(
        child: Text("Detail content"),
      ),
    );
  }
}