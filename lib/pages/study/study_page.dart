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
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Continue Last Session
          _ModeCard(
            icon: Icons.play_arrow,
            title: 'Continue Last Session',
            subtitle: 'Resume where you left off',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Loading last session...')),
              );
            },
          ),
          const SizedBox(height: 12),

          // Start New Session
          _ModeCard(
            icon: Icons.spa_sharp,
            title: 'Start New Session',
            subtitle: 'Begin a fresh study session',
            onTap: () {
              _showFolderSelectionDialog(context);
            },
          ),
          const SizedBox(height: 12),

          // Review Mistakes
          _ModeCard(
            icon: Icons.refresh,
            title: 'Review Mistakes',
            subtitle: 'Study cards you got wrong',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Loading mistake review...')),
              );
            },
          ),
          const SizedBox(height: 12),

          // Random Cards
          _ModeCard(
            icon: Icons.shuffle,
            title: 'Start Random 10 Cards',
            subtitle: 'Quick random study session',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Starting random session...')),
              );
            },
          ),
          const SizedBox(height: 12),

          // Study by Folder
          _ModeCard(
            icon: Icons.folder_open,
            title: 'Study by Folder',
            subtitle: 'Choose a folder to study from',
            onTap: () {
              _showFolderSelectionDialog(context);
            },
          ),
        ],
      ),
    );
  }

  void _showFolderSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Folder'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            children: [
              _FolderTile(
                name: 'English',
                deckCount: 5,
                onTap: () {
                  Navigator.pop(context);
                  _showDeckSelectionDialog(context, 'English');
                },
              ),
              _FolderTile(
                name: 'Mathematics',
                deckCount: 3,
                onTap: () {
                  Navigator.pop(context);
                  _showDeckSelectionDialog(context, 'Mathematics');
                },
              ),
              _FolderTile(
                name: 'Science',
                deckCount: 4,
                onTap: () {
                  Navigator.pop(context);
                  _showDeckSelectionDialog(context, 'Science');
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  void _showDeckSelectionDialog(BuildContext context, String folderName) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Select Deck from $folderName'),
        content: SizedBox(
          width: double.maxFinite,
          child: ListView(
            children: [
              _DeckTile(
                name: 'Vocabulary',
                cardCount: 25,
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Starting $folderName - Vocabulary')),
                  );
                },
              ),
              _DeckTile(
                name: 'Grammar',
                cardCount: 18,
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Starting $folderName - Grammar')),
                  );
                },
              ),
              _DeckTile(
                name: 'Phrases',
                cardCount: 12,
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Starting $folderName - Phrases')),
                  );
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}

class _ModeCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ModeCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

class _FolderTile extends StatelessWidget {
  final String name;
  final int deckCount;
  final VoidCallback onTap;

  const _FolderTile({
    required this.name,
    required this.deckCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.folder),
      title: Text(name),
      subtitle: Text('$deckCount decks'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}

class _DeckTile extends StatelessWidget {
  final String name;
  final int cardCount;
  final VoidCallback onTap;

  const _DeckTile({
    required this.name,
    required this.cardCount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.layers),
      title: Text(name),
      subtitle: Text('$cardCount cards'),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
