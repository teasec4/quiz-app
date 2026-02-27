import 'package:flutter/material.dart';

class StatsHeader extends StatelessWidget {
  final int totalCards;
  final double accuracyRate;
  final int streakDays;

  const StatsHeader({
    super.key,
    required this.totalCards,
    required this.accuracyRate,
    required this.streakDays,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Total Cards and Accuracy Rate
          Row(
            children: [
              Expanded(
                child: _StatItem(
                  label: 'Total Cards',
                  value: totalCards.toString(),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatItem(
                  label: 'Accuracy Rate',
                  value: '${accuracyRate.toStringAsFixed(0)}%',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // Streak Days with stars
          Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Days in a Row',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ..._buildStarRow(context, streakDays),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
  }

  List<Widget> _buildStarRow(BuildContext context,int filled) {
    const totalStars = 7;
    List<Widget> stars = [];
    
    for (int i = 0; i < totalStars; i++) {
      stars.add(
        Icon(
          i < filled ? Icons.star : Icons.star_outline,
          color: i < filled ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
          size: 20,
        ),
      );
      if (i < totalStars - 1) {
        stars.add(const SizedBox(width: 4));
      }
    }
    
    return stars;
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
