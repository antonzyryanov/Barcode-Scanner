import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/responsive_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/components/animated_fade_slide_widget.dart';
import 'package:anton_zyryanov_barcode_scanner/widgets/home_page/widgets/model_finder_widget.dart';
import 'package:flutter/material.dart';

class ShopItemWidget extends StatelessWidget {
  const ShopItemWidget({
    super.key,
    required this.mainBloc,
    required this.state,
  });

  final MainBloc mainBloc;
  final MainDataLoaded state;

  @override
  Widget build(BuildContext context) {
    final sizesCount = state.shopItem?.sizesInStock.length ?? 0;
    final imageHeight = ResponsiveConfig.getImageHeight(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedFadeSlideWidget(
          delay: const Duration(milliseconds: 100),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              state.shopItem?.imageUrl ?? '',
              width: double.infinity,
              fit: BoxFit.fill,
              height: imageHeight,
              alignment: Alignment.center,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                }
                return Container(
                  height: imageHeight,
                  color: UtilityColors.transparent,
                  child: const Center(
                    child: SizedBox(
                      width: 150,
                      height: 150,
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppTheme.textPrimary,
                        ),
                      ),
                    ),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) => Container(
                height: imageHeight,
                color: UtilityColors.errorPlaceholder,
                child: const Icon(Icons.broken_image, size: 50),
              ),
            ),
          ),
        ),
        SizedBox(height: SmallSpacing.spacing16),
        AnimatedFadeSlideWidget(
          delay: const Duration(milliseconds: 200),
          child: Text(
            state.shopItem?.name ?? '',
            style: HeadingStyles.headingLarge.copyWith(
              color: AppTheme.textPrimary,
            ),
          ),
        ),
        SizedBox(height: SmallSpacing.spacing16),
        AnimatedFadeSlideWidget(
          delay: const Duration(milliseconds: 300),
          child: const Text(
            'Sizes in stock:',
            style: TextStyle(color: AppTheme.textPrimary),
          ),
        ),
        SizedBox(height: MicroSpacing.spacing8),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sizesCount,
          itemBuilder: (context, index) {
            String size =
                state.shopItem?.sizesInStock.keys.elementAt(index) ?? '';
            int stock = state.shopItem?.sizesInStock[size] ?? 0;

            return AnimatedFadeSlideWidget(
              delay: Duration(milliseconds: 400 + (index * 80)),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  'Size $size',
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                trailing: Text(
                  'In stock: $stock',
                  style: const TextStyle(
                    color: AppTheme.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          },
        ),
        SizedBox(height: MediumSpacing.spacing20),
        AnimatedFadeSlideWidget(
          delay: Duration(milliseconds: 400 + (sizesCount * 80) + 100),
          child: Center(child: ModelFinderWidget(mainBloc: mainBloc)),
        ),
        SizedBox(height: MediumSpacing.spacing20),
      ],
    );
  }
}
