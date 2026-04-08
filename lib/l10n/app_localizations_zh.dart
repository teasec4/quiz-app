// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'QuizLet';

  @override
  String get study => '学习';

  @override
  String get library => '库';

  @override
  String get settings => '设置';

  @override
  String get stats => '统计';

  @override
  String get back => '返回';

  @override
  String get next => '下一个';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get editName => '重命名';

  @override
  String get done => '完成';

  @override
  String get confirm => '确认';

  @override
  String get studyTitle => '学习';

  @override
  String get selectDeck => '选择卡组';

  @override
  String get noDecksAvailable => '没有可用的卡组';

  @override
  String get startStudySession => '开始学习';

  @override
  String get continueStudy => '继续学习';

  @override
  String cardsRemaining(int count) {
    return '剩余 $count 张卡片';
  }

  @override
  String get studyComplete => '学习完成！';

  @override
  String get correctAnswer => '正确';

  @override
  String get incorrectAnswer => '错误';

  @override
  String get showAnswer => '显示答案';

  @override
  String get rateDifficulty => '评价难度';

  @override
  String get easy => '简单';

  @override
  String get medium => '中等';

  @override
  String get hard => '困难';

  @override
  String get libraryTitle => '库';

  @override
  String get folders => '文件夹';

  @override
  String get decks => '卡组';

  @override
  String get createFolder => '创建文件夹';

  @override
  String get createDeck => '创建卡组';

  @override
  String get folderName => '文件夹名称';

  @override
  String get deckName => '卡组名称';

  @override
  String get deckDescription => '描述';

  @override
  String cardsCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count 张卡片',
      zero: '没有卡片',
    );
    return '$_temp0';
  }

  @override
  String get addCard => '添加卡片';

  @override
  String get frontSide => '正面';

  @override
  String get backSide => '背面';

  @override
  String get tags => '标签';

  @override
  String get settingsTitle => '设置';

  @override
  String get themeSettings => '主题设置';

  @override
  String get customizeAppearance => '自定义应用外观';

  @override
  String get darkMode => '深色模式';

  @override
  String get toggleDarkTheme => '切换深色主题';

  @override
  String get themeVariant => '主题变体';

  @override
  String get minimalTheme => '简约';

  @override
  String get techTheme => '科技';

  @override
  String get modernTheme => '现代';

  @override
  String get resetToDefaults => '重置为默认';

  @override
  String get languageSettings => '语言设置';

  @override
  String get selectAppLanguage => '选择应用语言';

  @override
  String get english => '英语';

  @override
  String get russian => '俄语';

  @override
  String get chinese => '中文';

  @override
  String get resetToEnglish => '重置为英语';

  @override
  String get applicationVersion => '应用版本';

  @override
  String get statisticsTitle => '统计';

  @override
  String get totalStudyTime => '总学习时间';

  @override
  String get cardsStudied => '已学卡片';

  @override
  String get accuracyRate => '正确率';

  @override
  String get streak => '连续';

  @override
  String get today => '今天';

  @override
  String get thisWeek => '本周';

  @override
  String get thisMonth => '本月';

  @override
  String get allTime => '全部时间';

  @override
  String get errorTitle => '错误';

  @override
  String get unexpectedError => '发生意外错误';

  @override
  String get networkError => '网络错误，请检查您的连接。';

  @override
  String get validationError => '请检查您的输入';

  @override
  String get emptyFieldError => '此字段不能为空';

  @override
  String get deckNotFound => '未找到卡组';

  @override
  String get folderNotFound => '未找到文件夹';

  @override
  String get successTitle => '成功';

  @override
  String get deckCreated => '卡组创建成功';

  @override
  String folderCreated(String name) {
    return '文件夹 \"$name\" 已创建';
  }

  @override
  String get cardAdded => '卡片添加成功';

  @override
  String get changesSaved => '更改已保存';

  @override
  String get studySessionSaved => '学习会话已保存';

  @override
  String get confirmDelete => '确认删除';

  @override
  String get deleteDeckConfirm => '您确定要删除此卡组吗？此操作无法撤销。';

  @override
  String get deleteFolderConfirm => '您确定要删除此文件夹吗？其中的所有卡组也将被删除。';

  @override
  String get deleteCardConfirm => '确定删除？';

  @override
  String get noFolders => '暂无文件夹';

  @override
  String get noDecks => '暂无卡组';

  @override
  String get noCards => '暂无卡片';

  @override
  String get noStudySessions => '暂无学习会话';

  @override
  String createFirstItem(String item) {
    return '创建您的第一个$item以开始';
  }

  @override
  String minutesAgo(int count) {
    return '$count 分钟前';
  }

  @override
  String hoursAgo(int count) {
    return '$count 小时前';
  }

  @override
  String get sessionComplete => '学习完成！';

  @override
  String get greatJob => '太棒了！继续保持！';

  @override
  String get keepPracticing => '继续练习，你会越来越好的！';

  @override
  String get scoreLabel => '得分';

  @override
  String get sessionDone => '完成';

  @override
  String cardsCorrect(int correct, int total) {
    return '$correct / $total 张卡片正确';
  }

  @override
  String daysAgo(int count) {
    return '$count 天前';
  }

  @override
  String get goToStudy => '去学习';

  @override
  String get sessionFinished => '学习结束';

  @override
  String get flashcardSession => '闪卡学习';

  @override
  String get createDeckTitle => '创建卡组';

  @override
  String get editDeckTitle => '编辑卡组';

  @override
  String get saveChanges => '保存更改？';

  @override
  String get editMore => '继续编辑';

  @override
  String get deleteCard => '删除卡片？';

  @override
  String get unsavedChanges => '未保存的更改';

  @override
  String get unsavedChangesMessage => '您有未保存的更改。确定要离开吗？';

  @override
  String get stay => '留下';

  @override
  String get leave => '离开';

  @override
  String get libraryPageTitle => '库';

  @override
  String deleteFolderTitle(String folderName) {
    return '删除文件夹 - $folderName？';
  }

  @override
  String get deleteFolderMessage => '其中的所有卡组和卡片也将被删除。';

  @override
  String get decksTitle => '卡组';

  @override
  String get deleteDeckTitle => '删除卡组？';

  @override
  String deleteDeckMessage(String deckTitle) {
    return '所有 $deckTitle 卡片将被删除。';
  }

  @override
  String get startSession => '开始学习';

  @override
  String get error => '错误';

  @override
  String get retry => '重试';

  @override
  String get loading => '加载中...';

  @override
  String get studyPageTitle => '学习';

  @override
  String get statsTitle => '统计';

  @override
  String get studyModesTitle => '学习模式';

  @override
  String get daysInARow => '连续天数';

  @override
  String get invalidProjectId => '无效的项目ID';

  @override
  String get invalidFolderId => '无效的文件夹ID';

  @override
  String get invalidFolderOrDeckId => '无效的文件夹或卡组ID';

  @override
  String get deckNotFoundTitle => '未找到卡组';

  @override
  String get developerTools => '开发者工具';

  @override
  String get startRandom10Cards => '开始随机10张卡';

  @override
  String get quickRandomStudy => '快速随机学习';

  @override
  String get beginFreshSession => '开始新的学习';

  @override
  String get matchingMode => '配对';

  @override
  String get pairTerms => '配对术语';

  @override
  String get testMode => '测试模式';

  @override
  String get practiceMode => '练习';

  @override
  String get flashcards => '闪卡';

  @override
  String get learnWithFlashcards => '使用闪卡学习';

  @override
  String get multipleChoice => '选择题';

  @override
  String get writeAnswer => '填写答案';

  @override
  String questionsCount(int count) {
    return '$count 个问题';
  }

  @override
  String cardNumber(int number) {
    return '第 $number 张卡';
  }

  @override
  String get frontRequired => '正面必填';

  @override
  String get backRequired => '背面必填';

  @override
  String get pasteFromClipboard => '从剪贴板粘贴';

  @override
  String get fixValidationErrors => '请修复验证错误';

  @override
  String cardValidationError(int number, String error) {
    return '卡片 $number: $error';
  }

  @override
  String get fillRequiredFields => '请填写所有必填字段';

  @override
  String get deckSaved => '卡组已保存';

  @override
  String get deckUpdated => '卡组已更新';

  @override
  String get cardDeleted => '卡片已删除';

  @override
  String get deckTitleRequired => '卡组标题必填';

  @override
  String get savingDeck => '保存卡组';

  @override
  String get updatingDeck => '更新卡组';

  @override
  String get deletingCardConfirm => '删除卡片？';

  @override
  String get areYouSure => '确定吗？';

  @override
  String get removeThisCard => '移除此卡片';

  @override
  String deckWithCards(String deckName) {
    return '卡组：$deckName';
  }

  @override
  String cardCountLabel(int count) {
    return '卡片：$count';
  }

  @override
  String get selectFolder => '选择文件夹';

  @override
  String get creatingFolder => '创建文件夹';

  @override
  String get renamingFolder => '重命名文件夹';

  @override
  String get deletingFolder => '删除文件夹';

  @override
  String folderRenamed(String old, String newName) {
    return '文件夹 \"$old\" 已重命名为 \"$newName\"';
  }

  @override
  String folderDeleted(String name) {
    return '文件夹 \"$name\" 已删除';
  }

  @override
  String deckDeleted(String name) {
    return '卡组 \"$name\" 已删除';
  }

  @override
  String get createNewFolder => '创建新文件夹';

  @override
  String get renameFolder => '重命名文件夹';

  @override
  String get enterFolderName => '输入文件夹名称';

  @override
  String get folderNameRequired => '文件夹名称必填';

  @override
  String get needsReview => '需要复习';

  @override
  String get inProgress => '进行中';

  @override
  String get goodProgress => '进度良好';

  @override
  String get deletingDeck => '删除卡组';

  @override
  String get failedToLoadDeck => '加载卡组失败';
}
