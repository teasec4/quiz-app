import 'package:flutter/material.dart';
import 'package:bookexample/core/widgets/context_menu_widget.dart';

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
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
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
                      ).colorScheme.secondaryContainer,
                      valueColor: AlwaysStoppedAnimation(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$learnedCount/${cardCount}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
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
