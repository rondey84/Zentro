import 'package:flutter/material.dart';

@immutable
class CategoryChipsStyle extends ThemeExtension<CategoryChipsStyle> {
  const CategoryChipsStyle({
    required this.selectedBgColor,
    required this.selectedTextColor,
    required this.unSelectedBgColor,
    required this.unSelectedTextColor,
  });

  final Color selectedBgColor;
  final Color selectedTextColor;
  final Color unSelectedBgColor;
  final Color unSelectedTextColor;

  @override
  CategoryChipsStyle copyWith({
    Color? selectedBgColor,
    Color? selectedTextColor,
    Color? unSelectedBgColor,
    Color? unSelectedTextColor,
  }) =>
      CategoryChipsStyle(
        selectedBgColor: selectedBgColor ?? this.selectedBgColor,
        selectedTextColor: selectedTextColor ?? this.selectedTextColor,
        unSelectedBgColor: unSelectedBgColor ?? this.unSelectedBgColor,
        unSelectedTextColor: unSelectedTextColor ?? this.unSelectedTextColor,
      );

  @override
  CategoryChipsStyle lerp(ThemeExtension<CategoryChipsStyle>? other, double t) {
    if (other is! CategoryChipsStyle) {
      return this;
    }

    return CategoryChipsStyle(
      selectedBgColor: Color.lerp(selectedBgColor, other.selectedBgColor, t)!,
      selectedTextColor:
          Color.lerp(selectedTextColor, other.selectedTextColor, t)!,
      unSelectedBgColor:
          Color.lerp(unSelectedBgColor, other.unSelectedBgColor, t)!,
      unSelectedTextColor:
          Color.lerp(unSelectedTextColor, other.unSelectedTextColor, t)!,
    );
  }
}
