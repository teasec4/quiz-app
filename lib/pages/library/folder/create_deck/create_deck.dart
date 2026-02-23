import 'package:bookexample/models/card_form_text_form_field.dart';
import 'package:bookexample/provider/mock_data_models.dart';
import 'package:bookexample/provider/mock_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CreateDeck extends StatefulWidget {
  final String folderId;
  const CreateDeck({super.key, required this.folderId});

  @override
  State<CreateDeck> createState() => _CreateDeckState();
}

class _CreateDeckState extends State<CreateDeck> {
  final _formKey = GlobalKey<FormState>();
  List<CardFormTextFormField> cards = [CardFormTextFormField()];
  final _deckTitle = TextEditingController();
  bool _hasChanges = false;
  late AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = context.read<AppState>();
  }

  @override
  void dispose() {
    for (var card in cards) {
      card.dispose();
    }
    _deckTitle.dispose();
    super.dispose();
  }

  void _saveCard() {
    // Some of Cards field are empty ERROR
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all required fields'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }
    // Deck title is Empty ERROR
    if (_deckTitle.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a deck title'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
      return;
    }

    final List<FlashCard> newCards = cards.map((card) {
      return FlashCard(
        id: Uuid().v4(),
        deckId: "",
        front: card.frontController.text,
        back: card.backController.text,
      );
    }).toList();

    _appState.addDeckWithCards(widget.folderId, _deckTitle.text, newCards);

    context.pop();

    // save logic
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Deck saved successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
    _hasChanges = false;
  }

  void _addCard() {
    setState(() {
      cards.add(CardFormTextFormField());
      _hasChanges = true;
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
        _hasChanges = true;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Card deleted'),
          duration: Duration(seconds: 1),
        ),
      );
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
                Tooltip(
                  message: 'Delete card',
                  child: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _removeCard(index),
                    tooltip: 'Remove this card',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: card.frontController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
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
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
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
    return PopScope(
      canPop: !_hasChanges,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) {
          return;
        }

        final confirm = await showDialog<bool>(
          context: context,
          builder: (_) => AlertDialog(
            title: const Text('Unsaved Changes'),
            content: const Text(
              'You have unsaved changes. Do you want to leave?',
            ),
            actions: [
              TextButton(
                onPressed: () => context.pop(false),
                child: const Text('Stay'),
              ),
              TextButton(
                onPressed: () => context.pop(true),
                child: const Text('Leave'),
              ),
            ],
          ),
        );

        if (confirm == true && context.mounted) {
          context.pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("Create Deck"),
          elevation: 2,
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      context.pop();
                    },
                    tooltip: 'Cancel',
                  ),
                  IconButton(
                    icon: const Icon(Icons.save),
                    onPressed: _saveCard,
                    tooltip: 'Save deck',
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                controller: _deckTitle,
                onChanged: (_) {
                  setState(() {
                    _hasChanges = true;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Deck Title",
                  border: const OutlineInputBorder(),
                  prefixIcon: const Icon(Icons.book),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 80),
                  itemCount: cards.length,
                  itemBuilder: (context, index) => _buildCardForm(index),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addCard,
          icon: const Icon(Icons.add),
          label: const Text("Add Card"),
          tooltip: 'Add a new flashcard',
        ),
      ),
    );
  }
}
