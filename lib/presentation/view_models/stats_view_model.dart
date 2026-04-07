import 'package:bookexample/data/models/user_stats/user_stats_entity.dart';
import 'package:bookexample/domain/repositories/stats_repository.dart';
import 'package:bookexample/presentation/view_models/base_view_model.dart';

class StatsViewModel extends BaseViewModel {
  final StatsRepository repository;

  StatsViewModel(this.repository);

  Future<UserStatsEntity> getStats() async {
    return executeAsync(
      () => repository.getStats(),
      operationName: 'Get stats',
    );
  }

  Future<void> updateStats(
    int sessionTotalCard,
    int sessionCorrectAnswers,
    DateTime sessionDate,
  ) async {
    await executeAsync(
      () => repository.updateStats(
        sessionTotalCard,
        sessionCorrectAnswers,
        sessionDate,
      ),
      operationName: 'Update stats',
    );
  }

  Future<int> getStreak() async {
    return executeAsync(
      () => repository.calculateStreak(),
      operationName: 'Get streak',
    );
  }
}
