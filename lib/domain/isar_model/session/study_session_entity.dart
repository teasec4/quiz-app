import 'package:bookexample/domain/isar_model/session/study_answer_entiry.dart';
import 'package:isar_community/isar.dart';

@collection
class StudySessionEntity {
  Id id = Isar.autoIncrement;

  late int deckId;
  late DateTime startedAt;
  DateTime? finishedAt;

  final answers = IsarLinks<StudyAnswerEntity>();
}