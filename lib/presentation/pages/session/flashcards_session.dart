import 'package:bookexample/presentation/view_models/study_session_view_model.dart';
import 'package:bookexample/l10n/app_localizations.dart';
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
  bool _isCompleting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animationDuration);
    _animation = Tween<double>(
      begin: animationStartValue,
      end: animationResetValue,
    ).animate(_controller);
    _studyVM = Provider.of<StudySessionViewModel>(context, listen: false);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _studyVM.startSession(widget.deckId);
      }
    });
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

      // Если закончилась сессия - показать диалог после кадра
      if (_studyVM.session?.isFinished ?? false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            _showSessionComplete();
          }
        });
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

    final l10n = AppLocalizations.of(context)!;
    final totalCards = session.cards.length;
    final correctPercent = totalCards > 0
        ? (session.correctCount / totalCards * 100).round()
        : 0;

    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black87,
      builder: (dialogContext) => Dialog(
        backgroundColor: Theme.of(dialogContext).colorScheme.surface,
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: correctPercent >= 70
                      ? Theme.of(dialogContext).colorScheme.primaryContainer
                      : Theme.of(
                          dialogContext,
                        ).colorScheme.surfaceContainerHighest,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  correctPercent >= 70
                      ? Icons.emoji_events
                      : Icons.sentiment_neutral,
                  size: 56,
                  color: correctPercent >= 70
                      ? Theme.of(dialogContext).colorScheme.primary
                      : Theme.of(dialogContext).colorScheme.tertiary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                l10n.sessionComplete,
                style: Theme.of(dialogContext).textTheme.headlineSmall
                    ?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(dialogContext).colorScheme.onSurface,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                correctPercent >= 70 ? l10n.greatJob : l10n.keepPracticing,
                style: Theme.of(dialogContext).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(dialogContext).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 28),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _resultStat(
                    dialogContext,
                    icon: Icons.check_circle_outline,
                    label: l10n.correctAnswer,
                    value: '${session.correctCount}',
                    color: Theme.of(dialogContext).colorScheme.primary,
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Theme.of(dialogContext).colorScheme.outlineVariant,
                  ),
                  _resultStat(
                    dialogContext,
                    icon: Icons.cancel_outlined,
                    label: l10n.incorrectAnswer,
                    value: '${session.incorrectCount}',
                    color: Theme.of(dialogContext).colorScheme.error,
                  ),
                  Container(
                    height: 40,
                    width: 1,
                    color: Theme.of(dialogContext).colorScheme.outlineVariant,
                  ),
                  _resultStat(
                    dialogContext,
                    icon: Icons.percent,
                    label: l10n.scoreLabel,
                    value: '$correctPercent%',
                    color: Theme.of(dialogContext).colorScheme.tertiary,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: LinearProgressIndicator(
                  value: session.correctCount / totalCards,
                  minHeight: 16,
                  backgroundColor: Theme.of(
                    dialogContext,
                  ).colorScheme.surfaceContainerHighest,
                  valueColor: AlwaysStoppedAnimation(
                    correctPercent >= 70
                        ? Theme.of(dialogContext).colorScheme.primary
                        : Theme.of(dialogContext).colorScheme.tertiary,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                l10n.cardsCorrect(session.correctCount, totalCards),
                style: Theme.of(dialogContext).textTheme.bodySmall?.copyWith(
                  color: Theme.of(dialogContext).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: _isCompleting
                      ? null
                      : () async {
                          setState(() => _isCompleting = true);
                          await _studyVM.completeSession();
                          if (mounted) {
                            Navigator.pop(dialogContext);
                            context.go('/study');
                          }
                        },
                  child: _isCompleting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(l10n.sessionDone),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _resultStat(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ],
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
    final l10n = AppLocalizations.of(context)!;

    return Consumer<StudySessionViewModel>(
      builder: (context, studyVM, _) {
        final session = studyVM.session;

        // Session is null - either loading or completed
        if (session == null) {
          // If there's an error, show error state
          if (studyVM.hasError) {
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(studyVM.error?.userFriendlyMessage ?? l10n.error),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => context.go('/study'),
                      child: Text(l10n.goToStudy),
                    ),
                  ],
                ),
              ),
            );
          }

          // If loading, show progress
          if (studyVM.isLoading) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }

          // Session is null, not loading, no error - completed
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(l10n.sessionFinished),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () => context.go('/study'),
                    child: Text(l10n.goToStudy),
                  ),
                ],
              ),
            ),
          );
        }

        final card = session.currentCard;
        if (card == null) {
          return Scaffold(
            body: Center(
              child: FilledButton(
                onPressed: () => context.go('/study'),
                child: Text(l10n.sessionComplete),
              ),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.flashcardSession),
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
