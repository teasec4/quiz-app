import 'package:flutter/material.dart';
import 'package:bookexample/core/theme/spacing.dart';
import 'package:bookexample/core/theme/text_styles.dart';

class StatsHeader extends StatelessWidget {
  final int totalLearnedCards;
  final double accuracyRate;
  final int streakDays;

  const StatsHeader({
    super.key,
    required this.totalLearnedCards,
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
                label: 'Learned Cards',
                value: totalLearnedCards.toString(),
              ),
            ),
            AppSpacing.horizontalMd,
            Expanded(
              child: _StatItem(
                label: 'Accuracy Rate',
                value: '${(accuracyRate * 100).toStringAsFixed(0)}%',
              ),
            ),
          ],
        ),
        AppSpacing.verticalLg,
        // Streak Days with stars
        Card(
          elevation: 2,
          child: Padding(
            padding: AppSpacing.cardPadding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Days in a Row', style: context.titleMediumSemiBold),
                AppSpacing.verticalMd,
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ..._buildStarRow(context, streakDays),
                    AppSpacing.horizontalMd,
                    Text(
                      '$streakDays ${streakDays == 1 ? 'day' : 'days'}',
                      style: context.bodyLargeMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<Widget> _buildStarRow(BuildContext context, int filled) {
    const totalStars = 7;
    List<Widget> stars = [];

    for (int i = 0; i < totalStars; i++) {
      stars.add(
        Icon(
          i < filled ? Icons.star : Icons.star_outline,
          color: i < filled
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.outline,
          size: 20,
        ),
      );
      if (i < totalStars - 1) {
        stars.add(AppSpacing.horizontalXs);
      }
    }

    return stars;
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: AppSpacing.cardPadding,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              textAlign: TextAlign.center,
              style: context.titleLargeBold.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            AppSpacing.verticalSm,
            Text(
              label,
              textAlign: TextAlign.center,
              style: context.bodySmall.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
