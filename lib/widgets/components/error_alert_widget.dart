import 'package:anton_zyryanov_barcode_scanner/theme/animation_config.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/responsive_config.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/typography_config.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_button_widget.dart';
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
        ? SpacingConfig.dialogPaddingSmall
        : SpacingConfig.dialogPaddingLarge;

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          color: AppTheme.dialogBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppTheme.primary, width: 1.5),
          boxShadow: const [
            BoxShadow(
              color: AppTheme.shadow,
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
            SizedBox(height: SpacingConfig.spacing16),
            AnimatedFadeSlideWidget(
              delay: const Duration(milliseconds: 100),
              child: Text(
                'Error',
                style: TypographyConfig.headingSmall.copyWith(
                  color: AppTheme.textPrimaryDark,
                ),
              ),
            ),
            SizedBox(height: SpacingConfig.spacing12),
            AnimatedFadeSlideWidget(
              delay: const Duration(milliseconds: 200),
              child: Text(
                error,
                textAlign: TextAlign.center,
                style: TypographyConfig.bodySmall.copyWith(
                  color: AppTheme.textSecondaryDark,
                ),
              ),
            ),
            SizedBox(height: SpacingConfig.spacing20),
            AnimatedFadeSlideWidget(
              delay: const Duration(milliseconds: 300),
              child: SizedBox(
                width: double.infinity,
                child: AnimatedButtonWidget(
                  onPressed: onClose,
                  child: const Text(
                    'OK',
                    style: TextStyle(color: AppTheme.textOnButton),
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
