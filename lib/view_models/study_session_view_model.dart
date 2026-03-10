import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/domain/repositories/stats_repository.dart';
import 'package:bookexample/domain/repositories/study_session_repository.dart';
import 'package:bookexample/pages/session/models/study_session_draft.dart';

import 'package:bookexample/view_models/base_view_model.dart';

class StudySessionViewModel extends BaseViewModel {
  final StudySessionRepository studyRepo;
  final LibraryRepository libraryRepo;
  final StatsRepository statsRepo;

  StudySessionViewModel({
    required this.studyRepo,
    required this.libraryRepo,
    required this.statsRepo,
  });

  StudySessionDraft? _session;

  StudySessionDraft? get session => _session;

  Future<void> startSession(int deckId) async {
    await executeAsync(() async {
      final cards = await libraryRepo.getCardsByDeck(deckId);
      _session = StudySessionDraft.fromCards(cards);
    }, operationName: 'Start session for deck: $deckId');
  }

  Future<void> saveSession(StudySessionDraft draft) async {
    await executeAsync(
      () => studyRepo.saveSession(draft),
      operationName: 'Save session',
    );
  }

  void answerCurrentCard(bool isCorrect) {
    _session?.answerCurrent(isCorrect);
    notifyListeners();
  }

  Future<void> completeSession() async {
    if (_session == null) return;

    await executeAsync(() async {
      // Сохранить сессию в БД
      await studyRepo.saveSession(_session!);

      // Обновить stats
      await statsRepo.updateStats(
        _session!.cards.length,
        _session!.correctCount,
        DateTime.now(),
      );

      // Сохранить карточки как выученные
      final answers = _session!.answers;
      if (answers.isNotEmpty) {
        await libraryRepo.setCardsLearned(answers);
      }

      // Очистить сессию
      _session = null;
    }, operationName: 'Complete session');
  }
}
