import 'package:bookexample/data/models/library/flashcard_entity.dart';
import 'package:bookexample/data/models/card_form_fields.dart';
import 'package:bookexample/presentation/view_models/library_view_model.dart';
import 'package:bookexample/core/validation/validators.dart';
import 'package:bookexample/core/extensions/snackbar_extensions.dart';
import 'package:bookexample/core/widgets/loading_overlay_widget.dart';
import 'package:flutter/material.dart';
import 'package:bookexample/core/theme/text_styles.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CreateDeck extends StatefulWidget {
  final int folderId;
  final int? deckId;
  const CreateDeck({super.key, required this.folderId, this.deckId});

  @override
  State<CreateDeck> createState() => _CreateDeckState();
}

class _CreateDeckState extends State<CreateDeck> {
  final _formKey = GlobalKey<FormState>();
  List<CardFormFields> cards = [CardFormFields()];
  final _deckTitle = TextEditingController();
  late FocusNode _deckTitleFocus;
  bool _hasChanges = false;
  bool _deckTitleError = false;
  String? _deckTitleErrorMessage;
  final _deckValidator = DeckValidator();
  final _flashCardValidator = FlashCardValidator();
  Future? _deckFuture;
  bool _isDeckDataLoaded = false;

  @override
  void initState() {
    super.initState();
    _deckTitleFocus = FocusNode();

    // Load deck data if editing
    if (widget.deckId != null) {
      final vm = context.read<LibraryViewModel>();
      _deckFuture = vm.getDeckById(widget.deckId!);
    }

    // Request focus for DeckTitle after build only for create mode
    if (widget.deckId == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _deckTitleFocus.requestFocus();
      });
    }
    _deckTitle.addListener(() {
      if (_deckTitle.text.trim().isNotEmpty && _deckTitleError) {
        setState(() {
          _deckTitleError = false;
          _deckTitleErrorMessage = null;
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
    _isDeckDataLoaded = false;
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant CreateDeck oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Reset loading flag if deckId changes
    if (widget.deckId != oldWidget.deckId) {
      _isDeckDataLoaded = false;

      // Dispose old controllers before loading new deck
      for (var card in cards) {
        card.dispose();
      }
      cards.clear();

      // Reload deck data if editing a different deck
      if (widget.deckId != null && mounted) {
        final vm = context.read<LibraryViewModel>();
        _deckFuture = vm.getDeckById(widget.deckId!);
      } else if (widget.deckId == null) {
        // If switching from edit to create mode, add a default card
        cards.add(CardFormFields());
      }
    }
  }

  Future<void> _showSaveConfirmation() async {
    // Client-side validation using validators
    final deckValidation = _deckValidator.validate(_deckTitle.text, cards);

    if (!deckValidation.isValid) {
      // Show deck-level validation errors
      final titleError = deckValidation.getError('title');
      final cardsError = deckValidation.getError('cards');

      if (titleError != null) {
        setState(() {
          _deckTitleError = true;
          _deckTitleErrorMessage = titleError;
        });
      }

      context.showErrorSnackBar(
        titleError ?? cardsError ?? 'Please fix validation errors',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // Validate individual cards
    for (int i = 0; i < cards.length; i++) {
      final card = cards[i];
      final cardValidation = _flashCardValidator.validate(
        card.frontController.text,
        card.backController.text,
      );

      if (!cardValidation.isValid) {
        context.showErrorSnackBar(
          'Card ${i + 1}: ${cardValidation.errors.values.first}',
          duration: const Duration(seconds: 2),
        );
        return;
      }
    }

    // Form validation for additional checks
    if (!_formKey.currentState!.validate()) {
      context.showErrorSnackBar(
        'Please fill all required fields',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // If validation passed, show confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(widget.deckId == null ? "Create Deck?" : "Save Changes?"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Deck: ${_deckTitle.text}"),
            const SizedBox(height: 8),
            Text("Cards: ${cards.length}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text("Edit More"),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text("Save"),
          ),
        ],
      ),
    );

    if (confirm == true) {
      _saveCard();
    }
  }

  void _saveCard() async {
    final vm = context.read<LibraryViewModel>();

    // Prevent duplicate saves
    if (vm.isLoading) return;

    try {
      final List<FlashCardEntity> newCards = cards.map((card) {
        return FlashCardEntity()
          ..front = card.frontController.text
          ..back = card.backController.text;
      }).toList();

      if (widget.deckId == null) {
        // Creating new deck
        await vm.addDeck(widget.folderId, _deckTitle.text, newCards);
        if (mounted) {
          if (vm.hasError && vm.error != null) {
            context.showOperationErrorSnackBar(
              operation: 'saving deck',
              error: vm.error!,
              onRetry: () => _showSaveConfirmation(),
            );
          } else if (vm.isSuccess) {
            context.showOperationSuccessSnackBar(operation: 'Deck saved');
            context.pop();
            vm.resetSuccess();
          }
        }
      } else {
        // Editing existing deck
        await vm.updateDeckWithCards(widget.deckId!, _deckTitle.text, newCards);
        if (mounted) {
          if (vm.hasError && vm.error != null) {
            context.showOperationErrorSnackBar(
              operation: 'updating deck',
              error: vm.error!,
              onRetry: () => _showSaveConfirmation(),
            );
          } else if (vm.isSuccess) {
            context.showOperationSuccessSnackBar(operation: 'Deck updated');
            context.pop();
            vm.resetSuccess();
          }
        }
      }
      _hasChanges = false;
    } catch (e) {
      if (mounted) {
        context.showOperationErrorSnackBar(operation: 'saving deck', error: e);
      }
    }
  }

  void _addCard() {
    setState(() {
      cards.add(CardFormFields());
      _hasChanges = true;
    });

    // Request focus on the new card's front field
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cards.last.frontFocus.requestFocus();
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
      // Card deletion is a local operation, not using ViewModel
      context.showOperationSuccessSnackBar(operation: 'Card deleted');
    }
  }

  Future<void> _pasteToField(TextEditingController controller) async {
    try {
      final ClipboardData? data = await Clipboard.getData('text/plain');
      if (data != null && data.text != null) {
        controller.text = data.text!;
        setState(() {
          _hasChanges = true;
        });
      }
    } catch (e) {
      context.showOperationErrorSnackBar(
        operation: 'pasting from clipboard',
        error: e,
      );
    }
  }

  Widget _buildCardForm(int index) {
    final card = cards[index];

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Card ${index + 1}", style: context.titleMediumSemiBold),
                Tooltip(
                  message: 'Delete card',
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    onPressed: () => _removeCard(index),
                    tooltip: 'Remove this card',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextFormField(
              focusNode: card.frontFocus,
              controller: card.frontController,
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (_) {
                FocusScope.of(context).requestFocus(card.backFocus);
              },
              decoration: InputDecoration(
                labelText: "Front",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.paste),
                  onPressed: () => _pasteToField(card.frontController),
                  tooltip: "Paste from clipboard",
                ),
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
              focusNode: card.backFocus,
              controller: card.backController,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) {
                FocusScope.of(context).unfocus();
              },
              decoration: InputDecoration(
                labelText: "Back",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.paste),
                  onPressed: () => _pasteToField(card.backController),
                  tooltip: "Paste from clipboard",
                ),
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
      child: widget.deckId == null
          ? _buildForm()
          : FutureBuilder(
              future: _deckFuture,
              builder: (context, snapshot) {
                final deck = snapshot.data;
                if (deck == null) {
                  return (Center(child: CircularProgressIndicator()));
                }
                if (!_isDeckDataLoaded) {
                  // Dispose old controllers before clearing
                  for (var card in cards) {
                    card.dispose();
                  }

                  // Load deck data
                  _deckTitle.text = deck.title;
                  cards.clear();
                  for (var card in deck.cards) {
                    final cardForm = CardFormFields();
                    cardForm.frontController.text = card.front;
                    cardForm.backController.text = card.back;
                    cards.add(cardForm);
                  }
                  if (cards.isEmpty) {
                    cards.add(CardFormFields());
                  }

                  _isDeckDataLoaded = true;
                  // No need to call setState here since we're already in build
                }

                return _buildForm();
              },
            ),
    );
  }

  Widget _buildForm() {
    final vm = context.watch<LibraryViewModel>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.deckId == null ? "Create Deck" : "Edit Deck"),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: vm.isLoading
                ? null
                : () async {
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
                            onPressed: () =>
                                Navigator.pop(dialogContext, false),
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
      body: Stack(
        children: [
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: TextField(
                  focusNode: _deckTitleFocus,
                  controller: _deckTitle,
                  onChanged: (_) {
                    setState(() {
                      _hasChanges = true;
                    });
                  },
                  style: context.titleLargeBold.copyWith(fontSize: 18),
                  decoration: InputDecoration(
                    labelText: "Deck Title",
                    labelStyle: context.titleMedium,
                    prefixIcon: Icon(
                      Icons.title,
                      color: Theme.of(context).colorScheme.primary,
                      size: 28,
                    ),
                    errorText: _deckTitleError
                        ? (_deckTitleErrorMessage ?? 'Deck title is required')
                        : null,
                    filled: false,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: _deckTitleError
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.outline,
                        width: 1.5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                        color: _deckTitleError
                            ? Theme.of(context).colorScheme.error
                            : Theme.of(context).colorScheme.primary,
                        width: 2.5,
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
          if (vm.isLoading) LoadingOverlayWidget.scrim(opacity: 0.3),
        ],
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          FilledButton.tonal(
            onPressed: vm.isLoading ? null : _addCard,
            child: const Text("Add Card"),
          ),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: vm.isLoading ? null : _showSaveConfirmation,
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
