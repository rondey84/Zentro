import 'package:flutter/material.dart';

@immutable
class AuthenticationStyle extends ThemeExtension<AuthenticationStyle> {
  const AuthenticationStyle({
    required this.inputBoxColor,
    required this.underLineColor,
    required this.inputBoxShadowColor,
    required this.inputBoxTextColor,
    required this.inputBoxHintColor,
    required this.modalBgColor,
    required this.modalTextStyle,
    required this.modalSearchTextStyle,
  });

  final Color inputBoxColor;
  final Color underLineColor;
  final Color inputBoxShadowColor;
  final Color inputBoxTextColor;
  final Color inputBoxHintColor;
  final Color modalBgColor;
  final TextStyle modalTextStyle;
  final TextStyle modalSearchTextStyle;

  @override
  AuthenticationStyle copyWith({
    Color? cartColor,
    Color? underLineColor,
    Color? inputBoxShadowColor,
    Color? inputBoxTextColor,
    Color? inputBoxHintColor,
    Color? modalBgColor,
    TextStyle? modalTextStyle,
    TextStyle? modalSearchTextStyle,
  }) =>
      AuthenticationStyle(
        inputBoxColor: cartColor ?? this.inputBoxColor,
        underLineColor: underLineColor ?? this.underLineColor,
        inputBoxShadowColor: inputBoxShadowColor ?? this.inputBoxShadowColor,
        inputBoxTextColor: inputBoxTextColor ?? this.inputBoxTextColor,
        inputBoxHintColor: inputBoxHintColor ?? this.inputBoxHintColor,
        modalBgColor: modalBgColor ?? this.modalBgColor,
        modalTextStyle: modalTextStyle ?? this.modalTextStyle,
        modalSearchTextStyle: modalSearchTextStyle ?? this.modalSearchTextStyle,
      );

  @override
  AuthenticationStyle lerp(
      ThemeExtension<AuthenticationStyle>? other, double t) {
    if (other is! AuthenticationStyle) {
      return this;
    }

    return AuthenticationStyle(
      inputBoxColor: Color.lerp(inputBoxColor, other.inputBoxColor, t)!,
      underLineColor: Color.lerp(underLineColor, other.underLineColor, t)!,
      inputBoxShadowColor:
          Color.lerp(inputBoxShadowColor, other.inputBoxShadowColor, t)!,
      inputBoxTextColor:
          Color.lerp(inputBoxTextColor, other.inputBoxTextColor, t)!,
      inputBoxHintColor:
          Color.lerp(inputBoxHintColor, other.inputBoxHintColor, t)!,
      modalBgColor: Color.lerp(modalBgColor, other.modalBgColor, t)!,
      modalTextStyle: modalTextStyle,
      modalSearchTextStyle: modalSearchTextStyle,
    );
  }
}
