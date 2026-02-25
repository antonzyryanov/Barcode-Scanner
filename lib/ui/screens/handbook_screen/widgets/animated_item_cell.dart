import 'package:flutter/material.dart';
import 'item_cell.dart';

class AnimatedItemCell extends StatelessWidget {
  final int sectionId;
  final dynamic item;
  final int index;
  const AnimatedItemCell({
    required this.sectionId,
    required this.item,
    required this.index,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 300 + index * 50),
      curve: Curves.easeOutBack,
      builder: (context, value, child) {
        final clamped = value.clamp(0.0, 1.0);
        return Transform.scale(
          scale: clamped,
          child: Opacity(
            opacity: clamped,
            child: ItemCell(sectionId: sectionId, item: item),
          ),
        );
      },
    );
  }
}
