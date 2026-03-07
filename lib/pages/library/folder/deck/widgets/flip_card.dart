import 'package:bookexample/core/widgets/flip_card_widget.dart';
import 'package:flutter/material.dart';

class FlipCard extends StatelessWidget {
  final String front;
  final String back;

  const FlipCard({required this.front, required this.back, super.key});

  @override
  Widget build(BuildContext context) {
    return FlipCardWidget.forPreview(frontText: front, backText: back);
  }
}
