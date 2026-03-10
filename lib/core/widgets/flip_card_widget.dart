import 'dart:math';
import 'package:flutter/material.dart';

/// A universal flip card widget that can be used in different contexts.
/// Supports both manual flip control and internal state management.
class FlipCardWidget extends StatefulWidget {
  // Animation constants
  static const double rotationDivisor = 1000.0;
  static const double widthMultiplier = 0.9;
  static const double heightMultiplier = 0.85;
  static const double minCardWidth = 200.0;
  static const double maxCardWidth = 500.0;
  static const double halfPi = pi / 2;
  static const double matrixPerspectiveValue = 0.001;

  // Default gradient colors will be generated from theme

  /// The text to display on the front of the card
  final String frontText;

  /// The text to display on the back of the card
  final String backText;

  /// Whether to show the back side of the card
  /// If null, the widget manages its own flip state internally
  final bool? showBack;

  /// Callback when the card is tapped
  /// If null, the widget will handle flipping internally
  final VoidCallback? onTap;

  /// Callback when the card is dragged horizontally
  final Function(DragUpdateDetails)? onHorizontalDragUpdate;

  /// Callback when the horizontal drag ends
  final Function(DragEndDetails)? onHorizontalDragEnd;

  /// Current drag offset for swipe animations
  final double dragOffset;

  /// Whether the card is currently animating (for swipe)
  final bool isAnimating;

  /// Animation controller for external animation control
  final AnimationController? animationController;

  /// Animation value for external animation control
  final Animation<double>? animation;

  /// Width of the card. If null, will use responsive sizing
  final double? width;

  /// Height of the card. If null, will use responsive sizing
  final double? height;

  /// Whether to show elevation/shadow
  final bool showElevation;

  /// Border radius of the card
  final double borderRadius;

  /// Padding inside the card
  final EdgeInsetsGeometry padding;

  /// Font size for the front text
  final double frontFontSize;

  /// Font size for the back text
  final double backFontSize;

  /// Duration of the flip animation
  final Duration flipDuration;

  /// Curve for the flip animation
  final Curve flipCurve;

  /// Whether the card is draggable (for swipe gestures)
  final bool isDraggable;

  /// Gradient colors for the front side of the card
  /// If null, uses default front gradient based on theme
  final List<Color>? frontGradientColors;

  /// Gradient colors for the back side of the card
  /// If null, uses default back gradient based on theme
  final List<Color>? backGradientColors;

  /// Creates a FlipCardWidget
  const FlipCardWidget({
    super.key,
    required this.frontText,
    required this.backText,
    this.showBack,
    this.onTap,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.dragOffset = 0.0,
    this.isAnimating = false,
    this.animationController,
    this.animation,
    this.width,
    this.height,
    this.showElevation = true,
    this.borderRadius = 20.0,
    this.padding = const EdgeInsets.all(24.0),
    this.frontFontSize = 24.0,
    this.backFontSize = 18.0,
    this.flipDuration = const Duration(milliseconds: 500),
    this.flipCurve = Curves.easeInOut,
    this.isDraggable = false,
    this.frontGradientColors,
    this.backGradientColors,
  });

  /// Creates a FlipCardWidget for session use (with swipe functionality)
  factory FlipCardWidget.forSession({
    Key? key,
    required String frontText,
    required String backText,
    required bool showBack,
    required double dragOffset,
    required bool isAnimating,
    required AnimationController animationController,
    required Animation<double> animation,
    required VoidCallback onTap,
    required Function(DragUpdateDetails) onHorizontalDragUpdate,
    required Function(DragEndDetails) onHorizontalDragEnd,
    double? width,
    double? height,
    double borderRadius = 20.0,
    EdgeInsetsGeometry padding = const EdgeInsets.all(12.0),
    double frontFontSize = 26.0,
    double backFontSize = 26.0,
    List<Color>? frontGradientColors,
    List<Color>? backGradientColors,
  }) {
    return FlipCardWidget(
      key: key,
      frontText: frontText,
      backText: backText,
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
      borderRadius: borderRadius,
      padding: padding,
      frontFontSize: frontFontSize,
      backFontSize: backFontSize,
      isDraggable: true,
      frontGradientColors: frontGradientColors,
      backGradientColors: backGradientColors,
    );
  }

