import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateFolderSheet extends StatefulWidget {
  final String? oldName;
  const CreateFolderSheet({super.key,this.oldName});

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
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.oldName != null ? "Rename Folder" : 
              'Create New Folder',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              focusNode: _folderNameFocus,
              controller: _nameController,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              decoration: InputDecoration(
                hintText: 'Enter folder name',
                labelText: 'Folder Name',
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                prefixIcon: Icon(
                  Icons.folder,
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                errorText: _hasError ? 'Folder name is required' : null,
                filled: true,
                fillColor: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.25),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: _hasError
                        ? Theme.of(context).colorScheme.error
                        : Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
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
            const SizedBox(height: 20),
            Row(
              children: [
                // cancel modal
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => context.pop(),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(color: Colors.black87),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                // create a new folder
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_nameController.text.trim().isEmpty) {
                        setState(() {
                          _hasError = true;
                        });
                        return;
                      }
                      context.pop(_nameController.text);
                    },
                    child: Text(widget.oldName != null ? 'Rename' : 'Create'),
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
