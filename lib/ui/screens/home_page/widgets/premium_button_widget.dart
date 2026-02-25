import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/events/main_events.dart';
import 'package:flutter/material.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/ui/components/error_presenter.dart';

class PremiumButtonWidget extends StatelessWidget {
  final MainBloc mainBloc;
  const PremiumButtonWidget({Key? key, required this.mainBloc})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final user = mainBloc.user;
        mainBloc.logger.log('Premium button tapped', tag: 'ModelFinderWidget');
        if (user.isSubscribed) {
          await user.setSubscribed(false);
          if (context.mounted) {
            mainBloc.logger.log(
              'Subscription deleted',
              tag: 'ModelFinderWidget',
            );
            ErrorPresenter.showError(
              context: context,
              error: AppLocalizations.of(context).subscriptionDeleted,
            );
          }
        } else {
          mainBloc.logger.log(
            'ShowPaywallEvent triggered',
            tag: 'ModelFinderWidget',
          );
          mainBloc.add(ShowPaywallEvent());
        }
      },
      child: SizedBox(
        width: IconSizingConfig.iconSmall,
        height: IconSizingConfig.iconSmall,
        child: Image.asset('assets/images/icons/premium_icon.png'),
      ),
    );
  }
}
