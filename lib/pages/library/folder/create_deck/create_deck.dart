import 'package:bookexample/core/theme/app_colors.dart';
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
  late FocusNode _deckTitleFocus;
  bool _hasChanges = false;
  bool _deckTitleError = false;
  late AppState _appState;

  @override
  void initState() {
    super.initState();
    _appState = context.read<AppState>();
    _deckTitleFocus = FocusNode();
    // Request focus for DeckTitle after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _deckTitleFocus.requestFocus();
    });
    _deckTitle.addListener(() {
      if (_deckTitle.text.trim().isNotEmpty && _deckTitleError) {
        setState(() {
          _deckTitleError = false;
        });
      }
    });
  }

  @override
  void dispose() {
    for (var card in cards) {
      card.dispose();
    }
    _deckTitle.dispose();
    _deckTitleFocus.dispose();
    super.dispose();
  }

  void _saveCard() {
    // Deck title is Empty ERROR
    if (_deckTitle.text.trim().isEmpty) {
      setState(() {
        _deckTitleError = true;
      });
      return;
    }

    // Some of Cards field are empty ERROR
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please fill all required fields'),
          backgroundColor: Theme.of(context).colorScheme.error,
          duration: const Duration(seconds: 2),
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
      SnackBar(
        content: const Text('Deck saved successfully!'),
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        duration: const Duration(seconds: 1),
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
      builder: (dialogContext) => AlertDialog(
        title: const Text("Delete card?"),
        content: const Text("Are you sure?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
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
                    icon: Icon(
                      Icons.delete,
                      color: Theme.of(context).colorScheme.error,
                    ),
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
              maxLines: 2,
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
              maxLines: 2,
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
          builder: (dialogContext) => AlertDialog(
            title: const Text('Unsaved Changes'),
            content: const Text(
              'You have unsaved changes. Do you want to leave?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, false),
                child: const Text('Stay'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(dialogContext, true),
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
            IconButton(
              icon: const Icon(Icons.close),
              onPressed: () async {
                if (!_hasChanges) {
                  context.pop();
                  return;
                }

                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (dialogContext) => AlertDialog(
                    title: const Text('Unsaved Changes'),
                    content: const Text(
                      'You have unsaved changes. Do you want to leave?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, false),
                        child: const Text('Stay'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(dialogContext, true),
                        child: const Text('Leave'),
                      ),
                    ],
                  ),
                );

                if (confirm == true && context.mounted) {
                  context.pop();
                }
              },
              tooltip: 'Cancel',
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: TextField(
                focusNode: _deckTitleFocus,
                controller: _deckTitle,
                onChanged: (_) {
                  setState(() {
                    _hasChanges = true;
                  });
                },
                decoration: InputDecoration(
                  labelText: "Deck Title",
                  prefixIcon: const Icon(Icons.book),
                  errorText: _deckTitleError ? 'Deck title is required' : null,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _deckTitleError
                          ? Theme.of(context).colorScheme.error
                          : Colors.grey.shade300,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: _deckTitleError
                          ? Theme.of(context).colorScheme.error
                          : Theme.of(context).colorScheme.primary,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: ListView.builder(
                  padding: const EdgeInsets.only(bottom: 100),
                  itemCount: cards.length,
                  itemBuilder: (context, index) => _buildCardForm(index),
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton.tonal(
              onPressed: _addCard,
              // tooltip: 'Add a new flashcard',
              // heroTag: 'add_card',
              // child: const Icon(Icons.add),
              child: const Text("Add Card"),
            ),
            const SizedBox(width: 12),
            FilledButton(
              onPressed: _saveCard,

              // backgroundColor: Theme.of(context).colorScheme.tertiary,
              // tooltip: 'Save this deck',
              // heroTag: 'save_deck',
              // child: const Icon(Icons.save),
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
