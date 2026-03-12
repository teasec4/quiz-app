import 'package:bookexample/view_models/library_view_model.dart';
import 'package:bookexample/pages/library/widgets/create_folder_sheet.dart';
import 'package:bookexample/pages/library/widgets/folder_tile.dart';
import 'package:bookexample/core/widgets/empty_state_widget.dart';
import 'package:bookexample/core/widgets/loading_overlay_widget.dart';
import 'package:bookexample/core/extensions/snackbar_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class LibraryPage extends StatefulWidget {
  const LibraryPage({super.key});

  @override
  State<LibraryPage> createState() => _LibraryPageState();
}

class _LibraryPageState extends State<LibraryPage> {
  @override
  void initState() {
    super.initState();
  }

  // creating folder bottom sheet
  Future<void> _showCreateFolder(BuildContext context) async {
    final newFolderName = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => const CreateFolderSheet(),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    // avoid async gap
    if (!context.mounted) return;

    if (newFolderName != null) {
      final vm = context.read<LibraryViewModel>();
      await vm.createFolder(newFolderName);

      if (!context.mounted) return;

      if (vm.hasError && vm.error != null) {
        context.showOperationErrorSnackBar(
          operation: 'creating folder',
          error: vm.error!,
          onRetry: () => _showCreateFolder(context),
        );
      } else if (vm.isSuccess) {
        context.showOperationSuccessSnackBar(
          operation: 'Folder "$newFolderName" created',
        );
        vm.resetSuccess();
      }
    }
  }

  // rename folder bottom sheet
  Future<void> _showRenameFolder(
    BuildContext context,
    int folderId,
    String oldName,
  ) async {
    final newFolderName = await showModalBottomSheet<String?>(
      context: context,
      builder: (context) => CreateFolderSheet(oldName: oldName),
      isScrollControlled: true,
      useRootNavigator: true,
    );

    // avoid async gap
    if (!context.mounted) return;

    if (newFolderName != null) {
      final vm = context.read<LibraryViewModel>();
      await vm.renameFolder(folderId, newFolderName);

      if (!context.mounted) return;

      if (vm.hasError && vm.error != null) {
        context.showOperationErrorSnackBar(
          operation: 'renaming folder',
          error: vm.error!,
          onRetry: () => _showRenameFolder(context, folderId, oldName),
        );
      } else if (vm.isSuccess) {
        context.showOperationSuccessSnackBar(
          operation: 'Folder "$oldName" renamed to "$newFolderName"',
        );
        vm.resetSuccess();
      }
    }
  }

  void _showDeleteConfirmation(
    BuildContext context,
    int folderId,
    String folderName,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Folder - $folderName?'),
        content: const Text(
          'This will also delete all decks and cards inside.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final vm = context.read<LibraryViewModel>();
              await vm.deleteFolder(folderId);

              if (context.mounted) {
                Navigator.pop(context);

                if (vm.hasError && vm.error != null) {
                  context.showOperationErrorSnackBar(
                    operation: 'deleting folder',
                    error: vm.error!,
                    onRetry: () =>
                        _showDeleteConfirmation(context, folderId, folderName),
                  );
                } else if (vm.isSuccess) {
                  context.showOperationSuccessSnackBar(
                    operation: 'Folder "$folderName" deleted',
                  );
                  vm.resetSuccess();
                }
              }
            },
            child: Text(
              'Delete',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LibraryViewModel>();
    return Scaffold(
      appBar: AppBar(title: const Text("Library")),
      floatingActionButton: FloatingActionButton(
        onPressed: vm.isLoading
            ? null
            : () {
                _showCreateFolder(context);
              },
        mini: true,
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Stack(
        children: [
          _buildFoldersList(context, vm),
          if (vm.isLoading) LoadingOverlayWidget.scrim(opacity: 0.3),
        ],
      ),
    );
  }

  Widget _buildFoldersList(BuildContext context, LibraryViewModel vm) {
    final folders = vm.folders;
    return folders.isEmpty
        ? _buildEmptyState(context)
        : Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Folders',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: folders.length,
                  itemBuilder: (context, index) {
                    final folder = folders[index];

                    return FolderTile(
                      folderName: folder.name,
                      // deckCount: folder.decks.length,
                      onTap: () {
                        context.go('/library/folder/${folder.id}');
                      },
                      onDelete: () {
                        _showDeleteConfirmation(
                          context,
                          folder.id,
                          folder.name,
                        );
                      },
                      onEdit: () {
                        _showRenameFolder(context, folder.id, folder.name);
                      },
                    );
                  },
                ),
              ),
            ],
          );
  }

  Widget _buildEmptyState(BuildContext context) {
    return EmptyStateWidget.folders();
  }
}
