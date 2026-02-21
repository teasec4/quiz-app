import 'package:bookexample/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FolderTile extends StatelessWidget {
  final String folderName;
  final int itemCount;
  final VoidCallback? onTap;

  const FolderTile({
    super.key,
    required this.folderName,
    this.itemCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: const Icon(
          Icons.folder_outlined,
          size: 32,
          color: AppColors.brandPrimary,
        ),
        title: Text(
          folderName,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        subtitle: Text(
          itemCount == 1 ? '1 item' : '$itemCount items',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        onTap: onTap,
      ),
    );
  }
}
