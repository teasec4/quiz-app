import 'package:bookexample/core/exceptions/app_exceptions.dart';
import 'package:bookexample/core/logging/app_logger.dart';
import 'package:bookexample/domain/base_repository.dart';
import 'package:bookexample/domain/isar_model/session/study_session_entity.dart';
import 'package:bookexample/domain/isar_model/user_stats/user_stats_entity.dart';
import 'package:bookexample/domain/repositories/stats_repository.dart';
import 'package:isar_community/isar.dart';

class StatsRepositoryImpl extends BaseRepository implements StatsRepository {
  StatsRepositoryImpl(super.isar);

  @override
  Future<UserStatsEntity> getStats() async {
    return await executeDbOperation(() async {
      final stats = await isar.userStatsEntitys.get(0);
      if (stats != null) return stats;

      final newStats = UserStatsEntity()
        ..totalCards = 0
        ..correctAnswers = 0
        ..lastSessionDate = DateTime.now();

      await isar.writeTxn(() async {
        await isar.userStatsEntitys.put(newStats);
      });

      AppLogger.info('Created new user stats entity');
      return newStats;
    }, 'getStats');
  }

  @override
  Future<void> updateStats(
    int sessionTotalCard,
    int sessionCorrectAnswers,
    DateTime sessionDate,
  ) async {
    if (sessionTotalCard < 0) {
      throw ValidationException('Invalid session data', {
        'sessionTotalCard': 'Total cards cannot be negative',
      });
    }

    if (sessionCorrectAnswers < 0) {
      throw ValidationException('Invalid session data', {
        'sessionCorrectAnswers': 'Correct answers cannot be negative',
      });
    }

    if (sessionCorrectAnswers > sessionTotalCard) {
      throw ValidationException('Invalid session data', {
        'sessionCorrectAnswers': 'Correct answers cannot exceed total cards',
      });
    }

    return await executeDbOperation(() async {
      await isar.writeTxn(() async {
        final stats = await getStats();

        stats.totalCards += sessionTotalCard;
        stats.correctAnswers += sessionCorrectAnswers;
        stats.lastSessionDate = sessionDate;

        await isar.userStatsEntitys.put(stats);
      });

      AppLogger.info(
        'Updated stats: +$sessionTotalCard cards, +$sessionCorrectAnswers correct',
      );
    }, 'updateStats');
  }

  @override
  Future<int> calculateStreak() async {
    return await executeDbOperation(() async {
      final allSessions = await isar.studySessionEntitys.where().findAll();

      if (allSessions.isEmpty) return 0;

      final sorted = allSessions
        ..sort((a, b) => b.endedAt.compareTo(a.endedAt));

      int streak = 0;
      DateTime? lastDate;

      for (final session in sorted) {
        final sessionDate = DateTime(
          session.endedAt.year,
          session.endedAt.month,
          session.endedAt.day,
        );

        if (lastDate == null) {
          lastDate = sessionDate;
          final today = DateTime.now();
          final todayDate = DateTime(today.year, today.month, today.day);

          if (sessionDate != todayDate &&
              sessionDate != todayDate.subtract(const Duration(days: 1))) {
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

      AppLogger.debug('Calculated streak: $streak days');
      return streak;
    }, 'calculateStreak');
  }
}
