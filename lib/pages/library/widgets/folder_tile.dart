import 'package:flutter/material.dart';
import 'package:bookexample/core/widgets/context_menu_widget.dart';

class FolderTile extends StatelessWidget {
  final String folderName;
  // final int deckCount;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const FolderTile({
    super.key,
    required this.folderName,
    // required this.deckCount,
    this.onTap,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Icon(
          Icons.folder_outlined,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(
          folderName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        // subtitle: Text(
        //   "${deckCount} decks",
        //   style: TextStyle(
        //     fontSize: 14,
        //     color: Theme.of(context).colorScheme.onSurfaceVariant,
        //   ),
        // ),
        trailing: ContextMenuWidget.folderPopupMenuButton(
          onEdit: onEdit,
          onDelete: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
