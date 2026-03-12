# Architecture Patterns

The project follows Clean Architecture.

Layers:

Presentation
- pages
- widgets
- view models

Domain
- entities
- repository interfaces

Data
- repository implementations
- data sources

Dependency rule:

UI depends on ViewModels  
ViewModels depend on repositories  
Repositories depend on data sources

UI must never access database directly.