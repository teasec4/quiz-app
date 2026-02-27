import 'package:bookexample/core/service_locator.dart';
import 'package:bookexample/domain/isar_model/library/deck_entity.dart';
import 'package:bookexample/domain/repositories/library_repository.dart';
import 'package:bookexample/pages/library/folder/deck/widgets/flip_card.dart';
import 'package:bookexample/pages/library/folder/deck/widgets/study_mode_tile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DeckPage extends StatefulWidget {
  final int folderId;
  final int deckId;
  const DeckPage({super.key, required this.folderId, required this.deckId});

  @override
  State<DeckPage> createState() => _DeckPageState();
}

class _DeckPageState extends State<DeckPage>
    with SingleTickerProviderStateMixin {
  int currentCardIndex = 0;
  late ScrollController _scrollController;
  double _scrollOffset = 0;
  late Future<DeckEntity> _deckFuture;
  late List<StudyMode> studyModes;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _deckFuture = getIt<LibraryRepository>().getDeckById(widget.deckId);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildCardCarousel(List cards) {
    return SizedBox.expand(
      child: PageView.builder(
        onPageChanged: (index) {
          setState(() => currentCardIndex = index);
        },
        itemCount: cards.length,
        itemBuilder: (context, index) {
          final card = cards[index];
          return Padding(
            padding: const EdgeInsets.all(24),
            child: FlipCard(front: card.front, back: card.back),
          );
        },
      ),
    );
  }

  Widget _buildCardStack(int cardCount) {
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
                      colors: [
                        Theme.of(context).colorScheme.primary.withOpacity(0.6),
                        Theme.of(context).colorScheme.primary,
                      ],
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.style,
                          color: Theme.of(context).colorScheme.primary,
                          size: 32,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '$cardCount cards',
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

    return FutureBuilder<DeckEntity>(
      future: _deckFuture,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final deck = snapshot.data!;
        final cards = deck.cards.toList();
        final studyModes = [
          StudyMode(
            title: 'Flashcards',
            subtitle: '${cards.length} cards',
            icon: Icons.style,
            onTap: () {
              context.go(
                '/study/session/${widget.folderId}/${widget.deckId}',
              );
            },
          ),
          StudyMode(
            title: 'Multiple Choice',
            subtitle: '${cards.length} questions',
            icon: Icons.check_circle_outline,
            disabled: true,
          ),
          StudyMode(
            title: 'Write Answer',
            subtitle: '${cards.length} questions',
            icon: Icons.edit,
            disabled: true,
          ),
          StudyMode(
            title: 'Matching',
            subtitle: 'Pair terms',
            icon: Icons.connect_without_contact,
            disabled: true,
          ),
        ];

        return Scaffold(
          appBar: AppBar(
            title: Text(deck.title),
          ),
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
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.surfaceContainerLow,
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
                              child: _buildCardStack(cards.length),
                            )
                          : SizedBox.expand(
                              key: const ValueKey('carousel'),
                              child: _buildCardCarousel(cards),
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
                                cards.length,
                                (index) => Container(
                                  width: 8,
                                  height: 8,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
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
                    final mode = studyModes[index];

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      child: ModeTile(mode: mode),
                    );
                  }, childCount: studyModes.length),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
