# Active Task

ID: TASK-001

## Context

Currently the UI listens directly to database streams using `StreamBuilder`.

Example flow:

Isar Stream → UI (StreamBuilder) → Render

This violates the intended architecture, where the UI should only observe the ViewModel.

The ViewModel (`LibraryViewModel`) already exposes methods:

- watchFolders()
- watchDecksByFolder(int folderId)

But currently the UI is responsible for handling the streams.

## Goal

Move all database stream subscriptions into `LibraryViewModel`.

The ViewModel should listen to repository streams, update its internal state, and notify the UI using `notifyListeners()`.

After the change, the UI must only read lists from the ViewModel.

New flow:

Isar Stream → ViewModel → notifyListeners() → UI

