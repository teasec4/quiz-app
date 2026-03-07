import 'package:flutter/material.dart';
import 'package:bookexample/l10n/app_localizations.dart';

class AppBottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.school_outlined),
          selectedIcon: const Icon(Icons.school),
          label: l10n?.study ?? 'Study',
        ),
        NavigationDestination(
          icon: const Icon(Icons.library_books_outlined),
          selectedIcon: const Icon(Icons.library_books),
          label: l10n?.library ?? 'Library',
        ),
        NavigationDestination(
          icon: const Icon(Icons.settings_outlined),
          selectedIcon: const Icon(Icons.settings),
          label: l10n?.settings ?? 'Settings',
        ),
      ],
    );
  }
}
