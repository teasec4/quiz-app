import 'package:bookexample/domain/isar_model/user_stats/user_stats_entity.dart';

abstract class StatsRepository {
  Future<UserStatsEntity> getStats();
  Future<void> updateStats(int sessionTotalCard, int sessionCorrectAnswers, DateTime sessionDate);
}
