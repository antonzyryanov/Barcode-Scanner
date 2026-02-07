import 'package:flutter/material.dart';

class AnimatedButtonWidget extends StatefulWidget {
  const AnimatedButtonWidget({
    super.key,
    required this.child,
    required this.onPressed,
  });

  final Widget child;
  final VoidCallback onPressed;

  @override
  State<AnimatedButtonWidget> createState() => _AnimatedButtonWidgetState();
}

class _AnimatedButtonWidgetState extends State<AnimatedButtonWidget>
    with SingleTickerProviderStateMixin {
  static const int animationTimeMS = 100;
  static const double tappedButtonScaleFactor = 1.10;
  static const int onTapDelayToShowAnimationMS = 250;

  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: animationTimeMS),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: tappedButtonScaleFactor,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
    Future.delayed(
      const Duration(milliseconds: onTapDelayToShowAnimationMS),
      () {
        widget.onPressed();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: ElevatedButton(onPressed: _handleTap, child: widget.child),
    );
  }
}