  /// Creates a FlipCardWidget for preview use (simple tap to flip)
  factory FlipCardWidget.forPreview({
    Key? key,
    required String frontText,
    required String backText,
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
    return FlipCardWidget(
      key: key,
      frontText: frontText,
      backText: backText,
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

  @override
  State<FlipCardWidget> createState() => _FlipCardWidgetState();
}

class _FlipCardWidgetState extends State<FlipCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _internalController;
  late Animation<double> _internalAnimation;
  bool _isFront = true;

  /// Whether the widget manages its own flip state
  bool get _isSelfManaged => widget.showBack == null;

  /// Current animation controller to use
  AnimationController get _controller =>
      widget.animationController ?? _internalController;

  /// Current animation to use
  Animation<double> get _animation => widget.animation ?? _internalAnimation;

  /// Whether to show the back side
  bool get _showBack {
    if (!_isSelfManaged) {
      return widget.showBack!;
    }
    return !_isFront;
  }

  @override
  void initState() {
    super.initState();

    // Initialize internal animation controller if not provided externally
    if (widget.animationController == null) {
      _internalController = AnimationController(
        duration: widget.flipDuration,
        vsync: this,
      );

      _internalAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _internalController, curve: widget.flipCurve),
      );
    }
  }

  @override
  void dispose() {
    // Only dispose internal controller if we created it
    if (widget.animationController == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  void _handleTap() {
    if (widget.onTap != null) {
      widget.onTap!();
    } else if (_isSelfManaged) {
      _toggleFlip();
    }
  }

  void _toggleFlip() {
    if (_isFront) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    setState(() => _isFront = !_isFront);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      onHorizontalDragUpdate: widget.isDraggable
          ? widget.onHorizontalDragUpdate
          : null,
      onHorizontalDragEnd: widget.isDraggable
          ? widget.onHorizontalDragEnd
          : null,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              // Calculate offset and rotation for swipe animations
              final offset = widget.isAnimating
                  ? _animation.value
                  : widget.dragOffset;
              final rotation = offset / FlipCardWidget.rotationDivisor;

              return Transform.translate(
                offset: Offset(offset, 0),
                child: Transform.rotate(
                  angle: rotation,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(
                      begin: _showBack ? 1.0 : 0.0,
                      end: _showBack ? 1.0 : 0.0,
                    ),
                    duration: widget.flipDuration,
                    builder: (context, value, child) {
                      final angle = value * pi; // π radians for 180 degrees
                      final isFlipped = angle > FlipCardWidget.halfPi; // π/2

                      // Calculate responsive dimensions
                      final cardWidth =
                          widget.width ??
                          (constraints.maxWidth *
                                  FlipCardWidget.widthMultiplier)
                              .clamp(
                                FlipCardWidget.minCardWidth,
                                FlipCardWidget.maxCardWidth,
                              );
                      final cardHeight =
                          widget.height ??
                          constraints.maxHeight *
                              FlipCardWidget.heightMultiplier;

                      return Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.identity()
                          ..setEntry(
                            3,
                            2,
                            FlipCardWidget.matrixPerspectiveValue,
                          )
                          ..rotateY(angle),
                        child: _buildCardContent(
                          context: context,
                          width: cardWidth,
                          height: cardHeight,
                          isFlipped: isFlipped,
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

  Widget _buildCardContent({
    required BuildContext context,
    required double width,
    required double height,
    required bool isFlipped,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    // Build the card container
    Widget cardContent = Container(
      width: width,
      height: height,
      padding: widget.padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: _getGradientColors(colorScheme, isFlipped),
        ),
        boxShadow: widget.showElevation
            ? [
                BoxShadow(
                  color: colorScheme.shadow.withValues(alpha: 0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Center(
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateY(isFlipped ? pi : 0), // Flip text back if needed
          child: Text(
            isFlipped ? widget.backText : widget.frontText,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: isFlipped ? widget.backFontSize : widget.frontFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );

    // Wrap with Card widget if showElevation is true (for preview mode)
    if (widget.showElevation && !widget.isDraggable) {
      return Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
        child: cardContent,
      );
    }

    return cardContent;
  }

  /// Returns the appropriate gradient colors based on card side and customization
  List<Color> _getGradientColors(ColorScheme colorScheme, bool isFlipped) {
    // Use custom gradients if provided
    if (isFlipped && widget.backGradientColors != null) {
      return widget.backGradientColors!;
    }
    if (!isFlipped && widget.frontGradientColors != null) {
      return widget.frontGradientColors!;
    }

    // Default gradients with clear visual differentiation
    if (isFlipped) {
      // Back side (answer) - use tertiary colors for better contrast
      return [
        colorScheme.tertiaryContainer,
        colorScheme.tertiaryContainer.withValues(alpha: 0.8),
      ];
    } else {
      // Front side (question) - use primary container colors
      return [
        colorScheme.primaryContainer,
        colorScheme.primaryContainer.withValues(alpha: 0.8),
      ];
    }
  }
}
