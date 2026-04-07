# Project Context

Project: QuizLet

Flashcard learning app built with Flutter.

Main goals:

- efficient flashcard studying
- offline-first storage
- clean architecture
- performant database operations

Core architecture:

UI → ViewModel → Repository → Isar (direct)

Data layer:
- lib/data/models/ - Isar entities (library, session, user_stats)
- lib/data/repositories/ - Repository implementations
- lib/data/isar_db_extension.dart - Database helper methods
- lib/data/db_schema.dart - Database schema

Main features:

- library management
- study sessions
- statistics
- multi-language UI

Important:

- All business logic must live in ViewModels and repositories.
- UI widgets must remain dumb.
- No abstract DataSource layer - repositories use Isar directly.
- ViewModels must not access database directly.
- Do not change navigation or architecture without explicit instruction.