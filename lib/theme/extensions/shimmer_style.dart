import 'package:flutter/material.dart';

@immutable
class ShimmerStyle extends ThemeExtension<ShimmerStyle> {
  const ShimmerStyle({
    required this.baseColor,
    required this.highlightColor,
  });

  final Color baseColor;
  final Color highlightColor;

  @override
  ShimmerStyle copyWith({
    Color? baseColor,
    Color? highlightColor,
  }) =>
      ShimmerStyle(
        baseColor: baseColor ?? this.baseColor,
        highlightColor: highlightColor ?? this.highlightColor,
      );

  @override
  ShimmerStyle lerp(ThemeExtension<ShimmerStyle>? other, double t) {
    if (other is! ShimmerStyle) {
      return this;
    }

    return ShimmerStyle(
      baseColor: Color.lerp(baseColor, other.baseColor, t)!,
      highlightColor: Color.lerp(highlightColor, other.highlightColor, t)!,
    );
  }
}
