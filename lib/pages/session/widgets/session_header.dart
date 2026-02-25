import 'package:bookexample/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class SessionHeader extends StatelessWidget {
  final int currentIndex;
  final int totalCards;
  final int correctCount;
  final int incorrectCount;
  final Widget Function(String, int, Color) statBoxBuilder;

  const SessionHeader({
    super.key,
    required this.currentIndex,
    required this.totalCards,
    required this.correctCount,
    required this.incorrectCount,
    required this.statBoxBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '${currentIndex + 1}/$totalCards',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
            value: currentIndex / totalCards,
            minHeight: 6,
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: [
              statBoxBuilder(
                '✗',
                incorrectCount,
                Theme.of(context).colorScheme.error,
              ),
              const SizedBox(width: 8),
              statBoxBuilder(
                '✓',
                correctCount,
                Theme.of(context).colorScheme.tertiary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
