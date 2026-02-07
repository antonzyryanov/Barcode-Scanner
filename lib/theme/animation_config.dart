import 'package:flutter/material.dart';

class AnimationConfig {
  // Transition durations
  static const Duration pageTransitionDuration = Duration(milliseconds: 400);
  static const Duration widgetFadeDuration = Duration(milliseconds: 300);
  static const Duration buttonPressDuration = Duration(milliseconds: 150);
  static const Duration buttonReleaseDuration = Duration(milliseconds: 200);

  // Curves - нелинейные кривые для реалистичности
  static const Curve pageTransitionCurve = Curves.easeInOutCubic;
  static const Curve fadeInCurve = Curves.easeIn;
  static const Curve fadeOutCurve = Curves.easeOut;
  static const Curve buttonPressCurve = Curves.easeOutBack;
  static const Curve buttonReleaseCurve = Curves.elasticOut;
  static const Curve slideUpCurve = Curves.easeOutCubic;

  // Animation parameters
  static const double slideOffset = 0.15;
  static const double buttonScalePressed = 0.92;
  static const double buttonScaleReleased = 1.0;
}

/// Обёртка для плавного появления виджетов с fade и slide эффектом
class AnimatedFadeSlideWidget extends StatefulWidget {
  const AnimatedFadeSlideWidget({
    super.key,
    required this.child,
    this.delay = Duration.zero,
  });

  final Widget child;
  final Duration delay;

  @override
  State<AnimatedFadeSlideWidget> createState() =>
      _AnimatedFadeSlideWidgetState();
}

class _AnimatedFadeSlideWidgetState extends State<AnimatedFadeSlideWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AnimationConfig.widgetFadeDuration,
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: AnimationConfig.fadeInCurve,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: AnimationConfig.slideUpCurve,
          ),
        );

    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(position: _slideAnimation, child: widget.child),
    );
  }
}
