import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:anton_zyryanov_barcode_scanner/localizations/app_localizations.dart';
import 'package:flutter/material.dart';

class SubscriptionPlanCellWidget extends StatelessWidget {
  const SubscriptionPlanCellWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.hasDiscount = false,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool hasDiscount;

  @override
  Widget build(BuildContext context) {
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
                child: Image.asset('assets/images/icons/premium_icon.png'),
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
