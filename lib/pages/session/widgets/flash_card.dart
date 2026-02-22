import 'package:flutter/material.dart';

class FlashCard extends StatelessWidget {
  final Map<String, String> card;
  final bool showBack;
  final double dragOffset;
  final bool isAnimating;
  final Animation<double> animation;
  final AnimationController controller;
  final VoidCallback onTap;
  final Function(DragUpdateDetails) onDragUpdate;
  final Function(DragEndDetails) onDragEnd;

  const FlashCard({
    super.key,
    required this.card,
    required this.showBack,
    required this.dragOffset,
    required this.isAnimating,
    required this.animation,
    required this.controller,
    required this.onTap,
    required this.onDragUpdate,
    required this.onDragEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          final offset = isAnimating ? animation.value : dragOffset;
          final rotation = offset / 1000;

          return Transform.translate(
            offset: Offset(offset, 0),
            child: Transform.rotate(
              angle: rotation,
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: 380,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: showBack
                        ? [
                            Theme.of(context).colorScheme.secondary,
                            Theme.of(context).colorScheme.secondary
                          ]
                        : [
                            Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                            Theme.of(context).colorScheme.primary
                          ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    showBack ? card['back']! : card['front']!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
