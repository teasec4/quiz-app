import 'package:flutter/material.dart';

class StudyMode {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final bool disabled;

  const StudyMode({
    required this.title,
    required this.subtitle,
    required this.icon,
    this.onTap,
    this.disabled = false,
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
      elevation: mode.disabled ? 0 : 2,
      color: mode.disabled ? Colors.grey.shade200 : colorScheme.surfaceContainerLow,
      child: ListTile(
        leading: Icon(
          mode.icon,
          color: mode.disabled ? Colors.grey.shade400 : colorScheme.primary,
          size: 28,
        ),
        title: Text(
          mode.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: mode.disabled ? Colors.grey.shade500 : null,
              ),
        ),
        subtitle: Text(
          mode.subtitle,
          style: TextStyle(
            color: mode.disabled ? Colors.grey.shade400 : null,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: mode.disabled ? Colors.grey.shade400 : null,
        ),
        onTap: mode.disabled ? null : mode.onTap,
      ),
    );
  }
}
