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
  String get editName => 'Edit name';

  @override
  String get done => 'Done';

  @override
  String get confirm => 'Confirm';

  @override
  String get studyTitle => 'Study';

  @override
  String get selectDeck => 'Select a Deck';

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
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count cards',
      one: '1 card',
      zero: 'no cards',
    );
    return '$_temp0';
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
  String folderCreated(String name) {
    return 'Folder \"$name\" created';
  }

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
  String get deleteCardConfirm => 'Are you sure?';

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
  String get sessionComplete => 'Session Complete!';

  @override
  String get greatJob => 'Great job! Keep it up!';

  @override
  String get keepPracticing => 'Keep practicing, you\'ll get better!';

  @override
  String get scoreLabel => 'Score';

  @override
  String get sessionDone => 'Done';

  @override
  String cardsCorrect(int correct, int total) {
    return '$correct of $total cards correct';
  }

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get goToStudy => 'Go to Study';

  @override
  String get sessionFinished => 'Session finished';

  @override
  String get flashcardSession => 'Flashcard Session';

  @override
  String get createDeckTitle => 'Create Deck';

  @override
  String get editDeckTitle => 'Edit Deck';

  @override
  String get saveChanges => 'Save Changes?';

  @override
  String get editMore => 'Edit More';

  @override
  String get deleteCard => 'Delete card?';

  @override
  String get unsavedChanges => 'Unsaved Changes';

  @override
  String get unsavedChangesMessage =>
      'You have unsaved changes. Do you want to leave?';

  @override
  String get stay => 'Stay';

  @override
  String get leave => 'Leave';

  @override
  String get libraryPageTitle => 'Library';

  @override
  String deleteFolderTitle(String folderName) {
    return 'Delete Folder - $folderName?';
  }

  @override
  String get deleteFolderMessage =>
      'This will also delete all decks and cards inside.';

  @override
  String get decksTitle => 'Decks';

  @override
  String get deleteDeckTitle => 'Delete Deck?';

  @override
  String deleteDeckMessage(String deckTitle) {
    return 'All $deckTitle cards will be deleted.';
  }

  @override
  String get startSession => 'Start Session';

  @override
  String get error => 'Error';

  @override
  String get retry => 'Retry';

  @override
  String get loading => 'Loading...';

  @override
  String get studyPageTitle => 'Study';

  @override
  String get statsTitle => 'Stats';

  @override
  String get studyModesTitle => 'Study Modes';

  @override
  String get daysInARow => 'Days in a Row';

  @override
  String get invalidProjectId => 'Invalid project id';

  @override
  String get invalidFolderId => 'Invalid folder id';

  @override
  String get invalidFolderOrDeckId => 'Invalid folder or deck id';

  @override
  String get deckNotFoundTitle => 'Deck not found';

  @override
  String get developerTools => 'Developer Tools';

  @override
  String get startRandom10Cards => 'Start Random 10 Cards';

  @override
  String get quickRandomStudy => 'Quick random study session';

  @override
  String get beginFreshSession => 'Begin a fresh study session';

  @override
  String get matchingMode => 'Matching';

  @override
  String get pairTerms => 'Pair terms';

  @override
  String get testMode => 'Test Mode';

  @override
  String get practiceMode => 'Practice';

  @override
  String get flashcards => 'Flashcards';

  @override
  String get learnWithFlashcards => 'Learn with flashcards';

  @override
  String get multipleChoice => 'Multiple Choice';

  @override
  String get writeAnswer => 'Write Answer';

  @override
  String questionsCount(int count) {
    return '$count questions';
  }

  @override
  String cardNumber(int number) {
    return 'Card $number';
  }

  @override
  String get frontRequired => 'Front required';

  @override
  String get backRequired => 'Back required';

  @override
  String get pasteFromClipboard => 'Paste from clipboard';

  @override
  String get fixValidationErrors => 'Please fix validation errors';

  @override
  String cardValidationError(int number, String error) {
    return 'Card $number: $error';
  }

  @override
  String get fillRequiredFields => 'Please fill all required fields';

  @override
  String get deckSaved => 'Deck saved';

  @override
  String get deckUpdated => 'Deck updated';

  @override
  String get cardDeleted => 'Card deleted';

  @override
  String get deckTitleRequired => 'Deck title is required';

  @override
  String get savingDeck => 'saving deck';

  @override
  String get updatingDeck => 'updating deck';

  @override
  String get deletingCardConfirm => 'Delete card?';

  @override
  String get areYouSure => 'Are you sure?';

  @override
  String get removeThisCard => 'Remove this card';

  @override
  String deckWithCards(String deckName) {
    return 'Deck: $deckName';
  }

  @override
  String cardCountLabel(int count) {
    return 'Cards: $count';
  }

  @override
  String get selectFolder => 'Select a Folder';

  @override
  String get creatingFolder => 'creating folder';

  @override
  String get renamingFolder => 'renaming folder';

  @override
  String get deletingFolder => 'deleting folder';

  @override
  String folderRenamed(String old, String newName) {
    return 'Folder \"$old\" renamed to \"$newName\"';
  }

  @override
  String folderDeleted(String name) {
    return 'Folder \"$name\" deleted';
  }

  @override
  String deckDeleted(String name) {
    return 'Deck \"$name\" deleted';
  }

  @override
  String get createNewFolder => 'Create New Folder';

  @override
  String get renameFolder => 'Rename Folder';

  @override
  String get enterFolderName => 'Enter folder name';

  @override
  String get folderNameRequired => 'Folder name is required';

  @override
  String get needsReview => 'Needs review';

  @override
  String get inProgress => 'In progress';

  @override
  String get goodProgress => 'Good progress';

  @override
  String get deletingDeck => 'deleting deck';

  @override
  String get failedToLoadDeck => 'Failed to load deck';
}
