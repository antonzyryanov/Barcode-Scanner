import 'package:anton_zyryanov_barcode_scanner/widgets/components/error_alert_widget.dart';
import 'package:flutter/material.dart';

class ErrorPresenter {
  static void showError({
    required BuildContext context,
    required String error,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: ErrorAlertWidget(
          error: error,
          onClose: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
