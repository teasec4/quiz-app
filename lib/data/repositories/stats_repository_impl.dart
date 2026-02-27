import 'package:bookexample/domain/isar_model/user_stats/user_stats_entity.dart';
import 'package:bookexample/domain/repositories/stats_repository.dart';
import 'package:isar_community/isar.dart';

class StatsRepositoryImpl implements StatsRepository {
  final Isar isar;

  StatsRepositoryImpl({required this.isar});

  @override
  Future<UserStatsEntity> getStats() async {
    final stats = await isar.userStatsEntitys.get(0);
    if (stats != null) return stats;

    final newStats = UserStatsEntity()
      ..totalCards = 0
      ..correctAnswers = 0
      ..lastSessionDate = DateTime.now();

    await isar.writeTxn(() async {
      await isar.userStatsEntitys.put(newStats);
    });

    return newStats;
  }

  @override
  Future<void> updateStats(
    int sessionTotalCard,
    int sessionCorrectAnswers,
    DateTime sessionDate,
  ) async {
    await isar.writeTxn(() async {
      final stats = await getStats();

      stats.totalCards += sessionTotalCard;
      stats.correctAnswers += sessionCorrectAnswers;

      stats.lastSessionDate = sessionDate;

      await isar.userStatsEntitys.put(stats);
    });
  }
}
