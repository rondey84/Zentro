import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class FloatingCartStyle extends ThemeExtension<FloatingCartStyle> {
  const FloatingCartStyle({
    this.cartHeight = 66.0,
    this.borderRadius = 22.0,
    required this.cartColor,
    required this.restaurantNameTS,
    required this.text00,
    required this.text01,
    required this.text02,
    required this.text04,
    required this.text05,
    required this.miniBoxColor,
  });

  final double cartHeight;
  final double borderRadius;
  final Color cartColor;
  final TextStyle restaurantNameTS;
  final Color text00;
  final Color text01;
  final Color text02;
  final Color text04;
  final Color text05;
  final Color miniBoxColor;

  @override
  FloatingCartStyle copyWith({
    double? cartHeight,
    double? borderRadius,
    Color? cartColor,
    TextStyle? restaurantNameTS,
    Color? text00,
    Color? text01,
    Color? text02,
    Color? text04,
    Color? text05,
    Color? miniBoxColor,
  }) =>
      FloatingCartStyle(
        cartHeight: cartHeight ?? this.cartHeight,
        borderRadius: borderRadius ?? this.borderRadius,
        cartColor: cartColor ?? this.cartColor,
        restaurantNameTS: restaurantNameTS ?? this.restaurantNameTS,
        text00: text00 ?? this.text00,
        text01: text01 ?? this.text01,
        text02: text02 ?? this.text02,
        text04: text04 ?? this.text04,
        text05: text05 ?? this.text05,
        miniBoxColor: miniBoxColor ?? this.miniBoxColor,
      );

  @override
  FloatingCartStyle lerp(ThemeExtension<FloatingCartStyle>? other, double t) {
    if (other is! FloatingCartStyle) {
      return this;
    }

    return FloatingCartStyle(
      cartHeight: lerpDouble(cartHeight, other.cartHeight, t)!,
      borderRadius: lerpDouble(borderRadius, other.borderRadius, t)!,
      cartColor: Color.lerp(cartColor, other.cartColor, t)!,
      restaurantNameTS:
          TextStyle.lerp(restaurantNameTS, other.restaurantNameTS, t)!,
      text00: Color.lerp(text00, other.text00, t)!,
      text01: Color.lerp(text01, other.text01, t)!,
      text02: Color.lerp(text02, other.text02, t)!,
      text04: Color.lerp(text04, other.text04, t)!,
      text05: Color.lerp(text05, other.text05, t)!,
      miniBoxColor: Color.lerp(miniBoxColor, other.miniBoxColor, t)!,
    );
  }
}
