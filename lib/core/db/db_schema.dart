import 'package:isar_community/isar.dart';
import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:bookexample/domain/isar_model/library/folder_entity.dart';
import 'package:bookexample/domain/isar_model/session/study_answer_entity.dart';
import 'package:bookexample/domain/isar_model/session/study_session_entity.dart';
import 'package:bookexample/domain/isar_model/user_stats/user_stats_entity.dart';

const List<CollectionSchema> dbSchema = [
  FolderEntitySchema,
  DeckEntitySchema,
  FlashCardEntitySchema,
  StudySessionEntitySchema,
  StudyAnswerEntitySchema,
  UserStatsEntitySchema,
];
