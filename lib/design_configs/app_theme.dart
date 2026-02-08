import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Colors.red;
  static const Color secondary = Colors.white;

  static const Color background = Colors.black;
  static const Color dialogBackground = Colors.white;
  static const Color loaderBackground = Colors.black;

  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Colors.white70;
  static const Color textTertiary = Colors.white60;

  static const DarkThemeColors darkThemeColors = DarkThemeColors();

  static const Color buttonBackground = Colors.white;
  static const Color textOnButton = Colors.black;

  static const Color iconPrimary = Colors.white;
  static const Color iconSecondary = Colors.white70;

  static const StatusColors statusColors = StatusColors();
  static const UtilityColors utilityColors = UtilityColors();
  static const ShadowColors shadowColors = ShadowColors();
  static const BorderColors borderColors = BorderColors();
}

class DarkThemeColors {
  const DarkThemeColors();

  static const Color textPrimaryDark = Colors.black;
  static const Color textSecondaryDark = Colors.black54;
  static const Color textTertiaryDark = Colors.black38;
}

class StatusColors {
  const StatusColors();

  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  static const Color warning = Color(0xFFF57C00);
  static const Color info = Color(0xFF1976D2);
}

class UtilityColors {
  const UtilityColors();

  static const Color transparent = Colors.transparent;
  static const Color errorPlaceholder = Color(0xFFE0E0E0);
}

class ShadowColors {
  const ShadowColors();

  static const Color shadow = Colors.black54;
  static const Color shadowLight = Colors.black26;
}

class BorderColors {
  const BorderColors();

  static const Color borderColor = Colors.white24;
  static const Color borderColorDark = Colors.black12;
}
