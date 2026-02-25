import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/icon_sizing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:flutter/material.dart';

class HandbookTabBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;
  const HandbookTabBar({
    required this.selectedIndex,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  static const List<String> _iconPaths = [
    'assets/images/handbook/tab_bar_icons/1.png',
    'assets/images/handbook/tab_bar_icons/2.png',
    'assets/images/handbook/tab_bar_icons/3.png',
    'assets/images/handbook/tab_bar_icons/4.png',
    'assets/images/handbook/tab_bar_icons/5.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      child: SafeArea(
        top: false,
        child: Container(
          height: IconSizingConfig.iconXLarge + SmallSpacing.spacing16 * 2,
          decoration: BoxDecoration(
            color: AppTheme.darkRed,
            border: Border.all(color: AppTheme.primary, width: 4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(_iconPaths.length, (i) {
              final bool selected = i == selectedIndex;
              return GestureDetector(
                onTap: () => onTap(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: selected ? AppTheme.darkRed : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: selected ? Colors.white : Colors.transparent,
                      width: selected ? 2 : 0,
                    ),
                  ),
                  child: Container(
                    width: IconSizingConfig.iconLarge,
                    height: IconSizingConfig.iconLarge,
                    alignment: Alignment.center,
                    child: ColorFiltered(
                      colorFilter: ColorFilter.mode(
                        selected ? Colors.white : AppTheme.primary,
                        BlendMode.srcIn,
                      ),
                      child: Image.asset(
                        _iconPaths[i],
                        width: IconSizingConfig.iconLarge,
                        height: IconSizingConfig.iconMedium,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
