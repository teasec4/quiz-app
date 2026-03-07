import 'package:bookexample/domain/isar_model/user_stats/user_stats_entity.dart';
import 'package:bookexample/view_models/stats_view_model.dart';
import 'package:bookexample/pages/study/widgets/deck_selector.dart';
import 'package:bookexample/pages/study/widgets/mode_tile.dart';
import 'package:bookexample/pages/study/widgets/stats_header.dart';
import 'package:bookexample/core/widgets/loading_overlay_widget.dart';
import 'package:bookexample/core/widgets/error_banner_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  late Future<UserStatsEntity> _statsFuture;
  late Future<int> _streakFuture;

  @override
  void initState() {
    super.initState();
    final vm = context.read<StatsViewModel>();
    _statsFuture = vm.getStats();
    _streakFuture = vm.getStreak();
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<StatsViewModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Study')),
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Stats',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              FutureBuilder<UserStatsEntity>(
                future: _statsFuture,
                builder: (context, statsSnapshot) {
                  final stats = statsSnapshot.data;
                  return FutureBuilder<int>(
                    future: _streakFuture,
                    builder: (context, streakSnapshot) {
                      final streakDays = streakSnapshot.data ?? 0;
                      return StatsHeader(
                        totalLearnedCards: stats?.totalCards ?? 0,
                        accuracyRate: stats?.accuracyRate ?? 0.0,
                        streakDays: streakDays,
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 32),
              Text(
                'Study Modes',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              // Start New Session
              ModeCard(
                icon: Icons.book,
                title: 'Start New Session',
                subtitle: 'Begin a fresh study session',
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => SafeArea(
                      child: DeckSelector(
                        onDeckSelected: (deckId, folderId) {
                          Navigator.pop(context);
                          context.go('/study/session/$folderId/$deckId');
                        },
                      ),
                    ),
                    isScrollControlled: true,
                    useRootNavigator: true,
                  );
                },
              ),
              const SizedBox(height: 12),
              // Random Cards
              ModeCard(
                icon: Icons.shuffle,
                title: 'Start Random 10 Cards',
                subtitle: 'Quick random study session',
                onTap: () {},
                disabled: true,
              ),
            ],
          ),
          if (vm.isLoading) LoadingOverlayWidget.scrim(opacity: 0.3),
          if (vm.hasError && vm.error != null)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: ErrorBannerWidget.fromError(
                error: vm.error!,
                onClose: vm.clearError,
                onTap: () {
                  // Retry loading stats
                  setState(() {});
                },
              ),
            ),
        ],
      ),
    );
  }
}
