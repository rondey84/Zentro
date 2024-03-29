import 'package:flutter/material.dart';

@immutable
class OnboardingStyle extends ThemeExtension<OnboardingStyle> {
  const OnboardingStyle({
    required this.buttonColor,
    required this.buttonBGColor,
    required this.buttonShadowColor,
    required this.svgPrimary,
    required this.svgAccent,
  });

  final Color buttonColor;
  final Color buttonBGColor;
  final Color buttonShadowColor;
  final Color svgPrimary;
  final Color svgAccent;

  @override
  OnboardingStyle copyWith({
    Color? buttonColor,
    Color? buttonBGColor,
    Color? buttonShadowColor,
    Color? svgPrimary,
    Color? svgAccent,
  }) =>
      OnboardingStyle(
        buttonColor: buttonColor ?? this.buttonColor,
        buttonBGColor: buttonBGColor ?? this.buttonBGColor,
        buttonShadowColor: buttonShadowColor ?? this.buttonShadowColor,
        svgPrimary: svgPrimary ?? this.svgPrimary,
        svgAccent: svgAccent ?? this.svgAccent,
      );

  @override
  OnboardingStyle lerp(ThemeExtension<OnboardingStyle>? other, double t) {
    if (other is! OnboardingStyle) {
      return this;
    }

    return OnboardingStyle(
      buttonColor: Color.lerp(buttonColor, other.buttonColor, t)!,
      buttonBGColor: Color.lerp(buttonBGColor, other.buttonBGColor, t)!,
      buttonShadowColor:
          Color.lerp(buttonShadowColor, other.buttonShadowColor, t)!,
      svgPrimary: Color.lerp(svgPrimary, other.svgPrimary, t)!,
      svgAccent: Color.lerp(svgAccent, other.svgAccent, t)!,
    );
  }
}
