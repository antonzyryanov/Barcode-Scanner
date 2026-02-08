import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
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
            style: HeadingStyles.headingMedium.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
          SizedBox(height: SmallSpacing.spacing16),
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
