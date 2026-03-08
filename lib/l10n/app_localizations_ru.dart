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
  String get startStudySession => 'Начать сессию учебы';

  @override
  String get continueStudy => 'Продолжить учебу';

  @override
  String cardsRemaining(int count) {
    return 'Осталось $count карточек';
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
    return '$count карточек';
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
  String get darkMode => 'Темная тема';

  @override
  String get toggleDarkTheme => 'Переключить темную тему';

  @override
  String get themeVariant => 'Вариант темы';

  @override
  String get minimalTheme => 'Минимализм';

  @override
  String get techTheme => 'Техно';

  @override
  String get modernTheme => 'Модерн';

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
  String get resetSettings => 'Сбросить настройки';

  @override
  String get resetSettingsDescription =>
      'Сбросить все настройки к значениям по умолчанию';

  @override
  String get allSettingsReset => 'Все настройки сброшены';

  @override
  String get resetAllSettings => 'Сбросить все настройки';

  @override
  String get applicationVersion => 'Версия приложения';

  @override
  String get statisticsTitle => 'Статистика';

  @override
  String get totalStudyTime => 'Общее время учебы';

  @override
  String get cardsStudied => 'Изучено карточек';

  @override
  String get accuracyRate => 'Точность';

  @override
  String get streak => 'Серия';

  @override
  String get today => 'Сегодня';

  @override
  String get thisWeek => 'На этой неделе';

  @override
  String get thisMonth => 'В этом месяце';

  @override
  String get allTime => 'За все время';

  @override
  String get errorTitle => 'Ошибка';

  @override
  String get unexpectedError => 'Произошла непредвиденная ошибка';

  @override
  String get networkError => 'Ошибка сети. Проверьте подключение.';

  @override
  String get validationError => 'Проверьте введенные данные';

  @override
  String get emptyFieldError => 'Это поле не может быть пустым';

  @override
  String get deckNotFound => 'Колода не найдена';

  @override
  String get folderNotFound => 'Папка не найдена';

  @override
  String get successTitle => 'Успех';

  @override
  String get deckCreated => 'Колода успешно создана';

  @override
  String get folderCreated => 'Папка успешно создана';

  @override
  String get cardAdded => 'Карточка успешно добавлена';

  @override
  String get changesSaved => 'Изменения успешно сохранены';

  @override
  String get studySessionSaved => 'Сессия учебы сохранена';

  @override
  String get confirmDelete => 'Подтверждение удаления';

  @override
  String get deleteDeckConfirm =>
      'Вы уверены, что хотите удалить эту колоду? Это действие нельзя отменить.';

  @override
  String get deleteFolderConfirm =>
      'Вы уверены, что хотите удалить эту папку? Все колоды внутри также будут удалены.';

  @override
  String get deleteCardConfirm =>
      'Вы уверены, что хотите удалить эту карточку?';

  @override
  String get noFolders => 'Пока нет папок';

  @override
  String get noDecks => 'Пока нет колод';

  @override
  String get noCards => 'Пока нет карточек';

  @override
  String get noStudySessions => 'Пока нет сессий учебы';

  @override
  String createFirstItem(String item) {
    return 'Создайте свой первый $item, чтобы начать';
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
  String daysAgo(int count) {
    return '$count дней назад';
  }
}
