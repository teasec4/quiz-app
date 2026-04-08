// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'QuizLet';

  @override
  String get study => 'Учеба';

  @override
  String get library => 'Библиотека';

  @override
  String get settings => 'Настройки';

  @override
  String get stats => 'Статистика';

  @override
  String get back => 'Назад';

  @override
  String get next => 'Далее';

  @override
  String get save => 'Сохранить';

  @override
  String get cancel => 'Отмена';

  @override
  String get delete => 'Удалить';

  @override
  String get edit => 'Редактировать';

  @override
  String get editName => 'Переименовать';

  @override
  String get done => 'Готово';

  @override
  String get confirm => 'Подтвердить';

  @override
  String get studyTitle => 'Учеба';

  @override
  String get selectDeck => 'Выберите колоду';

  @override
  String get noDecksAvailable => 'Нет доступных колод';

  @override
  String get startStudySession => 'Начать учебную сессию';

  @override
  String get continueStudy => 'Продолжить учебу';

  @override
  String cardsRemaining(int count) {
    return '$count карточек осталось';
  }

  @override
  String get studyComplete => 'Учеба завершена!';

  @override
  String get correctAnswer => 'Правильно';

  @override
  String get incorrectAnswer => 'Неправильно';

  @override
  String get showAnswer => 'Показать ответ';

  @override
  String get rateDifficulty => 'Оценить сложность';

  @override
  String get easy => 'Легко';

  @override
  String get medium => 'Средне';

  @override
  String get hard => 'Сложно';

  @override
  String get libraryTitle => 'Библиотека';

  @override
  String get folders => 'Папки';

  @override
  String get decks => 'Колоды';

  @override
  String get createFolder => 'Создать папку';

  @override
  String get createDeck => 'Создать колоду';

  @override
  String get folderName => 'Название папки';

  @override
  String get deckName => 'Название колоды';

  @override
  String get deckDescription => 'Описание';

  @override
  String cardsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count карточек',
      few: 'от 2 до 4 карточек',
      one: '1 карточка',
      zero: 'нет карточек',
    );
    return '$_temp0';
  }

  @override
  String get addCard => 'Добавить карточку';

  @override
  String get frontSide => 'Лицевая сторона';

  @override
  String get backSide => 'Обратная сторона';

  @override
  String get tags => 'Теги';

  @override
  String get settingsTitle => 'Настройки';

  @override
  String get themeSettings => 'Настройки темы';

  @override
  String get customizeAppearance => 'Настройте внешний вид приложения';

  @override
  String get darkMode => 'Тёмная тема';

  @override
  String get toggleDarkTheme => 'Переключить тёмную тему';

  @override
  String get themeVariant => 'Вариант темы';

  @override
  String get minimalTheme => 'Минимальная';

  @override
  String get techTheme => 'Техно';

  @override
  String get modernTheme => 'Современная';

  @override
  String get resetToDefaults => 'Сбросить настройки';

  @override
  String get languageSettings => 'Настройки языка';

  @override
  String get selectAppLanguage => 'Выберите язык приложения';

  @override
  String get english => 'Английский';

  @override
  String get russian => 'Русский';

  @override
  String get chinese => 'Китайский';

  @override
  String get resetToEnglish => 'Сбросить на английский';

  @override
  String get applicationVersion => 'Версия приложения';

  @override
  String get statisticsTitle => 'Статистика';

  @override
  String get totalStudyTime => 'Общее время учебы';

  @override
  String get cardsStudied => 'Изучено карточек';

  @override
  String get accuracyRate => 'Процент верных ответов';

  @override
  String get streak => 'Серия';

  @override
  String get today => 'Сегодня';

  @override
  String get thisWeek => 'Эта неделя';

  @override
  String get thisMonth => 'Этот месяц';

  @override
  String get allTime => 'Всё время';

  @override
  String get errorTitle => 'Ошибка';

  @override
  String get unexpectedError => 'Произошла неожиданная ошибка';

  @override
  String get networkError => 'Ошибка сети. Проверьте подключение.';

  @override
  String get validationError => 'Проверьте ввод';

  @override
  String get emptyFieldError => 'Это поле не может быть пустым';

  @override
  String get deckNotFound => 'Колода не найдена';

  @override
  String get folderNotFound => 'Папка не найдена';

  @override
  String get successTitle => 'Успешно';

  @override
  String get deckCreated => 'Колода успешно создана';

  @override
  String folderCreated(String name) {
    return 'Папка \"$name\" создана';
  }

  @override
  String get cardAdded => 'Карточка успешно добавлена';

  @override
  String get changesSaved => 'Изменения сохранены';

  @override
  String get studySessionSaved => 'Учебная сессия сохранена';

  @override
  String get confirmDelete => 'Подтвердить удаление';

  @override
  String get deleteDeckConfirm =>
      'Вы уверены, что хотите удалить эту колоду? Это действие нельзя отменить.';

  @override
  String get deleteFolderConfirm =>
      'Вы уверены, что хотите удалить эту папку? Все колоды внутри также будут удалены.';

  @override
  String get deleteCardConfirm => 'Вы уверены?';

  @override
  String get noFolders => 'Папок пока нет';

  @override
  String get noDecks => 'Колод пока нет';

  @override
  String get noCards => 'Карточек пока нет';

  @override
  String get noStudySessions => 'Учебных сессий пока нет';

  @override
  String createFirstItem(String item) {
    return 'Создайте первый $item, чтобы начать';
  }

  @override
  String minutesAgo(int count) {
    return '$count минут назад';
  }

  @override
  String hoursAgo(int count) {
    return '$count часов назад';
  }

  @override
  String get sessionComplete => 'Сессия завершена!';

  @override
  String get greatJob => 'Отлично! Так держать!';

  @override
  String get keepPracticing =>
      'Продолжай практиковаться, у тебя всё получится!';

  @override
  String get scoreLabel => 'Результат';

  @override
  String get sessionDone => 'Готово';

  @override
  String cardsCorrect(int correct, int total) {
    return '$correct из $total карточек правильно';
  }

  @override
  String daysAgo(int count) {
    return '$count дней назад';
  }

  @override
  String get goToStudy => 'Перейти к учебе';

  @override
  String get sessionFinished => 'Сессия завершена';

  @override
  String get flashcardSession => 'Карточки';

  @override
  String get createDeckTitle => 'Создать колоду';

  @override
  String get editDeckTitle => 'Редактировать колоду';

  @override
  String get saveChanges => 'Сохранить изменения?';

  @override
  String get editMore => 'Редактировать ещё';

  @override
  String get deleteCard => 'Удалить карточку?';

  @override
  String get unsavedChanges => 'Несохранённые изменения';

  @override
  String get unsavedChangesMessage =>
      'У вас есть несохранённые изменения. Вы хотите уйти?';

  @override
  String get stay => 'Остаться';

  @override
  String get leave => 'Уйти';

  @override
  String get libraryPageTitle => 'Библиотека';

  @override
  String deleteFolderTitle(String folderName) {
    return 'Удалить папку - $folderName?';
  }

  @override
  String get deleteFolderMessage =>
      'Все колоды и карточки внутри также будут удалены.';

  @override
  String get decksTitle => 'Колоды';

  @override
  String get deleteDeckTitle => 'Удалить колоду?';

  @override
  String deleteDeckMessage(String deckTitle) {
    return 'Все карточки колоды $deckTitle будут удалены.';
  }

  @override
  String get startSession => 'Начать сессию';

  @override
  String get error => 'Ошибка';

  @override
  String get retry => 'Повторить';

  @override
  String get loading => 'Загрузка...';

  @override
  String get studyPageTitle => 'Учеба';

  @override
  String get statsTitle => 'Статистика';

  @override
  String get studyModesTitle => 'Режимы учебы';

  @override
  String get daysInARow => 'Дней подряд';

  @override
  String get invalidProjectId => 'Неверный идентификатор проекта';

  @override
  String get invalidFolderId => 'Неверный идентификатор папки';

  @override
  String get invalidFolderOrDeckId => 'Неверный идентификатор папки или колоды';

  @override
  String get deckNotFoundTitle => 'Колода не найдена';

  @override
  String get developerTools => 'Инструменты разработчика';

  @override
  String get startRandom10Cards => 'Начать 10 случайных карточек';

  @override
  String get quickRandomStudy => 'Быстрая случайная учебная сессия';

  @override
  String get beginFreshSession => 'Начните новую учебную сессию';

  @override
  String get matchingMode => 'Сопоставление';

  @override
  String get pairTerms => 'Сопоставьте термины';

  @override
  String get testMode => 'Тестовый режим';

  @override
  String get practiceMode => 'Практика';

  @override
  String get flashcards => 'Карточки';

  @override
  String get learnWithFlashcards => 'Учите с карточками';

  @override
  String get multipleChoice => 'Multiple Choice';

  @override
  String get writeAnswer => 'Написать ответ';

  @override
  String questionsCount(int count) {
    return '$count вопросов';
  }

  @override
  String cardNumber(int number) {
    return 'Карточка $number';
  }

  @override
  String get frontRequired => 'Лицевая сторона обязательна';

  @override
  String get backRequired => 'Обратная сторона обязательна';

  @override
  String get pasteFromClipboard => 'Вставить из буфера обмена';

  @override
  String get fixValidationErrors => 'Пожалуйста, исправьте ошибки валидации';

  @override
  String cardValidationError(int number, String error) {
    return 'Карточка $number: $error';
  }

  @override
  String get fillRequiredFields =>
      'Пожалуйста, заполните все обязательные поля';

  @override
  String get deckSaved => 'Колода сохранена';

  @override
  String get deckUpdated => 'Колода обновлена';

  @override
  String get cardDeleted => 'Карточка удалена';

  @override
  String get deckTitleRequired => 'Название колоды обязательно';

  @override
  String get savingDeck => 'сохранение колоды';

  @override
  String get updatingDeck => 'обновление колоды';

  @override
  String get deletingCardConfirm => 'Удалить карточку?';

  @override
  String get areYouSure => 'Вы уверены?';

  @override
  String get removeThisCard => 'Удалить эту карточку';

  @override
  String deckWithCards(String deckName) {
    return 'Колода: $deckName';
  }

  @override
  String cardCountLabel(int count) {
    return 'Карточек: $count';
  }

  @override
  String get selectFolder => 'Выберите папку';

  @override
  String get creatingFolder => 'создание папки';

  @override
  String get renamingFolder => 'переименование папки';

  @override
  String get deletingFolder => 'удаление папки';

  @override
  String folderRenamed(String old, String newName) {
    return 'Папка \"$old\" переименована в \"$newName\"';
  }

  @override
  String folderDeleted(String name) {
    return 'Папка \"$name\" удалена';
  }

  @override
  String deckDeleted(String name) {
    return 'Колода \"$name\" удалена';
  }

  @override
  String get createNewFolder => 'Создать новую папку';

  @override
  String get renameFolder => 'Переименовать папку';

  @override
  String get enterFolderName => 'Введите название папки';

  @override
  String get folderNameRequired => 'Название папки обязательно';

  @override
  String get needsReview => 'Нужно повторить';

  @override
  String get inProgress => 'В процессе';

  @override
  String get goodProgress => 'Хороший прогресс';

  @override
  String get deletingDeck => 'удаление колоды';

  @override
  String get failedToLoadDeck => 'Не удалось загрузить колоду';
}
