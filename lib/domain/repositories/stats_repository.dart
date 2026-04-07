import 'package:bookexample/data/models/user_stats/user_stats_entity.dart';

abstract class StatsRepository {
  Future<UserStatsEntity> getStats();
  Future<void> updateStats(
    int sessionTotalCard,
    int sessionCorrectAnswers,
    DateTime sessionDate,
  );
  Future<int> calculateStreak();
}
