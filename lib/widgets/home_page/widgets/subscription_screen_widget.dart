import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/events/main_events.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_button_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_fade_slide_widget.dart';
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
                    child: _buildPlanCell(
                      context: context,
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
                    child: _buildPlanCell(
                      context: context,
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
                          await widget.mainBloc.user.setSubscribed(true);
                          if (context.mounted) {
                            widget.mainBloc.add(ResetMainStateEvent());
                          }
                        },
                        child: Text(
                          localizations.purchase,
                          style: const TextStyle(color: AppTheme.textOnButton),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlanCell({
    required BuildContext context,
    required String title,
    required bool isSelected,
    required VoidCallback onTap,
    bool hasDiscount = false,
  }) {
    final localizations = AppLocalizations.of(context);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        width: double.infinity,
        padding: const EdgeInsets.all(SmallSpacing.spacing16),
        decoration: BoxDecoration(
          color: isSelected
              ? StatusColors.warning
              : Colors.black.withValues(alpha: 0.35),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? StatusColors.warning : Colors.white24,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: BodyTextStyles.bodySmall.copyWith(
                  color: isSelected
                      ? DarkThemeColors.textPrimaryDark
                      : AppTheme.textPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (hasDiscount) ...[
              SizedBox(
                width: IconSizingConfig.iconSmall,
                height: IconSizingConfig.iconSmall,
                child: Image.asset('assets/paywall/premium_icon.png'),
              ),
              SizedBox(width: MicroSpacing.spacing8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: MicroSpacing.spacing8,
                  vertical: MicroSpacing.spacing4,
                ),
                decoration: BoxDecoration(
                  color: StatusColors.error,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  localizations.discont,
                  style: BodyTextStyles.bodySmall.copyWith(
                    color: AppTheme.textPrimary,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(width: SmallSpacing.spacing12),
            ],
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
              color: isSelected
                  ? DarkThemeColors.textPrimaryDark
                  : AppTheme.textPrimary,
            ),
          ],
        ),
      ),
    );
  }
}
