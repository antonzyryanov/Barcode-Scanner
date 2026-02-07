import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/animation_config.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/widgets/model_finder_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/widgets/scan_result_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/widgets/shop_item_widget.dart';
import 'package:flutter/material.dart';

class HomePageUiBuilder {
  static Widget buildHomePageUI(
    BuildContext context,
    MainState state,
    MainBloc mainBloc,
  ) {
    if (state is MainInitial) {
      return AnimatedFadeSlideWidget(
        child: Center(child: ModelFinderWidget(mainBloc: mainBloc)),
      );
    } else if (state is MainScanResult) {
      return AnimatedFadeSlideWidget(
        child: ScanResultWidget(result: state.result),
      );
    } else if (state is MainDataLoaded) {
      if (state.error != null) {
        return AnimatedFadeSlideWidget(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedFadeSlideWidget(
                  delay: const Duration(milliseconds: 100),
                  child: const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: AppTheme.iconPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                AnimatedFadeSlideWidget(
                  delay: const Duration(milliseconds: 200),
                  child: const Text(
                    'Error loading item',
                    style: TextStyle(
                      fontSize: 20,
                      color: AppTheme.textPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                AnimatedFadeSlideWidget(
                  delay: const Duration(milliseconds: 300),
                  child: Text(
                    state.error ?? 'Unknown error',
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppTheme.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedFadeSlideWidget(
                  delay: const Duration(milliseconds: 400),
                  child: Center(child: ModelFinderWidget(mainBloc: mainBloc)),
                ),
              ],
            ),
          ),
        );
      } else if (state.shopItem != null) {
        return AnimatedFadeSlideWidget(
          child: ShopItemWidget(mainBloc: mainBloc, state: state),
        );
      }
      return AnimatedFadeSlideWidget(
        child: Center(child: ModelFinderWidget(mainBloc: mainBloc)),
      );
    } else {
      return AnimatedFadeSlideWidget(
        child: const Center(
          child: Text(
            'Tap to find model',
            style: TextStyle(fontSize: 20, color: AppTheme.textPrimary),
          ),
        ),
      );
    }
  }
}
