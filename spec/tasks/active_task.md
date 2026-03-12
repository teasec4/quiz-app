# Active Task

ID: TASK-001

Feature: Study Session

Description:

Load cards from a deck to start a study session.

Requirements:

- cards must be loaded from FlashCardEntity
- only cards belonging to selected deck
- cards must be shuffled

Files involved:

- study_session_view_model.dart
- library_repository.dart

Output:

A method:

loadCardsForSession(int deckId)