import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:flutter/material.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';

class ItemCell extends StatelessWidget {
  final int sectionId;
  final dynamic item;
  const ItemCell({required this.sectionId, required this.item, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: SmallSpacing.spacing16,
        vertical: SmallSpacing.spacing8,
      ),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.all(MicroSpacing.spacing8),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(MediumSpacing.spacing20),
                child: Image.asset(
                  'assets/images/handbook/sections/$sectionId/${item.id}.png',
                  height: IconSizingConfig.iconXXLarge,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      height: 120,
                      child: Center(
                        child: Icon(Icons.image_not_supported, size: 48),
                      ),
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SmallSpacing.spacing16,
                vertical: SmallSpacing.spacing8,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.title,
                    style: HeadingStyles.headingSmall.copyWith(
                      color: AppTheme.primary,
                    ),
                  ),
                  SizedBox(height: MicroSpacing.spacing4),
                  Text(
                    item.description,
                    style: BodyTextStyles.bodySmall.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
