import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
    Locale('zh'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'QuizLet'**
  String get appTitle;

  /// Study tab label
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get study;

  /// Library tab label
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get library;

  /// Settings tab label
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Statistics tab label
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats;

  /// Back button label
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Next button label
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// Save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Delete button label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// Edit button label
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// Edit name option
  ///
  /// In en, this message translates to:
  /// **'Edit name'**
  String get editName;

  /// Done button label
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get done;

  /// Confirm button label
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// Study page title
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get studyTitle;

  /// Select deck prompt
  ///
  /// In en, this message translates to:
  /// **'Select a Deck'**
  String get selectDeck;

  /// Message when no decks are available for study
  ///
  /// In en, this message translates to:
  /// **'No decks available'**
  String get noDecksAvailable;

  /// Start study session button
  ///
  /// In en, this message translates to:
  /// **'Start Study Session'**
  String get startStudySession;

  /// Continue study button
  ///
  /// In en, this message translates to:
  /// **'Continue Study'**
  String get continueStudy;

  /// Number of cards remaining in study session
  ///
  /// In en, this message translates to:
  /// **'{count} cards remaining'**
  String cardsRemaining(int count);

  /// Study session completion message
  ///
  /// In en, this message translates to:
  /// **'Study Complete!'**
  String get studyComplete;

  /// Correct answer label
  ///
  /// In en, this message translates to:
  /// **'Correct'**
  String get correctAnswer;

  /// Incorrect answer label
  ///
  /// In en, this message translates to:
  /// **'Incorrect'**
  String get incorrectAnswer;

  /// Show answer button
  ///
  /// In en, this message translates to:
  /// **'Show Answer'**
  String get showAnswer;

  /// Rate difficulty prompt
  ///
  /// In en, this message translates to:
  /// **'Rate Difficulty'**
  String get rateDifficulty;

  /// Easy difficulty rating
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// Medium difficulty rating
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// Hard difficulty rating
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// Library page title
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryTitle;

  /// Folders section title
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get folders;

  /// Decks section title
  ///
  /// In en, this message translates to:
  /// **'Decks'**
  String get decks;

  /// Create folder button
  ///
  /// In en, this message translates to:
  /// **'Create Folder'**
  String get createFolder;

  /// Create deck button
  ///
  /// In en, this message translates to:
  /// **'Create Deck'**
  String get createDeck;

  /// Folder name label
  ///
  /// In en, this message translates to:
  /// **'Folder Name'**
  String get folderName;

  /// Deck name input label
  ///
  /// In en, this message translates to:
  /// **'Deck Name'**
  String get deckName;

  /// Deck description input label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get deckDescription;

  /// Number of cards in deck
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{no cards} =1{1 card} other{{count} cards}}'**
  String cardsCount(int count);

  /// Add card button
  ///
  /// In en, this message translates to:
  /// **'Add Card'**
  String get addCard;

  /// Front side of flashcard
  ///
  /// In en, this message translates to:
  /// **'Front'**
  String get frontSide;

  /// Back side of flashcard
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get backSide;

  /// Tags input label
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// Settings page title
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Theme settings section title
  ///
  /// In en, this message translates to:
  /// **'Theme Settings'**
  String get themeSettings;

  /// Theme settings description
  ///
  /// In en, this message translates to:
  /// **'Customize the appearance of the application'**
  String get customizeAppearance;

  /// Dark mode toggle label
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// Dark mode toggle description
  ///
  /// In en, this message translates to:
  /// **'Toggle dark theme'**
  String get toggleDarkTheme;

  /// Theme variant selection label
  ///
  /// In en, this message translates to:
  /// **'Theme Variant'**
  String get themeVariant;

  /// Minimal theme name
  ///
  /// In en, this message translates to:
  /// **'Minimal'**
  String get minimalTheme;

  /// Tech theme name
  ///
  /// In en, this message translates to:
  /// **'Tech'**
  String get techTheme;

  /// Modern theme name
  ///
  /// In en, this message translates to:
  /// **'Modern'**
  String get modernTheme;

  /// Reset settings button
  ///
  /// In en, this message translates to:
  /// **'Reset to Defaults'**
  String get resetToDefaults;

  /// Language settings section title
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// Language settings description
  ///
  /// In en, this message translates to:
  /// **'Select application language'**
  String get selectAppLanguage;

  /// English language name
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// Russian language name
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// Chinese language name
  ///
  /// In en, this message translates to:
  /// **'Chinese'**
  String get chinese;

  /// Reset language to English button
  ///
  /// In en, this message translates to:
  /// **'Reset to English'**
  String get resetToEnglish;

  /// Application version label
  ///
  /// In en, this message translates to:
  /// **'Application Version'**
  String get applicationVersion;

  /// Statistics page title
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statisticsTitle;

  /// Total study time label
  ///
  /// In en, this message translates to:
  /// **'Total Study Time'**
  String get totalStudyTime;

  /// Cards studied label
  ///
  /// In en, this message translates to:
  /// **'Cards Studied'**
  String get cardsStudied;

  /// Accuracy rate label
  ///
  /// In en, this message translates to:
  /// **'Accuracy Rate'**
  String get accuracyRate;

  /// Study streak label
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streak;

  /// Today time period
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// This week time period
  ///
  /// In en, this message translates to:
  /// **'This Week'**
  String get thisWeek;

  /// This month time period
  ///
  /// In en, this message translates to:
  /// **'This Month'**
  String get thisMonth;

  /// All time period
  ///
  /// In en, this message translates to:
  /// **'All Time'**
  String get allTime;

  /// Error dialog title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorTitle;

  /// Generic error message
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred'**
  String get unexpectedError;

  /// Network error message
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection.'**
  String get networkError;

  /// Validation error message
  ///
  /// In en, this message translates to:
  /// **'Please check your input'**
  String get validationError;

  /// Empty field error message
  ///
  /// In en, this message translates to:
  /// **'This field cannot be empty'**
  String get emptyFieldError;

  /// Deck not found error
  ///
  /// In en, this message translates to:
  /// **'Deck not found'**
  String get deckNotFound;

  /// Folder not found error
  ///
  /// In en, this message translates to:
  /// **'Folder not found'**
  String get folderNotFound;

  /// Success dialog title
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get successTitle;

  /// Deck creation success message
  ///
  /// In en, this message translates to:
  /// **'Deck created successfully'**
  String get deckCreated;

  /// Folder created message
  ///
  /// In en, this message translates to:
  /// **'Folder \"{name}\" created'**
  String folderCreated(String name);

  /// Card addition success message
  ///
  /// In en, this message translates to:
  /// **'Card added successfully'**
  String get cardAdded;

  /// Changes saved success message
  ///
  /// In en, this message translates to:
  /// **'Changes saved successfully'**
  String get changesSaved;

  /// Study session saved message
  ///
  /// In en, this message translates to:
  /// **'Study session saved'**
  String get studySessionSaved;

  /// Delete confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Confirm Delete'**
  String get confirmDelete;

  /// Delete deck confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this deck? This action cannot be undone.'**
  String get deleteDeckConfirm;

  /// Delete folder confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this folder? All decks inside will also be deleted.'**
  String get deleteFolderConfirm;

  /// Delete card confirmation
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get deleteCardConfirm;

  /// Empty folders state message
  ///
  /// In en, this message translates to:
  /// **'No folders yet'**
  String get noFolders;

  /// Empty decks state message
  ///
  /// In en, this message translates to:
  /// **'No decks yet'**
  String get noDecks;

  /// Empty cards state message
  ///
  /// In en, this message translates to:
  /// **'No cards yet'**
  String get noCards;

  /// Empty study sessions state message
  ///
  /// In en, this message translates to:
  /// **'No study sessions yet'**
  String get noStudySessions;

  /// Create first item prompt
  ///
  /// In en, this message translates to:
  /// **'Create your first {item} to get started'**
  String createFirstItem(String item);

  /// Time format for minutes ago
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String minutesAgo(int count);

  /// Time format for hours ago
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String hoursAgo(int count);

  /// Session complete dialog title
  ///
  /// In en, this message translates to:
  /// **'Session Complete!'**
  String get sessionComplete;

  /// Motivational message for good score
  ///
  /// In en, this message translates to:
  /// **'Great job! Keep it up!'**
  String get greatJob;

  /// Motivational message for low score
  ///
  /// In en, this message translates to:
  /// **'Keep practicing, you\'ll get better!'**
  String get keepPracticing;

  /// Score label in session complete dialog
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get scoreLabel;

  /// Done button in session complete dialog
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get sessionDone;

  /// Cards correct summary
  ///
  /// In en, this message translates to:
  /// **'{correct} of {total} cards correct'**
  String cardsCorrect(int correct, int total);

  /// Time format for days ago
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(int count);

  /// Button to navigate to study page
  ///
  /// In en, this message translates to:
  /// **'Go to Study'**
  String get goToStudy;

  /// Message when session is finished
  ///
  /// In en, this message translates to:
  /// **'Session finished'**
  String get sessionFinished;

  /// Flashcard session page title
  ///
  /// In en, this message translates to:
  /// **'Flashcard Session'**
  String get flashcardSession;

  /// Create deck page title
  ///
  /// In en, this message translates to:
  /// **'Create Deck'**
  String get createDeckTitle;

  /// Edit deck page title
  ///
  /// In en, this message translates to:
  /// **'Edit Deck'**
  String get editDeckTitle;

  /// Save changes dialog title
  ///
  /// In en, this message translates to:
  /// **'Save Changes?'**
  String get saveChanges;

  /// Edit more button
  ///
  /// In en, this message translates to:
  /// **'Edit More'**
  String get editMore;

  /// Delete card dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete card?'**
  String get deleteCard;

  /// Unsaved changes title
  ///
  /// In en, this message translates to:
  /// **'Unsaved Changes'**
  String get unsavedChanges;

  /// Unsaved changes message
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Do you want to leave?'**
  String get unsavedChangesMessage;

  /// Stay button
  ///
  /// In en, this message translates to:
  /// **'Stay'**
  String get stay;

  /// Leave button
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get leave;

  /// Library page title
  ///
  /// In en, this message translates to:
  /// **'Library'**
  String get libraryPageTitle;

  /// Delete folder dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Folder - {folderName}?'**
  String deleteFolderTitle(String folderName);

  /// Delete folder confirmation message
  ///
  /// In en, this message translates to:
  /// **'This will also delete all decks and cards inside.'**
  String get deleteFolderMessage;

  /// Decks section title
  ///
  /// In en, this message translates to:
  /// **'Decks'**
  String get decksTitle;

  /// Delete deck dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete Deck?'**
  String get deleteDeckTitle;

  /// Delete deck confirmation message
  ///
  /// In en, this message translates to:
  /// **'All {deckTitle} cards will be deleted.'**
  String deleteDeckMessage(String deckTitle);

  /// Start session button
  ///
  /// In en, this message translates to:
  /// **'Start Session'**
  String get startSession;

  /// Error title
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Retry button
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// Loading message
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// Study page title
  ///
  /// In en, this message translates to:
  /// **'Study'**
  String get studyPageTitle;

  /// Stats section title
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get statsTitle;

  /// Study modes section title
  ///
  /// In en, this message translates to:
  /// **'Study Modes'**
  String get studyModesTitle;

  /// Days in a row label
  ///
  /// In en, this message translates to:
  /// **'Days in a Row'**
  String get daysInARow;

  /// Invalid project id error
  ///
  /// In en, this message translates to:
  /// **'Invalid project id'**
  String get invalidProjectId;

  /// Invalid folder id error
  ///
  /// In en, this message translates to:
  /// **'Invalid folder id'**
  String get invalidFolderId;

  /// Invalid folder or deck id error
  ///
  /// In en, this message translates to:
  /// **'Invalid folder or deck id'**
  String get invalidFolderOrDeckId;

  /// Deck not found error title
  ///
  /// In en, this message translates to:
  /// **'Deck not found'**
  String get deckNotFoundTitle;

  /// Developer tools section title
  ///
  /// In en, this message translates to:
  /// **'Developer Tools'**
  String get developerTools;

  /// Start random 10 cards button
  ///
  /// In en, this message translates to:
  /// **'Start Random 10 Cards'**
  String get startRandom10Cards;

  /// Quick random study subtitle
  ///
  /// In en, this message translates to:
  /// **'Quick random study session'**
  String get quickRandomStudy;

  /// Begin fresh study session subtitle
  ///
  /// In en, this message translates to:
  /// **'Begin a fresh study session'**
  String get beginFreshSession;

  /// Matching study mode
  ///
  /// In en, this message translates to:
  /// **'Matching'**
  String get matchingMode;

  /// Pair terms subtitle
  ///
  /// In en, this message translates to:
  /// **'Pair terms'**
  String get pairTerms;

  /// Test mode tile title
  ///
  /// In en, this message translates to:
  /// **'Test Mode'**
  String get testMode;

  /// Practice mode title
  ///
  /// In en, this message translates to:
  /// **'Practice'**
  String get practiceMode;

  /// Flashcards mode
  ///
  /// In en, this message translates to:
  /// **'Flashcards'**
  String get flashcards;

  /// Learn with flashcards subtitle
  ///
  /// In en, this message translates to:
  /// **'Learn with flashcards'**
  String get learnWithFlashcards;

  /// Multiple choice mode
  ///
  /// In en, this message translates to:
  /// **'Multiple Choice'**
  String get multipleChoice;

  /// Write answer mode
  ///
  /// In en, this message translates to:
  /// **'Write Answer'**
  String get writeAnswer;

  /// Number of questions
  ///
  /// In en, this message translates to:
  /// **'{count} questions'**
  String questionsCount(int count);

  /// Card number label
  ///
  /// In en, this message translates to:
  /// **'Card {number}'**
  String cardNumber(int number);

  /// Front field required error
  ///
  /// In en, this message translates to:
  /// **'Front required'**
  String get frontRequired;

  /// Back field required error
  ///
  /// In en, this message translates to:
  /// **'Back required'**
  String get backRequired;

  /// Paste tooltip
  ///
  /// In en, this message translates to:
  /// **'Paste from clipboard'**
  String get pasteFromClipboard;

  /// Validation error message
  ///
  /// In en, this message translates to:
  /// **'Please fix validation errors'**
  String get fixValidationErrors;

  /// Card validation error
  ///
  /// In en, this message translates to:
  /// **'Card {number}: {error}'**
  String cardValidationError(int number, String error);

  /// Fill required fields error
  ///
  /// In en, this message translates to:
  /// **'Please fill all required fields'**
  String get fillRequiredFields;

  /// Deck saved message
  ///
  /// In en, this message translates to:
  /// **'Deck saved'**
  String get deckSaved;

  /// Deck updated message
  ///
  /// In en, this message translates to:
  /// **'Deck updated'**
  String get deckUpdated;

  /// Card deleted message
  ///
  /// In en, this message translates to:
  /// **'Card deleted'**
  String get cardDeleted;

  /// Deck title required error
  ///
  /// In en, this message translates to:
  /// **'Deck title is required'**
  String get deckTitleRequired;

  /// Saving deck operation
  ///
  /// In en, this message translates to:
  /// **'saving deck'**
  String get savingDeck;

  /// Updating deck operation
  ///
  /// In en, this message translates to:
  /// **'updating deck'**
  String get updatingDeck;

  /// Delete card dialog title
  ///
  /// In en, this message translates to:
  /// **'Delete card?'**
  String get deletingCardConfirm;

  /// Confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure?'**
  String get areYouSure;

  /// Remove card tooltip
  ///
  /// In en, this message translates to:
  /// **'Remove this card'**
  String get removeThisCard;

  /// Deck name in confirmation
  ///
  /// In en, this message translates to:
  /// **'Deck: {deckName}'**
  String deckWithCards(String deckName);

  /// Card count in confirmation
  ///
  /// In en, this message translates to:
  /// **'Cards: {count}'**
  String cardCountLabel(int count);

  /// Select folder prompt
  ///
  /// In en, this message translates to:
  /// **'Select a Folder'**
  String get selectFolder;

  /// Creating folder operation
  ///
  /// In en, this message translates to:
  /// **'creating folder'**
  String get creatingFolder;

  /// Renaming folder operation
  ///
  /// In en, this message translates to:
  /// **'renaming folder'**
  String get renamingFolder;

  /// Deleting folder operation
  ///
  /// In en, this message translates to:
  /// **'deleting folder'**
  String get deletingFolder;

  /// Folder renamed message
  ///
  /// In en, this message translates to:
  /// **'Folder \"{old}\" renamed to \"{newName}\"'**
  String folderRenamed(String old, String newName);

  /// Folder deleted message
  ///
  /// In en, this message translates to:
  /// **'Folder \"{name}\" deleted'**
  String folderDeleted(String name);

  /// Deck deleted message
  ///
  /// In en, this message translates to:
  /// **'Deck \"{name}\" deleted'**
  String deckDeleted(String name);

  /// Create new folder title
  ///
  /// In en, this message translates to:
  /// **'Create New Folder'**
  String get createNewFolder;

  /// Rename folder title
  ///
  /// In en, this message translates to:
  /// **'Rename Folder'**
  String get renameFolder;

  /// Folder name hint
  ///
  /// In en, this message translates to:
  /// **'Enter folder name'**
  String get enterFolderName;

  /// Folder name required error
  ///
  /// In en, this message translates to:
  /// **'Folder name is required'**
  String get folderNameRequired;

  /// Needs review status
  ///
  /// In en, this message translates to:
  /// **'Needs review'**
  String get needsReview;

  /// In progress status
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get inProgress;

  /// Good progress status
  ///
  /// In en, this message translates to:
  /// **'Good progress'**
  String get goodProgress;

  /// Deleting deck operation
  ///
  /// In en, this message translates to:
  /// **'deleting deck'**
  String get deletingDeck;

  /// Failed to load deck error
  ///
  /// In en, this message translates to:
  /// **'Failed to load deck'**
  String get failedToLoadDeck;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
