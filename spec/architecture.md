# Architecture

The project follows Clean Architecture.

Layers:

Presentation
- UI Widgets
- ViewModels
- Navigation

Domain
- Entities
- Repository interfaces
- Business rules

Data
- Repository implementations
- Data sources
- Database models

Core
- Utilities
- Extensions
- Logging
- Themes
- Widgets (reusable for main parts)
- Validation
- DI (getIt)