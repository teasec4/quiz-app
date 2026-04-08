import 'package:flutter/material.dart';

class ModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool disabled;

  const ModeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.disabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: disabled ? 0 : 2,
      color: disabled
          ? Theme.of(context).colorScheme.surfaceContainerHighest
          : Theme.of(context).colorScheme.surfaceContainerLow,
      child: ListTile(
        iconColor: disabled
            ? Theme.of(context).colorScheme.onSurfaceVariant
            : Theme.of(context).colorScheme.primary,
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: disabled
                ? Theme.of(
                    context,
                  ).colorScheme.onSurfaceVariant.withValues(alpha: 0.7)
                : null,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: disabled
                ? Theme.of(context).colorScheme.onSurfaceVariant
                : null,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: disabled
              ? Theme.of(context).colorScheme.onSurfaceVariant
              : null,
        ),
        onTap: disabled ? null : onTap,
      ),
    );
  }
}
