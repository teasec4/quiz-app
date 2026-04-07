import 'package:bookexample/core/exceptions/app_exceptions.dart';
import 'package:bookexample/core/logging/app_logger.dart';
import 'package:bookexample/data/isar_db_extension.dart';
import 'package:bookexample/domain/base_repository.dart';
import 'package:bookexample/domain/isar_model/session/study_answer_entity.dart';
import 'package:bookexample/domain/isar_model/session/study_session_entity.dart';
import 'package:bookexample/domain/repositories/study_session_repository.dart';
import 'package:bookexample/pages/session/models/study_session_draft.dart';

class IsarStudySessionRepositoryImpl extends BaseRepository
    implements StudySessionRepository {
  IsarStudySessionRepositoryImpl(super.isar);

  @override
  Future<void> saveSession(StudySessionDraft draft) async {
    if (draft.answers.isEmpty) {
      throw ValidationException('Invalid session data', {
        'answers': 'Session must contain at least one answer',
      });
    }

    if (draft.answers.length != draft.cards.length) {
      throw ValidationException('Invalid session data', {
        'answers': 'Number of answers must match number of cards',
      });
    }

    await executeDbOperation(() async {
      await isar.writeTxn(() async {
        final session = StudySessionEntity()
          ..endedAt = DateTime.now()
          ..totalCards = draft.answers.length
          ..correctAnswers = draft.answers.where((a) => a.isCorrect).length
          ..isCompleted = true;

        final sessionId = await isar.studySessionEntitys.put(session);
        session.id = sessionId;

        for (final a in draft.answers) {
          final answer = StudyAnswerEntity()
            ..cardId = a.cardId
            ..isCorrect = a.isCorrect
            ..session.value = session;

          final answerId = await isar.studyAnswerEntitys.put(answer);
          answer.id = answerId;

          await isar.saveAnswerLinks(answer);
        }

        await isar.saveSessionLinks(session);
      });

      AppLogger.info(
        'Saved study session: ${draft.answers.length} cards, '
        '${draft.answers.where((a) => a.isCorrect).length} correct',
      );
    }, 'saveSession');
  }
}
