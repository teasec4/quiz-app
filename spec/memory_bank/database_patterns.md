# Database Patterns

Database: Isar

Rules:

- all database operations go through repositories
- never access Isar directly from UI
- use transactions for multi-step operations

Relationships:

Folder → Deck → FlashCard

Cascade deletions must be implemented in repositories.

Streams:

Use Isar watch queries to update UI reactively.