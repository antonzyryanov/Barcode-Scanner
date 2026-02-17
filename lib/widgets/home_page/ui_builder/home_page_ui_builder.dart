import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_fade_slide_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/sneaker_loader_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/widgets/model_finder_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/widgets/onboarding_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/widgets/scan_result_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/widgets/shop_item_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/widgets/subscription_screen_widget.dart';
import 'package:flutter/material.dart';

class HomePageUiBuilder {
  static Widget buildContent(
    BuildContext context,
    MainState state,
    MainBloc mainBloc,
  ) {
    if (state is MainLoaderShown) {
      return const SneakerLoaderWidget(key: ValueKey('loader'));
    }

    if (state is OnboardingShowing || state is PaywallShowing) {
      return buildHomePageUI(context, state, mainBloc);
    }

    return LayoutBuilder(
      key: ValueKey('content_${state.runtimeType}'),
      builder: (context, constraints) {
        return SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: buildHomePageUI(context, state, mainBloc),
            ),
          ),
        );
      },
    );
  }

  static Widget buildHomePageUI(
    BuildContext context,
    MainState state,
    MainBloc mainBloc,
  ) {
    if (state is MainInitial) {
      return AnimatedFadeSlideWidget(
        child: ModelFinderWidget(mainBloc: mainBloc),
      );
    } else if (state is OnboardingShowing) {
      return OnboardingWidget(mainBloc: mainBloc);
    } else if (state is PaywallShowing) {
      return SubscriptionScreenWidget(mainBloc: mainBloc);
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
        child: ModelFinderWidget(mainBloc: mainBloc),
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
