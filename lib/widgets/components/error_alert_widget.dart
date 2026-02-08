import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/responsive_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_button_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_fade_slide_widget.dart';
import 'package:flutter/material.dart';

class ErrorAlertWidget extends StatelessWidget {
  const ErrorAlertWidget({
    super.key,
    required this.error,
    required this.onClose,
  });

  final String error;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveConfig.isMobile(context);
    final padding = isMobile
        ? ContainerSpacing.dialogPaddingSmall
        : ContainerSpacing.dialogPaddingLarge;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: AppTheme.dialogBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.primary, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: ShadowColors.shadow,
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedFadeSlideWidget(
              child: SizedBox(
                width: IconSizingConfig.dialogIconSize,
                height: IconSizingConfig.dialogIconSize,
                child: Image.asset(
                  'assets/error_icon.png',
                  width: IconSizingConfig.dialogIconSize,
                  height: IconSizingConfig.dialogIconSize,
                ),
              ),
            ),
            SizedBox(height: SmallSpacing.spacing16),
            AnimatedFadeSlideWidget(
              delay: const Duration(milliseconds: 100),
              child: Text(
                AppLocalizations.of(context).errorTitle,
                style: HeadingStyles.headingSmall.copyWith(
                  color: DarkThemeColors.textPrimaryDark,
                ),
              ),
            ),
            SizedBox(height: SmallSpacing.spacing12),
            AnimatedFadeSlideWidget(
              delay: const Duration(milliseconds: 200),
              child: Text(
                error,
                textAlign: TextAlign.center,
                style: BodyTextStyles.bodySmall.copyWith(
                  color: DarkThemeColors.textSecondaryDark,
                ),
              ),
            ),
            SizedBox(height: MediumSpacing.spacing20),
            AnimatedFadeSlideWidget(
              delay: const Duration(milliseconds: 300),
              child: SizedBox(
                width: double.infinity,
                child: AnimatedButtonWidget(
                  onPressed: onClose,
                  child: Text(
                    AppLocalizations.of(context).ok,
                    style: const TextStyle(color: AppTheme.textOnButton),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
