import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_fade_slide_widget.dart';
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
      if (state.shopItem != null) {
        return AnimatedFadeSlideWidget(
          child: ShopItemWidget(mainBloc: mainBloc, state: state),
        );
      }
      return AnimatedFadeSlideWidget(
        child: Center(child: ModelFinderWidget(mainBloc: mainBloc)),
      );
    } else {
      return AnimatedFadeSlideWidget(
        child: Center(
          child: Text(
            AppLocalizations.of(context).tapToFindModel,
            style: TextStyle(color: AppTheme.textPrimary),
          ),
        ),
      );
    }
  }
}
