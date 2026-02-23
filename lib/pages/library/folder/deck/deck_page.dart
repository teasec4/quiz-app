import 'package:bookexample/pages/library/folder/deck/widgets/flip_card.dart';
import 'package:bookexample/provider/mock_data_models.dart';
import 'package:bookexample/provider/mock_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class DeckPage extends StatefulWidget {
  final String folderId;
  final String deckId;
  const DeckPage({super.key, required this.folderId, required this.deckId});

  @override
  State<DeckPage> createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage> with SingleTickerProviderStateMixin {
  int currentCardIndex = 0;
  late ScrollController _scrollController;
  double _scrollOffset = 0;
  late Deck _deck;
  late List<FlashCard> _cards;

  final List<Map<String, String>> testOptions = [
    {
      'title': 'Multiple Choice',
      'subtitle': '5 questions',
      'icon': 'check_circle',
    },
    {'title': 'Flashcards', 'subtitle': 'Learn mode', 'icon': 'style'},
    {'title': 'Write Answer', 'subtitle': '3 questions', 'icon': 'edit'},
    {
      'title': 'Matching',
      'subtitle': 'Pair terms',
      'icon': 'connect_without_contact',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    
    // Get deck and cards from AppState
    final appState = context.read<AppState>();
    _deck = appState.getDeckById(widget.deckId)!;
    _cards = appState.getCardsByDeck(widget.deckId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildCardCarousel() {
    return SizedBox.expand(
      child: PageView.builder(
        onPageChanged: (index) {
          setState(() => currentCardIndex = index);
        },
        itemCount: _cards.length,
        itemBuilder: (context, index) {
          final card = _cards[index];
          return Padding(
            padding: const EdgeInsets.all(24),
            child: FlipCard(
              front: card.front,
              back: card.back,
            ),
          );
        },
      ),
    );
  }

  Widget _buildCardStack() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Стопка карточек
        for (int i = 2; i >= 0; i--)
          Transform.translate(
            offset: Offset(0, i * 8.0),
            child: Transform.scale(
              scale: 1 - (i * 0.05),
              child: Card(
                elevation: 4 * (3 - i).toDouble(),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: 200,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Theme.of(context).colorScheme.primary.withOpacity(0.6), Theme.of(context).colorScheme.primary],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.style, color: Theme.of(context).colorScheme.primary, size: 32),
                        const SizedBox(height: 8),
                        Text(
                           '${_cards.length} cards',
                           style: const TextStyle(
                             color: Colors.white,
                             fontSize: 14,
                             fontWeight: FontWeight.w600,
                           ),
                         ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final cardHeight = screenHeight * 0.5;
    bool isCollapsed = _scrollOffset > 0; // любой скрол = стопка

    return Scaffold(
      appBar: AppBar(title: Text(_deck.title)),
      body: NotificationListener<ScrollUpdateNotification>(
        onNotification: (notification) {
          // Только вертикальный скрол
          if (notification.metrics.axis == Axis.vertical) {
            setState(() {
              _scrollOffset = notification.metrics.pixels;
            });
          }
          return false;
        },
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Collapsible card carousel
            SliverAppBar(
              backgroundColor: Colors.transparent,
              pinned: false,
              floating: false,
              expandedHeight: cardHeight,
              automaticallyImplyLeading: false,
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.parallax,
                background: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: isCollapsed
                      ? SizedBox.expand(
                          key: const ValueKey('stack'),
                          child: _buildCardStack(),
                        )
                      : SizedBox.expand(
                          key: const ValueKey('carousel'),
                          child: _buildCardCarousel(),
                        ),
                ),
              ),
              // dots
              bottom: isCollapsed
                  ? null
                  : PreferredSize(
                      preferredSize: const Size.fromHeight(40),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                             _cards.length,
                             (index) => Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: index == currentCardIndex
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.grey[500],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ),
            // Test options list
                        SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final option = testOptions[index];
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 6,
                    ),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        gradient: LinearGradient(
                          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.primary.withOpacity(0.8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            context.go('/study/session/${widget.folderId}/${widget.deckId}');
                          },
                          borderRadius: BorderRadius.circular(12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.play_arrow,
                                color: Colors.white,
                                size: 28,
                              ),
                              const SizedBox(width: 12),
                              Text(
                                "Start Flashcards",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  child: Card(
                    color: Colors.grey.shade100,
                    child: ListTile(
                      leading: Icon(
                        _getIcon(option['icon'] ?? ''),
                        color: Theme.of(context).colorScheme.primary,
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
                  ),
                );
              }, childCount: testOptions.length),
            ),
          ],
        ),
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
