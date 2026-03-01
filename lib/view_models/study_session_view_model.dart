import 'package:bookexample/domain/repositories/study_session_repository.dart';
import 'package:bookexample/pages/session/models/study_session_draft.dart';
import 'package:flutter/foundation.dart';

class StudySessionViewModel extends ChangeNotifier {
  final StudySessionRepository repository;

  StudySessionViewModel(this.repository);

  Future<void> saveSession(StudySessionDraft draft) async {
    await repository.saveSession(draft);
  }
}
