import 'package:flutter/material.dart';

class CreateDeck extends StatelessWidget {
  const CreateDeck({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Deck"),
      ),
      body: Center(child: Text("creating deck"),),
    );
  }
}