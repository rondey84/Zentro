import 'package:flutter/material.dart';

@immutable
class OnboardingStyle extends ThemeExtension<OnboardingStyle> {
  const OnboardingStyle({
    required this.buttonColor,
    required this.buttonBGColor,
    required this.buttonShadowColor,
    required this.titleStyle,
    required this.descriptionStyle,
  });

  final Color buttonColor;
  final Color buttonBGColor;
  final Color buttonShadowColor;
  final TextStyle titleStyle;
  final TextStyle descriptionStyle;

  @override
  OnboardingStyle copyWith({
    Color? buttonColor,
    Color? buttonBGColor,
    Color? buttonShadowColor,
    TextStyle? titleStyle,
    TextStyle? descriptionStyle,
  }) =>
      OnboardingStyle(
        buttonColor: buttonColor ?? this.buttonColor,
        buttonBGColor: buttonBGColor ?? this.buttonBGColor,
        buttonShadowColor: buttonShadowColor ?? this.buttonShadowColor,
        titleStyle: titleStyle ?? this.titleStyle,
        descriptionStyle: descriptionStyle ?? this.descriptionStyle,
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
      titleStyle: titleStyle,
      descriptionStyle: descriptionStyle,
    );
  }
}
