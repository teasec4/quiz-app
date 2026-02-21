import 'package:flutter/material.dart';

class DeckPage extends StatefulWidget {
  final String folderId;
  final String deckId;
  const DeckPage({super.key, required this.folderId, required this.deckId});

  @override
  State<DeckPage> createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> {
  int currentCardIndex = 0;
  final List<Map<String, String>> cards = [
    {'front': 'What is Flutter?', 'back': 'A cross-platform mobile framework'},
    {'front': 'What is Dart?', 'back': 'A programming language for Flutter'},
    {'front': 'What is Material Design?', 'back': 'Google design system'},
    {'front': 'What is a Widget?', 'back': 'Basic building block in Flutter'},
    {'front': 'What is State?', 'back': 'Data that determines widget behavior'},
  ];

  final List<Map<String, String>> testOptions = [
    {'title': 'Multiple Choice', 'subtitle': '5 questions', 'icon': 'check_circle'},
    {'title': 'Flashcards', 'subtitle': 'Learn mode', 'icon': 'style'},
    {'title': 'Write Answer', 'subtitle': '3 questions', 'icon': 'edit'},
    {'title': 'Matching', 'subtitle': 'Pair terms', 'icon': 'connect_without_contact'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(title: const Text("Biology Basics")),
      body: Column(
        children: [
          // Cards Carousel (50% of screen)
          SizedBox(
            height: screenHeight * 0.5,
            child: PageView.builder(
              onPageChanged: (index) {
                setState(() => currentCardIndex = index);
              },
              itemCount: cards.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(24),
                  child: GestureDetector(
                    child: Card(
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue.shade300,
                              Colors.blue.shade600,
                            ],
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              cards[index]['front'] ?? '',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 32),
                            Text(
                              cards[index]['back'] ?? '',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Progress indicator
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                cards.length,
                (index) => Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == currentCardIndex
                        ? Colors.blue
                        : Colors.grey[300],
                  ),
                ),
              ),
            ),
          ),
          // Test options (50% remaining)
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: testOptions.length,
              itemBuilder: (context, index) {
                final option = testOptions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: Icon(
                      _getIcon(option['icon'] ?? ''),
                      color: Colors.blue,
                      size: 28,
                    ),
                    title: Text(
                      option['title'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    subtitle: Text(option['subtitle'] ?? ''),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIcon(String iconName) {
    switch (iconName) {
      case 'check_circle':
        return Icons.check_circle_outline;
      case 'style':
        return Icons.style;
      case 'edit':
        return Icons.edit;
      case 'connect_without_contact':
        return Icons.connect_without_contact;
      default:
        return Icons.help_outline;
    }
  }
}
