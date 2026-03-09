import 'package:bookexample/core/exceptions/app_exceptions.dart';
import 'package:bookexample/core/logging/app_logger.dart';
import 'package:bookexample/data/data_source.dart';
import 'package:bookexample/domain/base_repository.dart';
import 'package:bookexample/domain/isar_model/session/study_session_entity.dart';
import 'package:bookexample/domain/isar_model/user_stats/user_stats_entity.dart';
import 'package:bookexample/domain/repositories/stats_repository.dart';

class StatsRepositoryImpl extends BaseRepository implements StatsRepository {
  StatsRepositoryImpl(DataSource dataSource) : super(dataSource);

  @override
  Future<UserStatsEntity> getStats() async {
    try {
      final stats = await dataSource.get<UserStatsEntity>(0);
      if (stats != null) return stats;

      final newStats = UserStatsEntity()
        ..totalCards = 0
        ..correctAnswers = 0
        ..lastSessionDate = DateTime.now();

      await dataSource.executeTransaction(() async {
        await dataSource.insert<UserStatsEntity>(newStats);
      });

      AppLogger.info('Created new user stats entity');
      return newStats;
    } catch (e, stackTrace) {
      AppLogger.error('Failed to get or create stats', e, stackTrace);
      throw DatabaseException(
        'Failed to get or create stats',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> updateStats(
    int sessionTotalCard,
    int sessionCorrectAnswers,
    DateTime sessionDate,
  ) async {
    // Validate input parameters
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

    try {
      await dataSource.executeTransaction(() async {
        final stats = await getStats();

        stats.totalCards += sessionTotalCard;
        stats.correctAnswers += sessionCorrectAnswers;
        stats.lastSessionDate = sessionDate;

        await dataSource.update<UserStatsEntity>(stats);
      });

      AppLogger.info(
        'Updated stats: +$sessionTotalCard cards, +$sessionCorrectAnswers correct',
      );
    } catch (e, stackTrace) {
      if (e is AppException) rethrow;
      AppLogger.error('Failed to update stats', e, stackTrace);
      throw DatabaseException(
        'Failed to update stats',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<int> calculateStreak() async {
    try {
      final allSessions = await dataSource.getAll<StudySessionEntity>();

      if (allSessions.isEmpty) return 0;

      // Отсортировать по дате убывающе (последние первыми)
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

          // Если сессия не сегодня и не вчера, streak = 0
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
    } catch (e, stackTrace) {
      AppLogger.error('Failed to calculate streak', e, stackTrace);
      throw DatabaseException(
        'Failed to calculate streak',
        originalError: e,
        stackTrace: stackTrace,
      );
    }
  }
}
