import 'package:flutter/material.dart';

class StudyMode {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  const StudyMode({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
  });
}

class ModeTile extends StatelessWidget {
  final StudyMode mode;

  const ModeTile({
    super.key,
    required this.mode
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      color: colorScheme.surfaceContainerLow,
      child: ListTile(
        leading: Icon(mode.icon, color: colorScheme.primary, size: 28),
        title: Text(mode.title, style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(mode.subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: mode.onTap,
      ),
    );
  }
}
