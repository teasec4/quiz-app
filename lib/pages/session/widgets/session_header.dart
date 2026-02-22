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
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${currentIndex + 1}/$totalCards',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  statBoxBuilder('✓', correctCount, Colors.green),
                  const SizedBox(width: 8),
                  statBoxBuilder('✗', incorrectCount, Colors.red),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          LinearProgressIndicator(
            value: currentIndex / totalCards,
            minHeight: 6,
          ),
        ],
      ),
    );
  }
}
