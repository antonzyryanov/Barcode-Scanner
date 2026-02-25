import 'package:anton_zyryanov_barcode_scanner/ui/components/info_alert_widget.dart';
import 'package:flutter/material.dart';

class InfoPresenter {
  static void showInfo({
    required BuildContext context,
    required String message,
    required String iconPath,
  }) {
    showDialog(
      context: context,
      barrierColor: Colors.black54,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24),
        child: InfoAlertWidget(
          message: message,
          iconPath: iconPath,
          onClose: () => Navigator.of(context).pop(),
        ),
      ),
    );
  }
}
