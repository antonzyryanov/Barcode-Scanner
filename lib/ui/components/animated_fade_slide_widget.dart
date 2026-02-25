import 'package:anton_zyryanov_barcode_scanner/design_configs/animation_config.dart';
import 'package:flutter/material.dart';

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
      duration: TransitionDurations.widgetFadeDuration,
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: AnimationCurves.fadeInCurve,
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.15), end: Offset.zero).animate(
          CurvedAnimation(
            parent: _controller,
            curve: AnimationCurves.slideUpCurve,
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
