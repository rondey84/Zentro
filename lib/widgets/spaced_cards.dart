import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SpacedCards extends StatelessWidget {
  /// Content of the Card
  final Widget child;

  /// The callback function when the card is tapped.
  final VoidCallback? onTap;

  /// The amount of padding to apply to the card.
  ///
  /// Defaults to `EdgeInsets.all(12)`
  final EdgeInsetsGeometry? padding;

  /// The amount of border radius to apply to the card.
  final double? borderRadius;

  /// Whether the card is currently selected.
  final bool isSelected;

  /// The color to use when the card is selected.
  final Color? selectedColor;

  final double? height;
  final List<BoxShadow>? boxShadow;

  const SpacedCards({
    super.key,
    this.padding,
    this.borderRadius,
    this.height,
    this.boxShadow,
    this.isSelected = false,
    this.selectedColor,
    this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(12),
        height: height,
        decoration: BoxDecoration(
          color: isSelected
              ? selectedColor ?? Get.theme.cardColor
              : Get.theme.cardColor,
          borderRadius: BorderRadius.all(Radius.circular(borderRadius ?? 4)),
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
