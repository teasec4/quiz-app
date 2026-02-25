import 'package:bookexample/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

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
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        _showCustomMenu(context, details.globalPosition);
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(Icons.more_horiz, size: 20, color: Colors.grey[600]),
      ),
    );
  }

  void _showCustomMenu(BuildContext context, Offset position) {
    showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, 0),
      items: [
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          height: 40,
          value: 'edit',
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              onEdit?.call();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.edit_outlined, size: 18, color: Colors.grey[700]),
                  const SizedBox(width: 10),
                  const Text('Edit', style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ),
        ),
        PopupMenuItem<String>(
          padding: EdgeInsets.zero,
          height: 40,
          value: 'delete',
          child: InkWell(
            onTap: () {
              Navigator.pop(context);
              onDelete?.call();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: Theme.of(context).colorScheme.error,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Delete',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
      constraints: const BoxConstraints(maxWidth: 160),
      elevation: 2,
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
                style: const TextStyle(
                  color: Colors.black87,
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
                      backgroundColor: Colors.grey[300],
                      valueColor:  AlwaysStoppedAnimation(
                        Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '$learnedCount/${cardCount}',
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
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
