import 'package:bookexample/l10n/app_localizations.dart';
import 'package:bookexample/presentation/view_models/library_view_model.dart';
import 'package:bookexample/presentation/pages/library/widgets/create_folder_sheet.dart';
import 'package:bookexample/presentation/pages/library/widgets/folder_tile.dart';
import 'package:bookexample/core/widgets/empty_state_widget.dart';
import 'package:bookexample/core/widgets/loading_overlay_widget.dart';
import 'package:bookexample/core/widgets/error_banner_widget.dart';
import 'package:bookexample/core/extensions/snackbar_extensions.dart';
import 'package:bookexample/core/theme/spacing.dart';
import 'package:bookexample/core/theme/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  void _createFolder(BuildContext context, LibraryViewModel vm) async {
    final l10n = AppLocalizations.of(context)!;
    final newFolderName = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => const CreateFolderSheet(),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    if (!context.mounted) return;

    if (newFolderName != null) {
      await vm.createFolder(newFolderName);

      if (!context.mounted) return;

      if (vm.hasError && vm.error != null) {
        context.showOperationErrorSnackBar(
          operation: l10n.creatingFolder,
          error: vm.error!,
          onRetry: () => _createFolder(context, vm),
        );
      } else if (vm.isSuccess) {
        context.showOperationSuccessSnackBar(
          operation: l10n.folderCreated(newFolderName),
        );
        vm.resetSuccess();
      }
    }
  }

  void _renameFolder(
    BuildContext context,
    LibraryViewModel vm,
    int folderId,
    String oldName,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final newFolderName = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => CreateFolderSheet(oldName: oldName),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    if (!context.mounted) return;

    if (newFolderName != null) {
      await vm.renameFolder(folderId, newFolderName);

      if (!context.mounted) return;

      if (vm.hasError && vm.error != null) {
        context.showOperationErrorSnackBar(
          operation: l10n.renamingFolder,
          error: vm.error!,
          onRetry: () => _renameFolder(context, vm, folderId, oldName),
        );
      } else if (vm.isSuccess) {
        context.showOperationSuccessSnackBar(
          operation: l10n.folderRenamed(oldName, newFolderName),
        );
        vm.resetSuccess();
      }
    }
  }

  void _deleteFolder(
    BuildContext context,
    LibraryViewModel vm,
    int folderId,
    String folderName,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    await vm.deleteFolder(folderId);

    if (!context.mounted) return;

    if (vm.hasError && vm.error != null) {
      context.showOperationErrorSnackBar(
        operation: l10n.deletingFolder,
        error: vm.error!,
        onRetry: () => _deleteFolder(context, vm, folderId, folderName),
      );
    } else if (vm.isSuccess) {
      context.showOperationSuccessSnackBar(
        operation: l10n.folderDeleted(folderName),
      );
      vm.resetSuccess();
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    LibraryViewModel vm,
    int folderId,
    String folderName,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.deleteFolderTitle(folderName)),
        content: Text(l10n.deleteFolderMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              _deleteFolder(context, vm, folderId, folderName);
            },
            child: Text(
              l10n.delete,
              style: TextStyle(
                color: Theme.of(dialogContext).colorScheme.error,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<LibraryViewModel>(
      builder: (context, vm, child) {
        final l10n = AppLocalizations.of(context)!;
        return Scaffold(
          appBar: AppBar(title: Text(l10n.library)),
          floatingActionButton: FloatingActionButton(
            onPressed: vm.isLoading ? null : () => _createFolder(context, vm),
            mini: true,
            child: const Icon(Icons.add),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          body: Stack(
            children: [
              _buildFoldersList(context, vm),
              if (vm.isLoading) LoadingOverlayWidget.scrim(opacity: 0.3),
              if (vm.hasError && vm.error != null)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: ErrorBannerWidget.fromError(
                    error: vm.error!,
                    onClose: vm.clearError,
                    onTap: () {},
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFoldersList(BuildContext context, LibraryViewModel vm) {
    final l10n = AppLocalizations.of(context)!;
    final folders = vm.folders;
    return folders.isEmpty
        ? EmptyStateWidget.folders()
        : Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: AppSpacing.screenPadding,
                  child: Text(l10n.folders, style: context.titleLargeBold),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    final folder = folders[index];
                    return FolderTile(
                      folderName: folder.name,
                      onTap: () => context.go('/library/folder/${folder.id}'),
                      onDelete: () => _showDeleteConfirmation(
                        context,
                        vm,
                        folder.id,
                        folder.name,
                      ),
                      onEdit: () =>
                          _renameFolder(context, vm, folder.id, folder.name),
                    );
                  },
                ),
              ),
            ],
          );
  }
}
