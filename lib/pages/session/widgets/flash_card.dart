import 'package:bookexample/domain/models/flash_card.dart';
import 'package:flutter/material.dart';

class FlashCardWidget extends StatelessWidget {
  final FlashCard card;
  final bool showBack;
  final double dragOffset;
  final bool isAnimating;
  final Animation<double> animation;
  final AnimationController controller;
  final VoidCallback onTap;
  final Function(DragUpdateDetails) onDragUpdate;
  final Function(DragEndDetails) onDragEnd;

  const FlashCardWidget({
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
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              final offset = isAnimating ? animation.value : dragOffset;
              final rotation = offset / 1000;

              return Transform.translate(
                offset: Offset(offset, 0),
                child: Transform.rotate(
                  angle: rotation,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: showBack ? 1.0 : 0.0,
                      end: showBack ? 1.0 : 0.0,
                    ),
                    duration: const Duration(milliseconds: 400),
                    builder: (context, value, child) {
                      final angle =
                          value * 3.14159; // π radians for 180 degrees
                      final isFlipped = angle > 1.5708; // π/2

                      // Calculate responsive dimensions
                      final cardWidth = (constraints.maxWidth * 0.9).clamp(
                        200.0,
                        500.0,
                      );
                      final cardHeight = constraints.maxHeight * 0.85;

                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(3, 2, 0.001)
                          ..rotateY(angle),
                        child: Container(
                          width: cardWidth,
                          height: cardHeight,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: isFlipped
                                  ? [Colors.white, Colors.grey.shade200]
                                  : [Colors.white, Colors.grey.shade200],
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
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..rotateY(
                                  isFlipped ? 3.14159 : 0,
                                ), // Flip text back if needed
                              child: Text(
                                isFlipped ? card.back : card.front,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  color: Colors.black,
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
