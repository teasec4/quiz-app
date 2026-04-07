import 'package:bookexample/presentation/pages/session/models/study_session_draft.dart';

abstract class StudySessionRepository {
  Future<void> saveSession(StudySessionDraft studySessionDraft);
}
