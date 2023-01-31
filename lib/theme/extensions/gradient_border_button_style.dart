import 'package:flutter/material.dart';

@immutable
class GradientBorderButtonStyle
    extends ThemeExtension<GradientBorderButtonStyle> {
  const GradientBorderButtonStyle({
    required this.buttonLineColor,
    required this.buttonTextColor,
    required this.buttonGradient,
    required this.buttonShadowColor,
  });

  final Color buttonLineColor;
  final Color buttonTextColor;
  final LinearGradient buttonGradient;
  final Color buttonShadowColor;

  @override
  GradientBorderButtonStyle copyWith({
    Color? buttonLineColor,
    Color? buttonTextColor,
    LinearGradient? buttonGradient,
    Color? buttonShadowColor,
  }) =>
      GradientBorderButtonStyle(
        buttonLineColor: buttonLineColor ?? this.buttonLineColor,
        buttonTextColor: buttonTextColor ?? this.buttonTextColor,
        buttonGradient: buttonGradient ?? this.buttonGradient,
        buttonShadowColor: buttonShadowColor ?? this.buttonShadowColor,
      );

  @override
  GradientBorderButtonStyle lerp(
      ThemeExtension<GradientBorderButtonStyle>? other, double t) {
    if (other is! GradientBorderButtonStyle) {
      return this;
    }

    return GradientBorderButtonStyle(
      buttonLineColor: Color.lerp(buttonLineColor, other.buttonLineColor, t)!,
      buttonTextColor: Color.lerp(buttonTextColor, other.buttonTextColor, t)!,
      buttonGradient: buttonGradient,
      buttonShadowColor:
          Color.lerp(buttonShadowColor, other.buttonShadowColor, t)!,
    );
  }
}
