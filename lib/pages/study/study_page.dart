import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StudyPage extends StatelessWidget {
  const StudyPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Study"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Open Detail"),
          onPressed: (){
            context.go('/study/detail');
          },
        ),
      ),
    );
  }
}