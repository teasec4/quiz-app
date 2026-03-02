import 'package:bookexample/domain/isar_model/user_stats/user_stats_entity.dart';
import 'package:bookexample/domain/repositories/stats_repository.dart';
import 'package:flutter/foundation.dart';

class StatsViewModel extends ChangeNotifier {
  final StatsRepository repository;

  StatsViewModel(this.repository);

  Future<UserStatsEntity> getStats() async {
    final stats = await repository.getStats();
    return stats;
  }

  Future<void> updateStats(
    int sessionTotalCard,
    int sessionCorrectAnswers,
    DateTime sessionDate,
  ) async {
    await repository.updateStats(
      sessionTotalCard,
      sessionCorrectAnswers,
      sessionDate,
    );
    notifyListeners();
  }

  Future<int> getStreak() async {
    return repository.calculateStreak();
  }
}
