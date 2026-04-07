# Architecture Patterns

The project follows Clean Architecture.

Layers:

Presentation (lib/presentation/)
- pages/
- widgets/
- view_models/
- router/

Domain (lib/domain/)
- repositories/ - Repository interfaces only
- base_repository.dart - Base class for all repositories

Data (lib/data/)
- models/ - Isar entities (library/, session/, user_stats/)
- repositories/ - Repository implementations
- isar_db_extension.dart - Database helper methods
- db_schema.dart - Database schema

Core (lib/core/)
- di/ - Dependency injection (service_locator.dart)
- theme/, widgets/, validation/, extensions/, logging/

Dependency rule:

UI depends on ViewModels  
ViewModels depend on repositories (interfaces)  
Repositories (implementations) depend on Isar directly

UI must never access database directly.
ViewModels must not access database directly - use repositories.