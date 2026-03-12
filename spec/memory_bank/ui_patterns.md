# UI Patterns

Widgets must be dumb.

They should:

- render data
- call ViewModel methods
- react to state changes

Do not put business logic inside widgets.

Use:

Consumer
Selector
context.watch