class SpacingConfig {
  static const MicroSpacing microSpacing = MicroSpacing();
  static const SmallSpacing smallSpacing = SmallSpacing();
  static const MediumSpacing mediumSpacing = MediumSpacing();
  static const LargeSpacing largeSpacing = LargeSpacing();
  static const ContainerSpacing containerSpacing = ContainerSpacing();
}

class MicroSpacing {
  const MicroSpacing();

  static const double spacing4 = 4.0;
  static const double spacing8 = 8.0;
}

class SmallSpacing {
  const SmallSpacing();

  static const double spacing12 = 12.0;
  static const double spacing16 = 16.0;
}

class MediumSpacing {
  const MediumSpacing();

  static const double spacing20 = 20.0;
  static const double spacing24 = 24.0;
}

class LargeSpacing {
  const LargeSpacing();

  static const double spacing32 = 32.0;
  static const double spacing40 = 40.0;
}

class ContainerSpacing {
  const ContainerSpacing();

  static const double dialogPaddingSmall = 20.0;
  static const double dialogPaddingLarge = 24.0;
  static const double containerPaddingHorizontal = 16.0;
  static const double containerPaddingVertical = 16.0;
}
