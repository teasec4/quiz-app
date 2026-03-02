import 'package:bookexample/domain/isar_model/session/study_session_entity.dart';
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

  @override
  Future<int> calculateStreak() async {
    final allSessions = await isar.studySessionEntitys.where().findAll();

    if (allSessions.isEmpty) return 0;

    // Отсортировать по дате убывающе (последние первыми)
    final sorted = allSessions..sort((a, b) => b.endedAt.compareTo(a.endedAt));

    int streak = 0;
    DateTime? lastDate;

    for (final session in sorted) {
      final sessionDate = DateTime(session.endedAt.year, session.endedAt.month, session.endedAt.day);

      if (lastDate == null) {
        lastDate = sessionDate;
        final today = DateTime.now();
        final todayDate = DateTime(today.year, today.month, today.day);

        // Если сессия не сегодня и не вчера, streak = 0
        if (sessionDate != todayDate && sessionDate != todayDate.subtract(const Duration(days: 1))) {
          break;
        }
        streak = 1;
      } else {
        final expectedDate = lastDate.subtract(const Duration(days: 1));
        if (sessionDate == expectedDate) {
          streak++;
          lastDate = sessionDate;
        } else {
          break;
        }
      }
    }

    return streak;
  }
}
