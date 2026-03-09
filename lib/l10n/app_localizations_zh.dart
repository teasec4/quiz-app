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
  String get library => '图书馆';

  @override
  String get settings => '设置';

  @override
  String get stats => '统计';

  @override
  String get back => '返回';

  @override
  String get next => '下一步';

  @override
  String get save => '保存';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get edit => '编辑';

  @override
  String get done => '完成';

  @override
  String get confirm => '确认';

  @override
  String get studyTitle => '学习';

  @override
  String get selectDeck => '选择卡片组';

  @override
  String get noDecksAvailable => '没有可用的卡片组';

  @override
  String get startStudySession => '开始学习会话';

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
  String get libraryTitle => '图书馆';

  @override
  String get folders => '文件夹';

  @override
  String get decks => '卡片组';

  @override
  String get createFolder => '创建文件夹';

  @override
  String get createDeck => '创建卡片组';

  @override
  String get folderName => '文件夹名称';

  @override
  String get deckName => '卡片组名称';

  @override
  String get deckDescription => '描述';

  @override
  String cardsCount(int count) {
    return '$count 张卡片';
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
  String get customizeAppearance => '自定义应用程序外观';

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
  String get resetToDefaults => '恢复默认设置';

  @override
  String get languageSettings => '语言设置';

  @override
  String get selectAppLanguage => '选择应用程序语言';

  @override
  String get english => '英语';

  @override
  String get russian => '俄语';

  @override
  String get chinese => '中文';

  @override
  String get resetToEnglish => '恢复为英语';

  @override
  String get applicationVersion => '应用程序版本';

  @override
  String get statisticsTitle => '统计';

  @override
  String get totalStudyTime => '总学习时间';

  @override
  String get cardsStudied => '已学习卡片';

  @override
  String get accuracyRate => '准确率';

  @override
  String get streak => '连续学习';

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
  String get networkError => '网络错误。请检查您的连接。';

  @override
  String get validationError => '请检查您的输入';

  @override
  String get emptyFieldError => '此字段不能为空';

  @override
  String get deckNotFound => '未找到卡片组';

  @override
  String get folderNotFound => '未找到文件夹';

  @override
  String get successTitle => '成功';

  @override
  String get deckCreated => '卡片组创建成功';

  @override
  String get folderCreated => '文件夹创建成功';

  @override
  String get cardAdded => '卡片添加成功';

  @override
  String get changesSaved => '更改保存成功';

  @override
  String get studySessionSaved => '学习会话已保存';

  @override
  String get confirmDelete => '确认删除';

  @override
  String get deleteDeckConfirm => '确定要删除此卡片组吗？此操作无法撤销。';

  @override
  String get deleteFolderConfirm => '确定要删除此文件夹吗？里面的所有卡片组也将被删除。';

  @override
  String get deleteCardConfirm => '确定要删除此卡片吗？';

  @override
  String get noFolders => '暂无文件夹';

  @override
  String get noDecks => '暂无卡片组';

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
  String daysAgo(int count) {
    return '$count 天前';
  }
}
