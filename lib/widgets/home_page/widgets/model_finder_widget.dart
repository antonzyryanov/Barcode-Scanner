import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_button_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/error_presenter.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/scanner/barcode_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class ModelFinderWidget extends StatelessWidget {
  const ModelFinderWidget({super.key, required this.mainBloc});

  final MainBloc mainBloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Tap to find model',
          style: TextStyle(fontSize: 20, color: AppTheme.textPrimary),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            width: .infinity,
            child: AnimatedButtonWidget(
              onPressed: () async {
                final status = await Permission.camera.request();
                if (status.isGranted) {
                  if (context.mounted) {
                    await openBarcodeScanner(context);
                  }
                } else {
                  if (context.mounted) {
                    ErrorPresenter.showError(
                      context: context,
                      error:
                          'Camera permission denied. Please grant permission in phone settings.',
                    );
                  }
                }
              },
              child: const Text(
                'Scan',
                style: TextStyle(fontSize: 20, color: AppTheme.textOnButton),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> openBarcodeScanner(BuildContext context) async {
    final String? barcodeScanRes = await Navigator.push<String>(
      context,
      MaterialPageRoute(builder: (context) => const BarcodeScannerPage()),
    );
    if (barcodeScanRes != null && barcodeScanRes != '-1') {
      mainBloc.add(SetScanResultEvent(barcodeScanRes));
    }
  }
}
