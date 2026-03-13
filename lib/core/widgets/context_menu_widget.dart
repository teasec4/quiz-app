import 'package:flutter/material.dart';
import 'package:bookexample/core/theme/color_scheme_extensions.dart';

/// A universal context menu widget for folder and deck tiles.
/// Provides consistent menu styling and behavior across the app.
class ContextMenuWidget {
  /// Shows a context menu for folder operations.
  static Future<void> showFolderMenu({
    required BuildContext context,
    required Offset position,
    required VoidCallback onEdit,
    required VoidCallback onDelete,
  }) async {
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, 0),
      items: [
        _buildMenuItem(
          context: context,
          value: 'edit',
          icon: Icons.edit_outlined,
          label: 'Edit name',
          iconColor: Theme.of(context).colorScheme.textSecondary,
          textColor: Theme.of(context).colorScheme.textPrimary,
        ),
        _buildMenuItem(
          context: context,
          value: 'delete',
          icon: Icons.delete_outline,
          label: 'Delete',
          iconColor: Theme.of(context).colorScheme.error,
          textColor: Theme.of(context).colorScheme.error,
        ),
      ],
      constraints: const BoxConstraints(minWidth: 160),
      elevation: 2,
    );

    _handleMenuResult(context, result, onEdit, onDelete);
  }

  /// Shows a context menu for deck operations.
  static Future<void> showDeckMenu({
    required BuildContext context,
    required Offset position,
    required VoidCallback? onEdit,
    required VoidCallback? onDelete,
  }) async {
    final result = await showMenu<String>(
      context: context,
      position: RelativeRect.fromLTRB(position.dx, position.dy, position.dx, 0),
      items: [
        if (onEdit != null)
          _buildMenuItem(
            context: context,
            value: 'edit',
            icon: Icons.edit_outlined,
            label: 'Edit',
            iconColor: Theme.of(context).colorScheme.textSecondary,
            textColor: Theme.of(context).colorScheme.textPrimary,
            fontSize: 14,
            iconSize: 18,
          ),
        if (onDelete != null)
          _buildMenuItem(
            context: context,
            value: 'delete',
            icon: Icons.delete_outline,
            label: 'Delete',
            iconColor: Theme.of(context).colorScheme.error,
            textColor: Theme.of(context).colorScheme.error,
            fontSize: 14,
            iconSize: 18,
          ),
      ].whereType<PopupMenuItem<String>>().toList(),
      constraints: const BoxConstraints(minWidth: 160),
      elevation: 2,
    );

    _handleMenuResult(context, result, onEdit, onDelete);
  }

  /// Builds a standardized menu item with consistent styling.
  static PopupMenuItem<String> _buildMenuItem({
    required BuildContext context,
    required String value,
    required IconData icon,
    required String label,
    required Color iconColor,
    required Color textColor,
    double fontSize = 14,
    double iconSize = 20,
    double horizontalPadding = 12,
    double iconSpacing = 12,
  }) {
    return PopupMenuItem<String>(
      value: value,
      padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
      height: 40,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: iconColor),
          SizedBox(width: iconSpacing),
          Text(
            label,
            style: TextStyle(fontSize: fontSize, color: textColor),
          ),
        ],
      ),
    );
  }

  /// Handles the menu result and calls the appropriate callback.
  static void _handleMenuResult(
    BuildContext context,
    String? result,
    VoidCallback? onEdit,
    VoidCallback? onDelete,
  ) {
    if (result == null) return;

    switch (result) {
      case 'edit':
        onEdit?.call();
        break;
      case 'delete':
        onDelete?.call();
        break;
    }
  }

  /// Creates a menu button widget for use in ListTile trailing.
  static Widget menuButton({
    required BuildContext context,
    required VoidCallback onPressed,
    double size = 20,
    Color? color,
  }) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        onPressed();
      },
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(
          Icons.more_horiz,
          size: size,
          color: color ?? Theme.of(context).colorScheme.textSecondary,
        ),
      ),
    );
  }

  /// Creates a standard PopupMenuButton for folder tiles.
  static PopupMenuButton folderPopupMenuButton({
    required VoidCallback? onEdit,
    required VoidCallback? onDelete,
  }) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        if (onEdit != null)
          PopupMenuItem(
            onTap: onEdit,
            child: Row(
              children: [
                Icon(
                  Icons.edit_outlined,
                  size: 20,
                  color: Theme.of(context).colorScheme.textSecondary,
                ),
                const SizedBox(width: 12),
                Text(
                  'Edit name',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.textPrimary,
                  ),
                ),
              ],
            ),
          ),
        if (onDelete != null)
          PopupMenuItem(
            onTap: onDelete,
            child: Row(
              children: [
                Icon(
                  Icons.delete_outline,
                  size: 20,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(width: 12),
                Text(
                  'Delete',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
            ),
          ),
      ],
    );
  }

  /// Creates a standard PopupMenuButton for deck tiles.
  static PopupMenuButton deckPopupMenuButton({
    required VoidCallback? onEdit,
    required VoidCallback? onDelete,
  }) {
    return PopupMenuButton(
      itemBuilder: (context) {
        final items = <PopupMenuItem>[];

        if (onEdit != null) {
          items.add(
            PopupMenuItem(
              onTap: onEdit,
              child: Row(
                children: [
                  Icon(
                    Icons.edit_outlined,
                    size: 18,
                    color: Theme.of(context).colorScheme.textSecondary,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Edit',
                    style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context).colorScheme.textPrimary,
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        if (onDelete != null) {
          items.add(
            PopupMenuItem(
              onTap: onDelete,
              child: Row(
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
          );
        }

        return items;
      },
    );
  }
}
