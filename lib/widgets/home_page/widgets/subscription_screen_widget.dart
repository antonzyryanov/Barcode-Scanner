import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_button_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_fade_slide_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/info_alert_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/subscription_plan_cell_widget.dart';
import 'package:flutter/material.dart';

enum SubscriptionPlan { monthly, yearly }

class SubscriptionScreenWidget extends StatefulWidget {
  const SubscriptionScreenWidget({super.key, required this.mainBloc});

  final MainBloc mainBloc;

  @override
  State<SubscriptionScreenWidget> createState() =>
      _SubscriptionScreenWidgetState();
}

class _SubscriptionScreenWidgetState extends State<SubscriptionScreenWidget> {
  SubscriptionPlan selectedPlan = SubscriptionPlan.monthly;
  bool _isBlockingOverlayShown = false;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return SizedBox.expand(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/paywall/paywall_background.jpg',
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withValues(alpha: 0.45)),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: SmallSpacing.spacing16,
                vertical: SmallSpacing.spacing12,
              ),
              child: AbsorbPointer(
                absorbing: _isBlockingOverlayShown,
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          widget.mainBloc.add(ResetMainStateEvent());
                        },
                        child: Container(
                          width: IconSizingConfig.iconSmall,
                          height: IconSizingConfig.iconSmall,
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.close,
                            color: AppTheme.textPrimary,
                            size: IconSizingConfig.iconSmall,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    AnimatedFadeSlideWidget(
                      child: Text(
                        localizations.subscriptionTitle,
                        textAlign: TextAlign.center,
                        style: HeadingStyles.headingSmall.copyWith(
                          color: AppTheme.textPrimary,
                        ),
                      ),
                    ),
                    SizedBox(height: MediumSpacing.spacing24),
                    AnimatedFadeSlideWidget(
                      delay: const Duration(milliseconds: 100),
                      child: SubscriptionPlanCellWidget(
                        title: localizations.monthlySubscription,
                        isSelected: selectedPlan == SubscriptionPlan.monthly,
                        onTap: () {
                          setState(() {
                            selectedPlan = SubscriptionPlan.monthly;
                          });
                        },
                      ),
                    ),
                    SizedBox(height: SmallSpacing.spacing12),
                    AnimatedFadeSlideWidget(
                      delay: const Duration(milliseconds: 200),
                      child: SubscriptionPlanCellWidget(
                        title: localizations.yearlySubscription,
                        isSelected: selectedPlan == SubscriptionPlan.yearly,
                        hasDiscount: true,
                        onTap: () {
                          setState(() {
                            selectedPlan = SubscriptionPlan.yearly;
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                    AnimatedFadeSlideWidget(
                      delay: const Duration(milliseconds: 300),
                      child: SizedBox(
                        width: double.infinity,
                        child: AnimatedButtonWidget(
                          onPressed: () async {
                            if (_isBlockingOverlayShown) {
                              return;
                            }

                            setState(() {
                              _isBlockingOverlayShown = true;
                            });
                          },
                          child: Text(
                            localizations.purchase,
                            style: const TextStyle(
                              color: AppTheme.textOnButton,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (_isBlockingOverlayShown)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.6),
                alignment: Alignment.center,
                child: AnimatedFadeSlideWidget(
                  child: SizedBox(
                    width: 340,
                    child: InfoAlertWidget(
                      iconPath: 'assets/paywall/subscription_bought_icon.png',
                      message: localizations.subscriptionActivatedMessage,
                      onClose: () async {
                        await widget.mainBloc.user.setSubscribed(true);

                        if (!context.mounted) {
                          return;
                        }

                        setState(() {
                          _isBlockingOverlayShown = false;
                        });

                        widget.mainBloc.add(ResetMainStateEvent());
                      },
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
