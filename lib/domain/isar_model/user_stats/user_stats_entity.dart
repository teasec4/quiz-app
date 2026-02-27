import 'package:isar_community/isar.dart';

@collection
class UserStatsEntity {
  Id id = 0; // singleton

  int totalReviewed = 0;
  int totalCorrect = 0;
  int currentStreak = 0;
  DateTime? lastStudyDate;
}