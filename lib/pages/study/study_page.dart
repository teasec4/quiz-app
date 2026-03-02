import 'package:bookexample/core/service_locator.dart';
import 'package:bookexample/domain/isar_model/user_stats/user_stats_entity.dart';
import 'package:bookexample/pages/study/widgets/mode_tile.dart';
import 'package:bookexample/pages/study/widgets/stats_header.dart';
import 'package:bookexample/view_models/stats_view_model.dart';

import 'package:flutter/material.dart';


class StudyPage extends StatefulWidget {
  const StudyPage({super.key});

  @override
  State<StudyPage> createState() => _StudyPageState();
}

class _StudyPageState extends State<StudyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Study')),
      body: ListView(
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
           future: getIt<StatsViewModel>().getStats(),
           builder: (context, statsSnapshot) {
             final stats = statsSnapshot.data;
             return FutureBuilder<int>(
               future: getIt<StatsViewModel>().getStreak(),
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
            onTap: () {},
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
    );
  }
}
