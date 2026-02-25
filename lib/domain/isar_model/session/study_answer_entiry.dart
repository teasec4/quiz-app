import 'package:bookexample/domain/isar_model/session/study_session_entity.dart';
import 'package:isar_community/isar.dart';

@collection
class StudyAnswerEntity {
  Id id = Isar.autoIncrement;

  late int cardId;
  late bool isCorrect;
  late DateTime answeredAt;

  final session = IsarLink<StudySessionEntity>();
}