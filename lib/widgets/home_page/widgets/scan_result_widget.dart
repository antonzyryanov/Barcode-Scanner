import 'package:anton_zyryanov_barcode_scanner/theme/app_theme.dart';
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
            style: const TextStyle(
              fontSize: 24,
              color: AppTheme.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          const SizedBox(
            width: 100,
            height: 100,
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
