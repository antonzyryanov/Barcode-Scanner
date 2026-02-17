import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/responsive_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_button_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/error_presenter.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/scanner/barcode_scanner_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';

class ModelFinderWidget extends StatelessWidget {
  const ModelFinderWidget({
    super.key,
    required this.mainBloc,
    this.isCompact = false,
    this.showPremiumButton = true,
  });

  final MainBloc mainBloc;
  final bool isCompact;
  final bool showPremiumButton;

  @override
  Widget build(BuildContext context) {
    if (isCompact) {
      return _buildMainContent(context);
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final contentHeight = constraints.maxHeight.isFinite
            ? constraints.maxHeight
            : MediaQuery.of(context).size.height;

        return SizedBox(
          width: double.infinity,
          height: contentHeight,
          child: Stack(
            children: [
              if (showPremiumButton)
                Positioned(
                  top: 0,
                  right: 0,
                  child: _buildPremiumButton(context),
                ),
              Align(
                alignment: Alignment.center,
                child: _buildMainContent(context),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPremiumButton(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final user = mainBloc.user;
        if (user.isSubscribed) {
          await user.setSubscribed(false);
          if (context.mounted) {
            ErrorPresenter.showError(
              context: context,
              error: AppLocalizations.of(context).subscriptionDeleted,
            );
          }
        } else {
          mainBloc.add(ShowPaywallEvent());
        }
      },
      child: SizedBox(
        width: IconSizingConfig.iconSmall,
        height: IconSizingConfig.iconSmall,
        child: Image.asset('assets/paywall/premium_icon.png'),
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/central_logo.svg',
          width: ResponsiveConfig.getLogoSize(context),
          height: ResponsiveConfig.getLogoSize(context),
          colorFilter: const ColorFilter.mode(
            AppTheme.textPrimary,
            BlendMode.srcIn,
          ),
        ),
        SizedBox(height: SmallSpacing.spacing12),
        Text(
          AppLocalizations.of(context).tapToFindModel,
          style: HeadingStyles.headingSmall.copyWith(
            color: AppTheme.textPrimary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(SmallSpacing.spacing16),
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
                      error: AppLocalizations.of(
                        context,
                      ).cameraPermissionDenied,
                    );
                  }
                }
              },
              child: Text(
                AppLocalizations.of(context).scan,
                style: const TextStyle(color: AppTheme.textOnButton),
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
