import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/main_bloc.dart';
import 'package:anton_zyryanov_barcode_scanner/bloc/main_bloc/state/main_state.dart';
import 'package:anton_zyryanov_barcode_scanner/theme/app_theme.dart';
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Image.network(
            state.shopItem?.imageUrl ?? '',
            fit: BoxFit.cover,
            alignment: Alignment.center,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Container(
                height: 200,
                color: AppTheme.transparent,
                child: const Center(
                  child: SizedBox(
                    width: 150,
                    height: 150,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppTheme.progressIndicator,
                      ),
                    ),
                  ),
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) => Container(
              height: 200,
              color: AppTheme.errorPlaceholder,
              child: const Icon(Icons.broken_image, size: 50),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          state.shopItem?.name ?? '',
          style: const TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Sizes in stock:',
          style: TextStyle(
            color: AppTheme.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: state.shopItem?.sizesInStock.length ?? 0,
          itemBuilder: (context, index) {
            String size =
                state.shopItem?.sizesInStock.keys.elementAt(index) ?? '';
            int stock = state.shopItem?.sizesInStock[size] ?? 0;
            return ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(
                'Size $size',
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              trailing: Text(
                'In stock: $stock',
                style: const TextStyle(
                  color: AppTheme.textPrimary,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          },
        ),
        const SizedBox(height: 20),
        Center(child: ModelFinderWidget(mainBloc: mainBloc)),
        const SizedBox(height: 20),
      ],
    );
  }
}
