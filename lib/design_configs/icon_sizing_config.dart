import 'package:flutter/material.dart';

class IconSizingConfig {
  static const double iconSmall = 24.0;
  static const double iconMedium = 32.0;
  static const double iconLarge = 48.0;
  static const double iconXLarge = 64.0;
  static const double iconXXLarge = 96.0;

  static const double appBarIconSize = 24.0;
  static const double dialogIconSize = 64.0;
  static const double errorIconSize = 64.0;
  static const double loadingIndicatorSize = 150.0;

  static double getHandbookCellImageSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width >= 600 && width < 1200) {
      return iconXXLarge * 4;
    }
    return iconXXLarge;
  }
}
