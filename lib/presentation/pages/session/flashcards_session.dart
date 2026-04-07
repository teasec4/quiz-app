import 'package:bookexample/presentation/view_models/study_session_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
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
  // Swipe animation constants
  static const double swipeThreshold = 300.0;
  static const double swipeTarget = 800.0;

  // Animation constants
  static const Duration animationDuration = Duration(milliseconds: 250);
  static const double animationStartValue = 0.0;
  static const double animationResetValue = 0.0;

  // UI constants
  static const double smallSpacing = 8.0;
  static const double mediumSpacing = 16.0;
  static const double borderRadius = 12.0;
  static const double colorOpacity = 0.15;

  late StudySessionViewModel _studyVM;
  late AnimationController _controller;
  late Animation<double> _animation;

  double dragOffset = 0;
  bool showBack = false;
  bool isAnimating = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animationDuration);
    _animation = Tween<double>(
      begin: animationStartValue,
      end: animationResetValue,
    ).animate(_controller);
    _studyVM = context.read<StudySessionViewModel>();
    _studyVM.startSession(widget.deckId);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // RIGHT side - TRUE
  // LEFT side - FALSE
  void _handleSwipe(double velocity) {
    if (velocity > swipeThreshold) {
      _animateOut(swipeTarget, true);
    } else if (velocity < -swipeThreshold) {
      _animateOut(-swipeTarget, false);
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
      // Ответить на текущую карту через ViewModel
      _studyVM.answerCurrentCard(isCorrect);

      setState(() {
        dragOffset = animationResetValue;
        showBack = false;
        isAnimating = false;
      });

      // Если закончилась сессия
      if (_studyVM.session?.isFinished ?? false) {
        _showSessionComplete();
      }
    });
  }

  void _resetPosition() {
    _animation = Tween<double>(
      begin: dragOffset,
      end: animationResetValue,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward(from: 0).then((_) {
      setState(() {
        dragOffset = animationResetValue;
        showBack = false;
      });
    });
  }

  void _showSessionComplete() {
    final session = _studyVM.session;
    if (session == null) return;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        title: const Text('Session Complete'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Correct: ${session.correctCount}/${session.cards.length}'),
            const SizedBox(height: smallSpacing),
            Text(
              'Incorrect: ${session.incorrectCount}/${session.cards.length}',
            ),
            const SizedBox(height: mediumSpacing),
            LinearProgressIndicator(
              value: session.correctCount / session.cards.length,
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
            onPressed: () async {
              await _studyVM.completeSession();

              if (mounted) {
                Navigator.pop(context);
                context.go('/study');
              }
            },
            child: const Text('Done'),
          ),
        ],
      ),
    );
  }

  Widget _statBox(String icon, int value, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: mediumSpacing,
        vertical: smallSpacing / 1.33,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: colorOpacity),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: Text(
        '$icon $value',
        style: TextStyle(color: color, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<StudySessionViewModel>(
      builder: (context, studyVM, _) {
        final session = studyVM.session;

        if (session == null) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final card = session.currentCard;
        if (card == null) {
          return const Scaffold(body: Center(child: Text('Session finished')));
        }

        return Scaffold(
          appBar: AppBar(
            title: const Text('Flashcard Session'),
            actions: [
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () {
                  context.go('/study');
                },
              ),
            ],
          ),
          body: Column(
            children: [
              SessionHeader(
                currentIndex: session.currentIndex,
                totalCards: session.cards.length,
                correctCount: session.correctCount,
                incorrectCount: session.incorrectCount,
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
