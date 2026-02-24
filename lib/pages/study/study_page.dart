import 'package:bookexample/pages/study/widgets/mode_tile.dart';
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
      appBar: AppBar(
        title: const Text('Study'),
        
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Continue Last Session
          ModeCard(
            icon: Icons.play_arrow,
            title: 'Continue Last Session',
            subtitle: 'Resume where you left off',
            onTap: () {
              
            },
          ),
          const SizedBox(height: 12),

          // Start New Session
          ModeCard(
            icon: Icons.book,
            title: 'Start New Session',
            subtitle: 'Begin a fresh study session',
            onTap: () {
              
            },
          ),
          const SizedBox(height: 12),

          // Random Cards
          ModeCard(
            icon: Icons.shuffle,
            title: 'Start Random 10 Cards',
            subtitle: 'Quick random study session',
            onTap: () {
              
            },
          ),
          const SizedBox(height: 12),

          // Study by Folder
          ModeCard(
            icon: Icons.folder_open,
            title: 'Study by Folder',
            subtitle: 'Choose a folder to study from',
            onTap: () {
              
            },
          ),
        ],
      ),
    );
  }

}

