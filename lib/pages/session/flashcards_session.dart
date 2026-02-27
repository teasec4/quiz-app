
import 'package:bookexample/core/service_locator.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bookexample/pages/study/widgets/stats_header.dart';
import 'widgets/session_header.dart';
import 'widgets/flash_card.dart' as flash_card_widget;

class FlashcardsSession extends StatefulWidget {
  final int deckId;
  final int folderId;

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

  late Future<List<FlashCardEntity>> _cardsFuture;
  List<FlashCardEntity> cards = [];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = Tween<double>(begin: 0, end: 0).animate(_controller);

    // Get cards from repository
    _cardsFuture = getIt<LibraryRepository>().getCardsByDeck(widget.deckId);
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

    final currentCard = cards[currentIndex];

    _animation = Tween<double>(
      begin: dragOffset,
      end: target,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward(from: 0).then((_) async {
      try {
        await getIt<LibraryRepository>().setCardsLearned(
          [currentCard.id],
          isCorrect,
        );
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error saving card status: $e'),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
      
      if (mounted) {
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
              backgroundColor: Theme.of(
                context,
              ).colorScheme.error.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation(
                Theme.of(context).colorScheme.tertiary,
              ),
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
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '$icon $value',
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FlashCardEntity>>(
      future: _cardsFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        }

        cards = snapshot.data!;
        if (cards.isEmpty) {
          return Scaffold(
            appBar: AppBar(title: const Text('Flashcard Session')),
            body: const Center(
              child: Text('No cards in this deck'),
            ),
          );
        }

        final displayIndex = currentIndex >= cards.length
            ? cards.length - 1
            : currentIndex;
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
                statBoxBuilder: (icon, value, color) =>
                    _statBox(icon, value, color),
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
      },
    );
  }
}
