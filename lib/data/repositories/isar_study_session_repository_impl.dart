import 'package:bookexample/domain/isar_model/session/study_answer_entity.dart';
import 'package:bookexample/domain/isar_model/session/study_session_entity.dart';
import 'package:bookexample/domain/repositories/study_session_repository.dart';
import 'package:isar_community/isar.dart';

import '../../pages/session/models/study_session_draft.dart';

class IsarStudySessionRepositoryImpl implements StudySessionRepository {
  final Isar isar;

  IsarStudySessionRepositoryImpl({required this.isar});
  @override
  Future<void> saveSession(StudySessionDraft draft) async {
    await isar.writeTxn(() async {
      final session = StudySessionEntity()
        ..endedAt = DateTime.now()
        ..totalCards = draft.answers.length
        ..correctAnswers = draft.answers.where((a) => a.isCorrect).length;

      await isar.studySessionEntitys.put(session);

      for (final a in draft.answers) {
        final answer = StudyAnswerEntity()
          ..cardId = a.cardId
          ..session.value = session;

        await isar.studyAnswerEntitys.put(answer);
        await answer.session.save();
      }
    });
    
    // update Stats
    
  }
}
