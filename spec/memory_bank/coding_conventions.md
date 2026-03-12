# Coding Conventions

General rules:

- prefer small classes
- avoid god objects
- functions should do one thing

Naming:

ViewModel classes end with "ViewModel"

Repositories end with "Repository"

Database entities end with "Entity"

Async operations:

All async operations in ViewModels must use executeAsync().