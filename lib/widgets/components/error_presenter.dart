import 'package:anton_zyryanov_barcode_scanner/bloc/main%20bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_button.dart';
import 'package:flutter/material.dart';

class ErrorPresenter {
  static void showError({
    required BuildContext context,
    required MainDataLoaded state,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(state.error ?? 'Unknown error occurred'),
        actions: [
          AnimatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
