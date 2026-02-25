import 'package:anton_zyryanov_barcode_scanner/design_configs/spacing_config.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/typography_config.dart';
import 'package:flutter/material.dart';
import 'animated_item_cell.dart';
import 'package:anton_zyryanov_barcode_scanner/design_configs/app_theme.dart';

class SectionWidget extends StatelessWidget {
  final dynamic section;
  const SectionWidget({required this.section, super.key});

  @override
  Widget build(BuildContext context) {
    if (section == null) {
      return const Center(child: Text('Section loading...'));
    }
    return Column(
      key: ValueKey(section.name),
      children: [
        SizedBox(height: MediumSpacing.spacing24),
        Text(
          section.name,
          style: HeadingStyles.headingSmall.copyWith(color: AppTheme.primary),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: section.items.length,
            itemBuilder: (context, index) {
              final item = section.items[index];
              return AnimatedItemCell(
                sectionId: section.id,
                item: item,
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}
