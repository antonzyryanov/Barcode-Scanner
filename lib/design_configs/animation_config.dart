import 'package:flutter/material.dart';

class AnimationConfig {
  static const TransitionDurations transitionDurations = TransitionDurations();
  static const AnimationCurves animationCurves = AnimationCurves();
  static const AnimationParameters animationParameters = AnimationParameters();
}

class TransitionDurations {
  const TransitionDurations();

  static const Duration pageTransitionDuration = Duration(milliseconds: 400);
  static const Duration widgetFadeDuration = Duration(milliseconds: 300);
  static const Duration buttonPressDuration = Duration(milliseconds: 150);
  static const Duration buttonReleaseDuration = Duration(milliseconds: 200);
}

class AnimationCurves {
  const AnimationCurves();

  static const Curve pageTransitionCurve = Curves.easeInOutCubic;
  static const Curve fadeInCurve = Curves.easeIn;
  static const Curve fadeOutCurve = Curves.easeOut;
  static const Curve buttonPressCurve = Curves.easeOutBack;
  static const Curve buttonReleaseCurve = Curves.elasticOut;
  static const Curve slideUpCurve = Curves.easeOutCubic;
}

class AnimationParameters {
  const AnimationParameters();

  static const double slideOffset = 0.15;
  static const double buttonScalePressed = 0.92;
  static const double buttonScaleReleased = 1.0;
}
