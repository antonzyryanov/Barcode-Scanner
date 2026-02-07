import 'package:anton_zyryanov_barcode_scanner/theme/animation_config.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/app_theme.dart';
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
    return Container(
      padding: const EdgeInsets.all(24),
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
              width: 64,
              height: 64,
              child: Image.asset(
                'assets/error_icon.png',
                width: 64,
                height: 64,
              ),
            ),
          ),
          const SizedBox(height: 16),
          AnimatedFadeSlideWidget(
            delay: const Duration(milliseconds: 100),
            child: const Text(
              'Error',
              style: TextStyle(
                color: AppTheme.textPrimaryDark,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 12),
          AnimatedFadeSlideWidget(
            delay: const Duration(milliseconds: 200),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: AppTheme.textSecondaryDark,
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
          const SizedBox(height: 20),
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
    );
  }
}
