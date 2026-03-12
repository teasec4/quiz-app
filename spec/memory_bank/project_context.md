# Project Context

Project: QuizLet

Flashcard learning app built with Flutter.

Main goals:

- efficient flashcard studying
- offline-first storage
- clean architecture
- performant database operations

Core architecture:

UI → ViewModel → Repository → Isar

Main features:

- library management
- study sessions
- statistics
- multi-language UI

Important:

All business logic must live in ViewModels and repositories.
UI widgets must remain dumb.