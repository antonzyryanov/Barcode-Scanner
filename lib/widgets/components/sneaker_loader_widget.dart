import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:flutter/material.dart';

class SneakerLoaderWidget extends StatelessWidget {
  const SneakerLoaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.loaderBackground,
      child: Center(
        child: Image.asset(
          'assets/sneaker_loader.gif',
          width: 200,
          height: 200,
        ),
      ),
    );
  }
}
