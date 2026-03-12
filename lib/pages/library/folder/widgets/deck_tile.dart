import 'package:flutter/material.dart';
import 'package:bookexample/core/widgets/context_menu_widget.dart';
import 'package:bookexample/core/theme/text_styles.dart';
import 'package:bookexample/core/theme/color_scheme_extensions.dart';

class DeckTile extends StatelessWidget {
  final String deckName;
  final int cardCount;
  final int learnedCount;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DeckTile({
    super.key,
    required this.deckName,
    required this.cardCount,
    this.learnedCount = 0,
    this.backgroundColor,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  Widget _buildMenuButton(BuildContext context) {
    return ContextMenuWidget.deckPopupMenuButton(
      onEdit: onEdit,
      onDelete: onDelete,
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress = cardCount > 0 ? learnedCount / cardCount : 0.0;

    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              // Menu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: .center,
                children: [
                  Text("${cardCount} cards"),
                  _buildMenuButton(context),
                ],
              ),

              // Deck name
              Text(
                deckName,
                style: context.titleLargeBold.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),

              // Progress bar
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: LinearProgressIndicator(
                      value: progress,
                      minHeight: 6,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.surfaceContainerHighest,
                      valueColor: AlwaysStoppedAnimation(
                        progress < 0.3
                            ? Theme.of(context).colorScheme.warning
                            : progress < 0.7
                            ? Theme.of(context).colorScheme.info
                            : Theme.of(context).colorScheme.success,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$learnedCount/${cardCount}',
                        style: context.bodySmall.copyWith(
                          color: Theme.of(context).colorScheme.textSecondary,
                        ),
                      ),
                      if (progress < 0.3)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.warningContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Needs review',
                            style: context.bodySmall.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onWarningContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else if (progress < 0.7)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.infoContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'In progress',
                            style: context.bodySmall.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onInfoContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.successContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Good progress',
                            style: context.bodySmall.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSuccessContainer,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
