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
      color: disabled ? Colors.grey.shade200 : null,
      child: ListTile(
        iconColor: disabled
            ? Colors.grey.shade400
            : Theme.of(context).colorScheme.secondary,
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: disabled ? Colors.grey.shade500 : null,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: disabled ? Colors.grey.shade400 : null,
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: disabled ? Colors.grey.shade400 : null,
        ),
        onTap: disabled ? null : onTap,
      ),
    );
  }
}

