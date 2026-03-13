# UI Patterns

Widgets must be dumb.

They should:

- render data
- call ViewModel methods
- react to state changes

Do not put business logic inside widgets.

Use:
- ListView.builder
- const widgets where possible
- padding spacing system (8 / 16 / 24)
- Consumer
- context.watch

Avoid:

- deeply nested widgets
- business logic in UI
- StreamBuilder in UI layer

Consumer
Selector
context.watch