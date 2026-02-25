import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/responsive_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/ui/components/animated_button_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/ui/components/error_presenter.dart';
import 'package:anton_zyryanov_barcode_scanner/ui/screens/home_page/widgets/handbook_button_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/ui/screens/home_page/widgets/premium_button_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/ui/scanner/barcode_scanner_page.dart';
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
                  top: SmallSpacing.spacing16,
                  left: SmallSpacing.spacing16,
                  child: SizedBox(
                    height: IconSizingConfig.iconMedium,
                    child: HandbookButtonWidget(mainBloc: mainBloc),
                  ),
                ),
              if (showPremiumButton)
                Positioned(
                  top: SmallSpacing.spacing16,
                  right: SmallSpacing.spacing16,
                  child: SizedBox(
                    height: IconSizingConfig.iconMedium,
                    child: PremiumButtonWidget(mainBloc: mainBloc),
                  ),
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

  Widget _buildMainContent(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/images/home_page/central_logo.svg',
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
                mainBloc.logger.log(
                  'Scan button pressed',
                  tag: 'ModelFinderWidget',
                );
                final status = await Permission.camera.request();
                if (status.isGranted) {
                  if (context.mounted) {
                    mainBloc.logger.log(
                      'Camera permission granted',
                      tag: 'ModelFinderWidget',
                    );
                    await openBarcodeScanner(context);
                  }
                } else {
                  if (context.mounted) {
                    mainBloc.logger.error(
                      'Camera permission denied',
                      tag: 'ModelFinderWidget',
                    );
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
