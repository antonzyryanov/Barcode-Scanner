import 'package:anton_zyryanov_barcode_scanner/theme/icon_sizing_config.dart';
import 'package:flutter/material.dart';

class ResponsiveConfig {
  static const double mobileMaxWidth = 600;
  static const double tabletMinWidth = 600;
  static const double tabletMaxWidth = 1200;
  static const double desktopMinWidth = 1200;

  static double getResponsivePaddingHorizontal(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileMaxWidth) {
      return 16.0; // Mobile
    } else if (width < desktopMinWidth) {
      return 32.0; // Tablet
    }
    return 40.0; // Desktop
  }

  static double getResponsiveMaxWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileMaxWidth) {
      return width * 0.9; // Mobile
    } else if (width < desktopMinWidth) {
      return width * 0.8; // Tablet
    }
    return 600; // Desktop
  }

  static bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletMinWidth;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileMaxWidth;
  }

  static double getLogoSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < mobileMaxWidth) {
      return IconSizingConfig.iconLarge;
    } else if (width < desktopMinWidth) {
      return IconSizingConfig.iconXLarge;
    }
    return IconSizingConfig.iconXXLarge;
  }
}
