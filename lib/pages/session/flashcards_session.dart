import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  final List<Map<String, String>> cards = [
    {'front': 'What is Flutter?', 'back': 'A cross-platform mobile framework'},
    {'front': 'What is Dart?', 'back': 'A programming language for Flutter'},
    {'front': 'What is Material Design?', 'back': 'Google design system'},
    {'front': 'What is a Widget?', 'back': 'Basic building block in Flutter'},
    {'front': 'What is State?', 'back': 'Data that determines widget behavior'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
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

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${currentIndex + 1}/${cards.length}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  _statBox('✓', correctCount, Colors.green),
                  const SizedBox(width: 8),
                  _statBox('✗', incorrectCount, Colors.red),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: currentIndex / cards.length,
            minHeight: 6,
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

  Widget _buildCard() {
    final card = cards[currentIndex];

    return GestureDetector(
      onTap: () => setState(() => showBack = !showBack),
      onHorizontalDragUpdate: (details) {
        if (!isAnimating) {
          setState(() {
            dragOffset += details.delta.dx;
          });
        }
      },
      onHorizontalDragEnd: (details) {
        _handleSwipe(details.primaryVelocity ?? 0);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final offset =
              _controller.isAnimating ? _animation.value : dragOffset;

          final rotation = offset / 1000;

          return Transform.translate(
            offset: Offset(offset, 0),
            child: Transform.rotate(
              angle: rotation,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 380,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: showBack
                        ? [
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(context).colorScheme.secondary
                          ]
                        : [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                            Theme.of(context).colorScheme.primary
                          ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    showBack ? card['back']! : card['front']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (currentIndex >= cards.length) {
      return const SizedBox.shrink();
    }

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
          _buildHeader(),
          Expanded(
            child: Center(
              child: _buildCard(),
            ),
          ),
        ],
      ),
    );
  }
}