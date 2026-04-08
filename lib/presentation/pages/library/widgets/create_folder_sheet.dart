import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bookexample/l10n/app_localizations.dart';
import 'package:bookexample/core/theme/spacing.dart';
import 'package:bookexample/core/theme/text_styles.dart';

class CreateFolderSheet extends StatefulWidget {
  final String? oldName;
  const CreateFolderSheet({super.key, this.oldName});

  @override
  State<CreateFolderSheet> createState() => _CreateFolderSheetState();
}

class _CreateFolderSheetState extends State<CreateFolderSheet> {
  late TextEditingController _nameController;
  late FocusNode _folderNameFocus;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.oldName ?? "");
    _folderNameFocus = FocusNode();
    _nameController.addListener(() {
      setState(() {
        _hasError = false;
      });
    });

    // Request focus after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _folderNameFocus.requestFocus();
      // Select all text if editing
      if (widget.oldName != null) {
        _nameController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: _nameController.text.length,
        );
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _folderNameFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.lg,
          // тут вопрос нужно ли это еще ??
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.outlineVariant,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                shape: BoxShape.circle,
              ),
              child: Icon(
                widget.oldName != null
                    ? Icons.edit_outlined
                    : Icons.create_new_folder_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.oldName != null ? l10n.renameFolder : l10n.createNewFolder,
              style: context.titleLargeBold,
              textAlign: TextAlign.center,
            ),
            AppSpacing.verticalLg,
            TextField(
              focusNode: _folderNameFocus,
              controller: _nameController,
              style: context.bodyLargeMedium,
              decoration: InputDecoration(
                hintText: l10n.enterFolderName,
                labelText: l10n.folderName,
                labelStyle: context.titleSmall,
                prefixIcon: Icon(
                  Icons.folder,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                errorText: _hasError ? l10n.folderNameRequired : null,
                filled: true,
                fillColor: Theme.of(
                  context,
                ).colorScheme.primaryContainer.withValues(alpha: 0.25),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                border: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide(
                    color: _hasError
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(
                            context,
                          ).colorScheme.primaryContainer.withValues(alpha: 0.5),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: AppSpacing.borderRadiusMd,
                  borderSide: BorderSide(
                    color: _hasError
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primary,
                    width: 2.5,
                  ),
                ),
              ),
              textInputAction: TextInputAction.done,
              onSubmitted: (_) {
                if (_nameController.text.trim().isEmpty) {
                  setState(() {
                    _hasError = true;
                  });
                  return;
                }
                context.pop(_nameController.text);
              },
            ),
            AppSpacing.verticalLg,
            Row(
              children: [
                // cancel modal
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                    ),
                    child: Text(
                      l10n.cancel,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
                AppSpacing.horizontalMd,
                // create a new folder
                Expanded(
                  child: FilledButton(
                    onPressed: () {
                      if (_nameController.text.trim().isEmpty) {
                        setState(() {
                          _hasError = true;
                        });
                        return;
                      }
                      context.pop(_nameController.text);
                    },
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      widget.oldName != null ? l10n.save : l10n.createFolder,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
