# State Management

State management uses Provider + ChangeNotifier.

Pattern:

Page → ViewModel

ViewModels extend BaseViewModel.

ViewState enum:

idle
loading
success
error

Rules:

- ViewModels must not contain UI logic
- UI observes ViewModel state
- errors must be exposed through ViewState