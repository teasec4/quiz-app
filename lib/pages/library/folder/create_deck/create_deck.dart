import 'package:bookexample/models/card_form_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateDeck extends StatefulWidget {
  const CreateDeck({super.key});

  @override
  State<CreateDeck> createState() => _CreateDeckState();
}

class _CreateDeckState extends State<CreateDeck> {
  final _formKey = GlobalKey<FormState>();
  List<CardFormTextFormField> cards = [CardFormTextFormField()];
  final _deckTitle = TextEditingController();

 
  @override
  void dispose() {
    for (var card in cards) {
      card.dispose();
    }
    _deckTitle.dispose();
    super.dispose();
  }

  void _saveCard() {
    if (_formKey.currentState!.validate()) {
      // save logic
    }
  }

  void _addCard() {
    setState(() {
      cards.add(CardFormTextFormField());
    });
  }

  void _removeCard(int index) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Delete card?"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: const Text("Delete"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      setState(() {
        cards[index].dispose();
        cards.removeAt(index);
      });
    }
  }

  Widget _buildCardForm(int index) {
    final card = cards[index];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Card ${index + 1}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _removeCard(index),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: card.frontController,
              decoration: const InputDecoration(
                labelText: "Front",
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Front required";
                }
                return null;
              },
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: card.backController,
              decoration: const InputDecoration(
                labelText: "Back",
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Back required";
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create Deck")),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _deckTitle,
              decoration: const InputDecoration(
                labelText: "Deck Title",
                border: OutlineInputBorder()
              ),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView.builder(
                itemCount: cards.length,
                itemBuilder: (context, index) => _buildCardForm(index),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: .spaceEvenly,
              crossAxisAlignment: .center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _addCard();
                  },
                  child: const Text("Add a New Card"),
                ),

                ElevatedButton(
                  onPressed: () {
                    _saveCard();
                  },
                  child: const Text("Save All"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
