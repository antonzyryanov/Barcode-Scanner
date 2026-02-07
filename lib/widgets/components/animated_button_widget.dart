import 'package:anton_zyryanov_barcode_scanner/theme/animation_config.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/app_theme.dart';
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
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AnimationConfig.buttonPressDuration,
      reverseDuration: AnimationConfig.buttonReleaseDuration,
      vsync: this,
    );

    _scaleAnimation =
        Tween<double>(
          begin: AnimationConfig.buttonScaleReleased,
          end: AnimationConfig.buttonScalePressed,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: AnimationConfig.buttonPressCurve,
            reverseCurve: AnimationConfig.buttonReleaseCurve,
          ),
        );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (!_isPressed) {
      setState(() => _isPressed = true);
      _controller.forward();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    _handleRelease();
  }

  void _handleTapCancel() {
    _handleRelease();
  }

  void _handleRelease() {
    if (_isPressed) {
      setState(() => _isPressed = false);
      _controller.reverse();
    }
  }

  void _handleTap() {
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: ElevatedButton(
          onPressed: null, // GestureDetector handles tap
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: AppTheme.buttonBackground,
            disabledForegroundColor: AppTheme.buttonBackground,
          ),
          child: widget.child,
        ),
      ),
    );
  }
}
