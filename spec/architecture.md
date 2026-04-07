# Architecture

The project follows Clean Architecture.

Layers:

Presentation
- UI Widgets
- ViewModels
- Navigation (router)
- Pages

Domain
- Repository interfaces
- Business rules (base_repository.dart)

Data
- Repository implementations
- Isar database (direct usage, no abstraction layer)
- Data models (Isar entities)
- Extensions (isar_db_extension.dart)

Core
- Utilities
- Extensions
- Logging
- Themes
- Widgets (reusable for main parts)
- Validation
- DI (service_locator in core/di/)