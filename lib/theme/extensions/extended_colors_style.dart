import 'package:flutter/material.dart';

@immutable
class ExtendedColorsStyle extends ThemeExtension<ExtendedColorsStyle> {
  const ExtendedColorsStyle({
    required this.vegColor,
    required this.nonVegColor,
    required this.ratingsIconColor,
  });

  final Color vegColor;
  final Color nonVegColor;
  final Color ratingsIconColor;

  @override
  ExtendedColorsStyle copyWith({
    Color? vegColor,
    Color? nonVegColor,
    Color? ratingsIconColor,
  }) =>
      ExtendedColorsStyle(
        vegColor: vegColor ?? this.vegColor,
        nonVegColor: nonVegColor ?? this.nonVegColor,
        ratingsIconColor: ratingsIconColor ?? this.ratingsIconColor,
      );

  @override
  ExtendedColorsStyle lerp(
      ThemeExtension<ExtendedColorsStyle>? other, double t) {
    if (other is! ExtendedColorsStyle) {
      return this;
    }

    return ExtendedColorsStyle(
      vegColor: Color.lerp(vegColor, other.vegColor, t)!,
      nonVegColor: Color.lerp(nonVegColor, other.nonVegColor, t)!,
      ratingsIconColor:
          Color.lerp(ratingsIconColor, other.ratingsIconColor, t)!,
    );
  }
}
