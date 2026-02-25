import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class BarcodeScannerPage extends StatelessWidget {
  const BarcodeScannerPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isScanned = false;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).pointToBarcode),
        leading: IconButton(
          onPressed: () => Navigator.pop(context, '-1'),
          icon: const Icon(Icons.close),
        ),
      ),
      body: MobileScanner(
        controller: MobileScannerController(torchEnabled: true),
        onDetect: (capture) {
          if (isScanned) return;
          isScanned = true;
          final List<Barcode> barcodes = capture.barcodes;
          if (barcodes.isNotEmpty) {
            final String code =
                barcodes.first.rawValue ??
                AppLocalizations.of(context).barcodeListEmpty;
            Navigator.pop(context, code);
          }
        },
      ),
    );
  }
}
