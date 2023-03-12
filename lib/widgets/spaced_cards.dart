import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpacedCards extends StatelessWidget {
  const SpacedCards({
    super.key,
    this.padding,
    this.borderRadius,
    this.isSelected = false,
    this.selectedColor,
    this.onTap,
    required this.child,
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final double? borderRadius;
  final bool isSelected;
  final Color? selectedColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ??
            const EdgeInsets.symmetric(
              vertical: 12,
              horizontal: 12,
            ),
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor ?? Get.theme.cardColor
              : Get.theme.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4)),
        ),
        child: child,
      ),
    );
  }
}
