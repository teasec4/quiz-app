import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/domain/repositories/stats_repository.dart';
import 'package:bookexample/domain/repositories/study_session_repository.dart';
import 'package:bookexample/pages/session/models/study_session_draft.dart';
import 'package:flutter/foundation.dart';

class StudySessionViewModel extends ChangeNotifier {
  final StudySessionRepository repository;
  final LibraryRepository libraryRepo;
  final StatsRepository statsRepo;

  StudySessionViewModel(this.repository);

  StudySessionDraft? _session;

  Future<void> startSession(int deckId) async {
    final cards = await libraryRepo.getCardsByDeck(deckId);
    _session = StudySessionDraft.fromCards(cards);
    notifyListeners();
  }

  Future<void> saveSession(StudySessionDraft draft) async {
    await repository.saveSession(draft);
  }

  Future<void> finishSession() async {
    if (_session == null) return;
    
    // await statsRepo.saveSession(_session!);
    // await libraryRepo.setCardsLearned(_session!.learnedCardIds);

    // _session = null;
    // notifyListeners();
  }
}
