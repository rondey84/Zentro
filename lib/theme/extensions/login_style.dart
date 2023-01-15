import 'package:flutter/material.dart';

@immutable
class LoginStyle extends ThemeExtension<LoginStyle> {
  const LoginStyle({
    required this.inputBoxColor,
    required this.underLineColor,
    required this.inputBoxShadowColor,
    required this.inputBoxTextColor,
    required this.inputBoxHintColor,
    required this.buttonLineColor,
    required this.buttonTextColor,
    required this.buttonGradient,
    required this.buttonShadowColor,
    required this.titleStyle,
    required this.captionTextStyle,
    required this.modalBgColor,
    required this.modalTextStyle,
    required this.modalSearchTextStyle,
  });

  final Color inputBoxColor;
  final Color underLineColor;
  final Color inputBoxShadowColor;
  final Color inputBoxTextColor;
  final Color inputBoxHintColor;
  final Color buttonLineColor;
  final Color buttonTextColor;
  final LinearGradient buttonGradient;
  final Color buttonShadowColor;
  final TextStyle titleStyle;
  final TextStyle captionTextStyle;
  final Color modalBgColor;
  final TextStyle modalTextStyle;
  final TextStyle modalSearchTextStyle;

  @override
  LoginStyle copyWith({
    Color? inputBoxColor,
    Color? underLineColor,
    Color? inputBoxShadowColor,
    Color? inputBoxTextColor,
    Color? inputBoxHintColor,
    Color? buttonLineColor,
    Color? buttonTextColor,
    LinearGradient? buttonGradient,
    Color? buttonShadowColor,
    TextStyle? titleStyle,
    TextStyle? captionTextStyle,
    Color? modalBgColor,
    TextStyle? modalTextStyle,
    TextStyle? modalSearchTextStyle,
  }) =>
      LoginStyle(
        inputBoxColor: inputBoxColor ?? this.inputBoxColor,
        underLineColor: underLineColor ?? this.underLineColor,
        inputBoxShadowColor: inputBoxShadowColor ?? this.inputBoxShadowColor,
        inputBoxTextColor: inputBoxTextColor ?? this.inputBoxTextColor,
        inputBoxHintColor: inputBoxHintColor ?? this.inputBoxHintColor,
        buttonLineColor: buttonLineColor ?? this.buttonLineColor,
        buttonTextColor: buttonTextColor ?? this.buttonTextColor,
        buttonGradient: buttonGradient ?? this.buttonGradient,
        buttonShadowColor: buttonShadowColor ?? this.buttonShadowColor,
        titleStyle: titleStyle ?? this.titleStyle,
        captionTextStyle: captionTextStyle ?? this.captionTextStyle,
        modalBgColor: modalBgColor ?? this.modalBgColor,
        modalTextStyle: modalTextStyle ?? this.modalTextStyle,
        modalSearchTextStyle: modalSearchTextStyle ?? this.modalSearchTextStyle,
      );

  @override
  LoginStyle lerp(ThemeExtension<LoginStyle>? other, double t) {
    if (other is! LoginStyle) {
      return this;
    }

    return LoginStyle(
      inputBoxColor: Color.lerp(inputBoxColor, other.inputBoxColor, t)!,
      underLineColor: Color.lerp(underLineColor, other.underLineColor, t)!,
      inputBoxShadowColor:
          Color.lerp(inputBoxShadowColor, other.inputBoxShadowColor, t)!,
      inputBoxTextColor:
          Color.lerp(inputBoxTextColor, other.inputBoxTextColor, t)!,
      inputBoxHintColor:
          Color.lerp(inputBoxHintColor, other.inputBoxHintColor, t)!,
      buttonLineColor: Color.lerp(buttonLineColor, other.buttonLineColor, t)!,
      buttonTextColor: Color.lerp(buttonTextColor, other.buttonTextColor, t)!,
      buttonGradient: buttonGradient,
      buttonShadowColor:
          Color.lerp(buttonShadowColor, other.buttonShadowColor, t)!,
      titleStyle: titleStyle,
      captionTextStyle: captionTextStyle,
      modalBgColor: Color.lerp(modalBgColor, other.modalBgColor, t)!,
      modalTextStyle: modalTextStyle,
      modalSearchTextStyle: modalSearchTextStyle,
    );
  }
}
