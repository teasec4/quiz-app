
import 'package:bookexample/domain/isar_model/session/study_answer_entity.dart';
import 'package:isar_community/isar.dart';

part 'study_session_entity.g.dart';

@collection
class StudySessionEntity {
  Id id = Isar.autoIncrement;

  late DateTime endedAt;

  late int totalCards;
  late int correctAnswers;

  @Index()
  late bool isCompleted;
  
  @Backlink(to: 'session')
  final answers = IsarLinks<StudyAnswerEntity>();
}