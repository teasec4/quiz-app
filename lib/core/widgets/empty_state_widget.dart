import 'package:flutter/material.dart';

/// A reusable widget for displaying empty states with an icon, title, and optional subtitle.
class EmptyStateWidget extends StatelessWidget {
  /// The icon to display
  final IconData icon;

  /// The main title text
  final String title;

  /// Optional subtitle text
  final String? subtitle;

  /// Size of the icon
  final double iconSize;

  /// Color of the icon. If null, uses Theme.of(context).colorScheme.onSurfaceVariant
  final Color? iconColor;

  /// Color of the title text. If null, uses Theme.of(context).colorScheme.onSurface
  final Color? titleColor;

  /// Color of the subtitle text. If null, uses Theme.of(context).colorScheme.onSurfaceVariant
  final Color? subtitleColor;

  /// Font size of the title
  final double titleFontSize;

  /// Font weight of the title
  final FontWeight titleFontWeight;

  /// Font size of the subtitle
  final double subtitleFontSize;

  /// Spacing between icon and title
  final double iconTitleSpacing;

  /// Spacing between title and subtitle
  final double titleSubtitleSpacing;

  /// Main axis alignment of the column
  final MainAxisAlignment mainAxisAlignment;

  /// Cross axis alignment of the column
  final CrossAxisAlignment crossAxisAlignment;

  /// Creates an EmptyStateWidget
  const EmptyStateWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.iconSize = 64.0,
    this.iconColor,
    this.titleColor,
    this.subtitleColor,
    this.titleFontSize = 18.0,
    this.titleFontWeight = FontWeight.w500,
    this.subtitleFontSize = 14.0,
    this.iconTitleSpacing = 16.0,
    this.titleSubtitleSpacing = 8.0,
    this.mainAxisAlignment = MainAxisAlignment.center,
    this.crossAxisAlignment = CrossAxisAlignment.center,
  });

  /// Creates an EmptyStateWidget for folders
  factory EmptyStateWidget.folders({
    Key? key,
    String title = 'No folders yet',
    String? subtitle = 'Tap + to create your first folder',
    double iconSize = 64.0,
  }) {
    return EmptyStateWidget(
      key: key,
      icon: Icons.folder_open,
      title: title,
      subtitle: subtitle,
      iconSize: iconSize,
    );
  }

  /// Creates an EmptyStateWidget for decks
  factory EmptyStateWidget.decks({
    Key? key,
    String title = 'No Decks yet',
    String? subtitle = 'Tap + to create your first decks',
    double iconSize = 64.0,
  }) {
    return EmptyStateWidget(
      key: key,
      icon: Icons.card_giftcard,
      title: title,
      subtitle: subtitle,
      iconSize: iconSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: mainAxisAlignment,
        crossAxisAlignment: crossAxisAlignment,
        children: [
          Icon(
            icon,
            size: iconSize,
            color: iconColor ?? colorScheme.onSurfaceVariant,
          ),
          SizedBox(height: iconTitleSpacing),
          Text(
            title,
            style: TextStyle(
              fontSize: titleFontSize,
              fontWeight: titleFontWeight,
              color: titleColor ?? colorScheme.onSurface,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: titleSubtitleSpacing),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: subtitleFontSize,
                color: subtitleColor ?? colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
