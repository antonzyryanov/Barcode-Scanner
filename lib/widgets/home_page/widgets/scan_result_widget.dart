import 'package:anton_zyryanov_barcode_scanner/theme/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/typography_config.dart';
import 'package:flutter/material.dart';

class ScanResultWidget extends StatelessWidget {
  const ScanResultWidget({super.key, required this.result});

  final String result;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            textAlign: TextAlign.center,
            'Result: $result',
            style: TypographyConfig.headingMedium.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: SpacingConfig.spacing16),
          const SizedBox(
            width: IconSizingConfig.loadingIndicatorSize * 0.67,
            height: IconSizingConfig.loadingIndicatorSize * 0.67,
            child: CircularProgressIndicator(
              strokeWidth: 6,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
