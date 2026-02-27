import 'package:isar_community/isar.dart';

part 'user_stats_entity.g.dart';

@collection
class UserStatsEntity {
  Id id = 0; // singleton

  // all finished cards
  late int totalCards;

  late int correctAnswers;
  
  late DateTime lastSessionDate;
  
  double get accuracyRate =>
        totalCards == 0 ? 0 : correctAnswers / totalCards;
}
