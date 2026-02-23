import 'package:bookexample/provider/mock_data_models.dart';
import 'package:bookexample/provider/mock_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'widgets/session_header.dart';
import 'widgets/flash_card.dart' as flash_card_widget;

class FlashcardsSession extends StatefulWidget {
  final String deckId;
  final String folderId;

  const FlashcardsSession({
    super.key,
    required this.deckId,
    required this.folderId,
  });

  @override
  State<FlashcardsSession> createState() => _FlashcardsSessionState();
}

class _FlashcardsSessionState extends State<FlashcardsSession>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  int currentIndex = 0;
  int correctCount = 0;
  int incorrectCount = 0;

  double dragOffset = 0;
  bool showBack = false;
  bool isAnimating = false;

  late List<FlashCard> cards;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);
    
    // Get cards from AppState
    final appState = context.read<AppState>();
    cards = appState.getCardsByDeck(widget.deckId);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSwipe(double velocity) {
    const threshold = 300;

    if (velocity > threshold) {
      _animateOut(800, true);
    } else if (velocity < -threshold) {
      _animateOut(-800, false);
    } else {
      _resetPosition();
    }
  }

  void _animateOut(double target, bool isCorrect) {
    if (isAnimating) return;
    isAnimating = true;

    _animation = Tween<double>(
      begin: dragOffset,
      end: target,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward(from: 0).then((_) {
      setState(() {
        if (isCorrect) {
          correctCount++;
        } else {
          incorrectCount++;
        }

        currentIndex++;
        dragOffset = 0;
        showBack = false;
        isAnimating = false;
      });

      if (currentIndex >= cards.length) {
        _showSessionComplete();
      }
    });
  }

  void _resetPosition() {
    _animation = Tween<double>(
      begin: dragOffset,
      end: 0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(from: 0).then((_) {
      setState(() {
        dragOffset = 0;
        showBack = false;
      });
    });
  }

  void _showSessionComplete() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Session Complete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Correct: $correctCount/${cards.length}'),
            const SizedBox(height: 8),
            Text('Incorrect: $incorrectCount/${cards.length}'),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: correctCount / cards.length,
              minHeight: 8,
              backgroundColor: Colors.red[200],
              valueColor: const AlwaysStoppedAnimation(Colors.green),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.go(
                '/library/folder/${widget.folderId}/deck/${widget.deckId}',
              );
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _statBox(String icon, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$icon $value',
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayIndex = currentIndex >= cards.length ? cards.length - 1 : currentIndex;
    final card = cards[displayIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Session'),
        actions: [
          IconButton(
            icon: const Icon(Icons.close),
            onPressed: () {
              context.go(
                '/library/folder/${widget.folderId}/deck/${widget.deckId}',
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SessionHeader(
            currentIndex: displayIndex,
            totalCards: cards.length,
            correctCount: correctCount,
            incorrectCount: incorrectCount,
            statBoxBuilder: (icon, value, color) => _statBox(icon, value, color),
          ),
          // Counter hints row
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    const Text(
                      '← Incorrect',
                      style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$incorrectCount/${cards.length}',
                      style: const TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    const Text(
                      'Correct →',
                      style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '$correctCount/${cards.length}',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Center(
              child: flash_card_widget.FlashCardWidget(
                card: card,
                showBack: showBack,
                dragOffset: dragOffset,
                isAnimating: _controller.isAnimating,
                animation: _animation,
                controller: _controller,
                onTap: () => setState(() => showBack = !showBack),
                onDragUpdate: (details) {
                  if (!isAnimating) {
                    setState(() {
                      dragOffset += details.delta.dx;
                    });
                  }
                },
                onDragEnd: (details) {
                  _handleSwipe(details.primaryVelocity ?? 0);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
