import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/domain/repositories/study_session_repository.dart';
import 'package:bookexample/pages/session/models/study_session_draft.dart';
import 'package:bookexample/view_models/stats_view_model.dart';
import 'package:flutter/foundation.dart';

class StudySessionViewModel extends ChangeNotifier {
  final StudySessionRepository studyRepo;
  final LibraryRepository libraryRepo;
  final StatsViewModel statsVM;

  StudySessionViewModel({
    required this.studyRepo,
    required this.libraryRepo,
    required this.statsVM,
  });

  StudySessionDraft? _session;

  StudySessionDraft? get session => _session;

  Future<void> startSession(int deckId) async {
    final cards = await libraryRepo.getCardsByDeck(deckId);
    _session = StudySessionDraft.fromCards(cards);
    notifyListeners();
  }

  Future<void> saveSession(StudySessionDraft draft) async {
    await studyRepo.saveSession(draft);
  }

  void answerCurrentCard(bool isCorrect) {
    _session?.answerCurrent(isCorrect);
    notifyListeners();
  }

  Future<void> finishSession() async {
    if (_session == null) return;

    try {
      // Сохранить карточки как выученные
      final answers = _session!.answers;

      if (answers.isNotEmpty) {
        await libraryRepo.setCardsLearned(answers);
      }

      // Сохранить stats
      await statsVM.updateStats(
        _session!.cards.length,
        _session!.correctCount,
        DateTime.now(),
      );

      _session = null;
      notifyListeners();
    } catch (e) {
      print('Error finishing session: $e');
      rethrow;
    }
  }
}
