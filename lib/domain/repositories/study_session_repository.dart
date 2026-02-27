import 'package:bookexample/pages/session/models/study_session_draft.dart';

abstract class StudySessionRepository {
  Future<void> saveSession(StudySessionDraft studySessionDraft);

}