import 'package:bookexample/data/models/library/flashcard_entity.dart';
import 'package:bookexample/core/widgets/flash_card_adapter.dart';
import 'package:flutter/material.dart';

class FlashCardWidget extends StatelessWidget {
  final FlashCardEntity card;
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
    return FlashCardAdapter.forSession(
      card: card,
      showBack: showBack,
      dragOffset: dragOffset,
      isAnimating: isAnimating,
      animationController: controller,
      animation: animation,
      onTap: onTap,
      onHorizontalDragUpdate: onDragUpdate,
      onHorizontalDragEnd: onDragEnd,
    );
  }
}
