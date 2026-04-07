import 'package:isar_community/isar.dart';
import 'package:bookexample/data/models/library/deck_entity.dart';
import 'package:bookexample/data/models/library/flashcard_entity.dart';
import 'package:bookexample/data/models/library/folder_entity.dart';
import 'package:bookexample/data/models/session/study_answer_entity.dart';
import 'package:bookexample/data/models/session/study_session_entity.dart';
import 'package:bookexample/data/models/user_stats/user_stats_entity.dart';

const List<CollectionSchema> dbSchema = [
  FolderEntitySchema,
  DeckEntitySchema,
  FlashCardEntitySchema,
  StudySessionEntitySchema,
  StudyAnswerEntitySchema,
  UserStatsEntitySchema,
];
