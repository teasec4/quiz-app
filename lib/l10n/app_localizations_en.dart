// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'QuizLet';

  @override
  String get study => 'Study';

  @override
  String get library => 'Library';

  @override
  String get settings => 'Settings';

  @override
  String get stats => 'Statistics';

  @override
  String get back => 'Back';

  @override
  String get next => 'Next';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get done => 'Done';

  @override
  String get confirm => 'Confirm';

  @override
  String get studyTitle => 'Study';

  @override
  String get selectDeck => 'Select Deck';

  @override
  String get noDecksAvailable => 'No decks available';

  @override
  String get startStudySession => 'Start Study Session';

  @override
  String get continueStudy => 'Continue Study';

  @override
  String cardsRemaining(int count) {
    return '$count cards remaining';
  }

  @override
  String get studyComplete => 'Study Complete!';

  @override
  String get correctAnswer => 'Correct';

  @override
  String get incorrectAnswer => 'Incorrect';

  @override
  String get showAnswer => 'Show Answer';

  @override
  String get rateDifficulty => 'Rate Difficulty';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get libraryTitle => 'Library';

  @override
  String get folders => 'Folders';

  @override
  String get decks => 'Decks';

  @override
  String get createFolder => 'Create Folder';

  @override
  String get createDeck => 'Create Deck';

  @override
  String get folderName => 'Folder Name';

  @override
  String get deckName => 'Deck Name';

  @override
  String get deckDescription => 'Description';

  @override
  String cardsCount(int count) {
    return '$count cards';
  }

  @override
  String get addCard => 'Add Card';

  @override
  String get frontSide => 'Front';

  @override
  String get backSide => 'Back';

  @override
  String get tags => 'Tags';

  @override
  String get settingsTitle => 'Settings';

  @override
  String get themeSettings => 'Theme Settings';

  @override
  String get customizeAppearance =>
      'Customize the appearance of the application';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get toggleDarkTheme => 'Toggle dark theme';

  @override
  String get themeVariant => 'Theme Variant';

  @override
  String get minimalTheme => 'Minimal';

  @override
  String get techTheme => 'Tech';

  @override
  String get modernTheme => 'Modern';

  @override
  String get resetToDefaults => 'Reset to Defaults';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get selectAppLanguage => 'Select application language';

  @override
  String get english => 'English';

  @override
  String get russian => 'Russian';

  @override
  String get chinese => 'Chinese';

  @override
  String get resetToEnglish => 'Reset to English';

  @override
  String get resetSettings => 'Reset Settings';

  @override
  String get resetSettingsDescription => 'Reset all settings to default values';

  @override
  String get allSettingsReset => 'All settings reset to defaults';

  @override
  String get resetAllSettings => 'Reset All Settings';

  @override
  String get applicationVersion => 'Application Version';

  @override
  String get statisticsTitle => 'Statistics';

  @override
  String get totalStudyTime => 'Total Study Time';

  @override
  String get cardsStudied => 'Cards Studied';

  @override
  String get accuracyRate => 'Accuracy Rate';

  @override
  String get streak => 'Streak';

  @override
  String get today => 'Today';

  @override
  String get thisWeek => 'This Week';

  @override
  String get thisMonth => 'This Month';

  @override
  String get allTime => 'All Time';

  @override
  String get errorTitle => 'Error';

  @override
  String get unexpectedError => 'An unexpected error occurred';

  @override
  String get networkError => 'Network error. Please check your connection.';

  @override
  String get validationError => 'Please check your input';

  @override
  String get emptyFieldError => 'This field cannot be empty';

  @override
  String get deckNotFound => 'Deck not found';

  @override
  String get folderNotFound => 'Folder not found';

  @override
  String get successTitle => 'Success';

  @override
  String get deckCreated => 'Deck created successfully';

  @override
  String get folderCreated => 'Folder created successfully';

  @override
  String get cardAdded => 'Card added successfully';

  @override
  String get changesSaved => 'Changes saved successfully';

  @override
  String get studySessionSaved => 'Study session saved';

  @override
  String get confirmDelete => 'Confirm Delete';

  @override
  String get deleteDeckConfirm =>
      'Are you sure you want to delete this deck? This action cannot be undone.';

  @override
  String get deleteFolderConfirm =>
      'Are you sure you want to delete this folder? All decks inside will also be deleted.';

  @override
  String get deleteCardConfirm => 'Are you sure you want to delete this card?';

  @override
  String get noFolders => 'No folders yet';

  @override
  String get noDecks => 'No decks yet';

  @override
  String get noCards => 'No cards yet';

  @override
  String get noStudySessions => 'No study sessions yet';

  @override
  String createFirstItem(String item) {
    return 'Create your first $item to get started';
  }

  @override
  String minutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }
}
