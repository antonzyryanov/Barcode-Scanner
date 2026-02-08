import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:flutter/material.dart';

class ResponsiveConfig {
  static const double mobileMaxWidth = 600;
  static const double tabletMinWidth = 600;
  static const double tabletMaxWidth = 1200;
  static const double desktopMinWidth = 1200;

  static double getResponsivePaddingHorizontal(BuildContext context) {
    const double mobilePadding = 16.0;
    const double tabletPadding = 32.0;
    const double desktopPadding = 40.0;

    final width = MediaQuery.of(context).size.width;
    if (width < mobileMaxWidth) {
      return mobilePadding;
    } else if (width < desktopMinWidth) {
      return tabletPadding;
    }
    return desktopPadding;
  }

  static double getResponsiveMaxWidth(BuildContext context) {
    const double mobileWidthMultiplier = 0.9;
    const double tabletWidthMultiplier = 0.8;
    const double desktopMaxWidth = 600;

    final width = MediaQuery.of(context).size.width;
    if (width < mobileMaxWidth) {
      return width * mobileWidthMultiplier;
    } else if (width < desktopMinWidth) {
      return width * tabletWidthMultiplier;
    }
    return desktopMaxWidth;
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

  static double getImageHeight(BuildContext context) {
    const double mobileImageHeight = 250.0;
    const double tabletImageHeight = 400.0;
    const double desktopImageHeight = 400.0;

    final width = MediaQuery.of(context).size.width;
    if (width < mobileMaxWidth) {
      return mobileImageHeight;
    } else if (width < desktopMinWidth) {
      return tabletImageHeight;
    }
    return desktopImageHeight;
  }
}
