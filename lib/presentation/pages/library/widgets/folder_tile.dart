import 'package:flutter/material.dart';
import 'package:bookexample/core/widgets/context_menu_widget.dart';
import 'package:bookexample/core/theme/spacing.dart';
import 'package:bookexample/core/theme/text_styles.dart';
import 'package:bookexample/core/theme/color_scheme_extensions.dart';

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
      margin: EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: ListTile(
        leading: Icon(
          Icons.folder_outlined,
          size: 32,
          color: Theme.of(context).colorScheme.primary,
        ),
        title: Text(folderName, style: context.bodyLargeMedium),
        // subtitle: Text(
        //   "${deckCount} decks",
        //   style: TextStyle(
        //     fontSize: 14,
        //     color: Theme.of(context).colorScheme.textSecondary,
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
