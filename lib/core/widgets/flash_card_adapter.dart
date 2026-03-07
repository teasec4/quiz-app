import 'package:bookexample/domain/isar_model/library/flashcard_entity.dart';
import 'package:flutter/material.dart';
import 'flip_card_widget.dart';

/// Adapter utility for converting FlashCardEntity to FlipCardWidget
class FlashCardAdapter {
  /// Creates a FlipCardWidget for session use from a FlashCardEntity
  static FlipCardWidget forSession({
    required FlashCardEntity card,
    required bool showBack,
    required double dragOffset,
    required bool isAnimating,
    required AnimationController animationController,
    required Animation<double> animation,
    required VoidCallback onTap,
    required Function(DragUpdateDetails) onHorizontalDragUpdate,
    required Function(DragEndDetails) onHorizontalDragEnd,
    Key? key,
    double? width,
    double? height,
    double borderRadius = 20.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(12.0),
    double frontFontSize = 26.0,
    double backFontSize = 26.0,
    List<Color>? frontGradientColors,
    List<Color>? backGradientColors,
  }) {
    return FlipCardWidget.forSession(
      key: key,
      frontText: card.front,
      backText: card.back,
      showBack: showBack,
      dragOffset: dragOffset,
      isAnimating: isAnimating,
      animationController: animationController,
      animation: animation,
      onTap: onTap,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      width: width,
      height: height,
      borderRadius: borderRadius,
      padding: padding,
      frontFontSize: frontFontSize,
      backFontSize: backFontSize,
      frontGradientColors: frontGradientColors,
      backGradientColors: backGradientColors,
    );
  }

  /// Creates a FlipCardWidget for preview use from a FlashCardEntity
  static FlipCardWidget forPreview({
    required FlashCardEntity card,
    Key? key,
    double? width,
    double? height,
    bool showElevation = true,
    double borderRadius = 16.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24.0),
    double frontFontSize = 24.0,
    double backFontSize = 18.0,
    Duration flipDuration = const Duration(milliseconds: 500),
    Curve flipCurve = Curves.easeInOut,
    List<Color>? frontGradientColors,
    List<Color>? backGradientColors,
  }) {
    return FlipCardWidget.forPreview(
      key: key,
      frontText: card.front,
      backText: card.back,
      width: width,
      height: height,
      showElevation: showElevation,
      borderRadius: borderRadius,
      padding: padding,
      frontFontSize: frontFontSize,
      backFontSize: backFontSize,
      flipDuration: flipDuration,
      flipCurve: flipCurve,
      frontGradientColors: frontGradientColors,
      backGradientColors: backGradientColors,
    );
  }

  /// Creates a simple FlipCardWidget from a FlashCardEntity with custom parameters
  static FlipCardWidget create({
    required FlashCardEntity card,
    Key? key,
    bool? showBack,
    VoidCallback? onTap,
    Function(DragUpdateDetails)? onHorizontalDragUpdate,
    Function(DragEndDetails)? onHorizontalDragEnd,
    double dragOffset = 0.0,
    bool isAnimating = false,
    AnimationController? animationController,
    Animation<double>? animation,
    double? width,
    double? height,
    bool showElevation = true,
    double borderRadius = 20.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(24.0),
    double frontFontSize = 24.0,
    double backFontSize = 18.0,
    Duration flipDuration = const Duration(milliseconds: 500),
    Curve flipCurve = Curves.easeInOut,
    bool isDraggable = false,
    List<Color>? frontGradientColors,
    List<Color>? backGradientColors,
  }) {
    return FlipCardWidget(
      key: key,
      frontText: card.front,
      backText: card.back,
      showBack: showBack,
      onTap: onTap,
      onHorizontalDragUpdate: onHorizontalDragUpdate,
      onHorizontalDragEnd: onHorizontalDragEnd,
      dragOffset: dragOffset,
      isAnimating: isAnimating,
      animationController: animationController,
      animation: animation,
      width: width,
      height: height,
      showElevation: showElevation,
      borderRadius: borderRadius,
      padding: padding,
      frontFontSize: frontFontSize,
      backFontSize: backFontSize,
      flipDuration: flipDuration,
      flipCurve: flipCurve,
      isDraggable: isDraggable,
      frontGradientColors: frontGradientColors,
      backGradientColors: backGradientColors,
    );
  }
}
