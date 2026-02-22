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
    with TickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _cardAnimController;
  int currentIndex = 0;
  bool showBack = false;
  int correctCount = 0;
  int incorrectCount = 0;
  double dragOffset = 0;
  late AnimationController _dragAnimController;

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
    _pageController = PageController();
    _cardAnimController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _dragAnimController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _cardAnimController.dispose();
    _dragAnimController.dispose();
    super.dispose();
  }

  void _flipCard() {
    _cardAnimController.forward(from: 0.0);
    setState(() => showBack = !showBack);
  }

  void _markCorrect() {
    _animateCardOut(true);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => correctCount++);
        _nextCard();
      }
    });
  }

  void _markIncorrect() {
    _animateCardOut(false);
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        setState(() => incorrectCount++);
        _nextCard();
      }
    });
  }

  void _animateCardOut(bool isCorrect) {
    _dragAnimController.forward(from: 0.0).then((_) {
      setState(() => dragOffset = 0);
      _dragAnimController.reset();
    });
  }

  void _nextCard() {
    if (currentIndex < cards.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _showSessionComplete();
    }
  }

  void _showSessionComplete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
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

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

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
          // Header with stats
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Progress
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
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '✓ $correctCount',
                            style: TextStyle(
                              color: Colors.green[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.red[100],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            '✗ $incorrectCount',
                            style: TextStyle(
                              color: Colors.red[700],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Progress bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: (currentIndex + 1) / cards.length,
                    minHeight: 6,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation(Theme.of(context).colorScheme.primary),
                  ),
                ),
              ],
            ),
          ),
          // Cards
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                  showBack = false;
                });
              },
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return _buildCard(cards[index], screenHeight);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, String> card, double screenHeight) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: GestureDetector(
        onTap: _flipCard,
        onHorizontalDragUpdate: (details) {
          setState(() {
            dragOffset = details.delta.dx * 5; // Увеличиваем смещение
          });
        },
        onHorizontalDragEnd: (details) {
          final velocity = details.primaryVelocity ?? 0;
          final threshold = 500.0;

          if (velocity > threshold) {
            // Свайп вправо = знаю
            _markCorrect();
          } else if (velocity < -threshold) {
            // Свайп влево = не знаю
            _markIncorrect();
          } else {
            // Вернуть в исходное положение
            setState(() => dragOffset = 0);
          }
        },
        child: AnimatedBuilder(
          animation: _cardAnimController,
          builder: (context, child) {
            final angle = _cardAnimController.value * 3.14159;
            final transform = Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(angle);

            // Определяем цвет на основе направления свайпа
            Color overlayColor = Colors.transparent;
            if (dragOffset > 30) {
              overlayColor = Colors.green.withOpacity((dragOffset / 300).clamp(0, 0.3));
            } else if (dragOffset < -30) {
              overlayColor = Colors.red.withOpacity((-dragOffset / 300).clamp(0, 0.3));
            }

            return Transform(
              alignment: Alignment.center,
              transform: transform,
              child: Transform.translate(
                offset: Offset(dragOffset, 0),
                child: Stack(
                  children: [
                    Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: showBack
                                ? [Theme.of(context).colorScheme.secondary, Theme.of(context).colorScheme.secondary]
                                : [Theme.of(context).colorScheme.primary.withOpacity(0.6), Theme.of(context).colorScheme.primary],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              showBack ? 'Answer' : 'Question',
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.7),
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 24),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24),
                              child: Text(
                                showBack ? card['back']! : card['front']!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                              ),
                            ),
                            const SizedBox(height: 32),
                            if (!showBack) ...[
                              Text(
                                'Tap to reveal',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.6),
                                  fontSize: 12,
                                ),
                              ),
                            ] else ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.close,
                                                color: Colors.white, size: 32),
                                            onPressed: _markIncorrect,
                                          ),
                                          Text(
                                            'Swipe Left',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.8),
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Column(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.check,
                                                color: Colors.white, size: 32),
                                            onPressed: _markCorrect,
                                          ),
                                          Text(
                                            'Swipe Right',
                                            style: TextStyle(
                                              color: Colors.white.withOpacity(0.8),
                                              fontSize: 11,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                    // Overlay при свайпе
                    Positioned.fill(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: overlayColor,
                        ),
                      ),
                    ),
                    // Иконка свайпа
                    if (dragOffset > 50)
                      Positioned(
                        right: 20,
                        top: 20,
                        child: Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 40,
                        ),
                      )
                    else if (dragOffset < -50)
                      Positioned(
                        left: 20,
                        top: 20,
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.red,
                          size: 40,
                        ),
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Можно добавить логику если нужна реактивность
  }
}
