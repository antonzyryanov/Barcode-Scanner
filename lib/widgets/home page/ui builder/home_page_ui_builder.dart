import 'package:anton_zyryanov_barcode_scanner/bloc/main%20bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main%20bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home%20page/widgets/model_finder_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home%20page/widgets/scan_result_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home%20page/widgets/shop_item_widget.dart';
import 'package:flutter/material.dart';

class HomePageUiBuilder {
  static Widget buildContent(
    BuildContext context,
    MainState state,
    MainBloc mainBloc,
  ) {
    if (state is MainInitial) {
      return Center(child: ModelFinderWidget(mainBloc: mainBloc));
    } else if (state is MainScanResult) {
      return ScanResultWidget(result: state.result);
    } else if (state is MainDataLoaded) {
      if (state.error != null) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 64, color: Colors.white),
              const SizedBox(height: 16),
              const Text(
                'Error loading item',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                state.error ?? 'Unknown error',
                style: const TextStyle(fontSize: 14, color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Center(child: ModelFinderWidget(mainBloc: mainBloc)),
            ],
          ),
        );
      } else if (state.shopItem != null) {
        return ShopItemWidget(mainBloc: mainBloc, state: state);
      }
      return Center(child: ModelFinderWidget(mainBloc: mainBloc));
    } else {
      return const Center(
        child: Text(
          'Tap to find model',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      );
    }
  }
}
