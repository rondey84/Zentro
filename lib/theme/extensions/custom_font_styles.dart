import 'package:flutter/material.dart';

@immutable
class CustomFontStyles extends ThemeExtension<CustomFontStyles> {
  const CustomFontStyles({
    required this.display,
    required this.header1,
    required this.header2,
    required this.cardTitle,
    required this.cardHeader,
    required this.body1,
    required this.body2,
    required this.button,
    required this.caption,
    required this.chipTextStyle,
    required this.restHeaderHead,
  });

  final TextStyle display;
  final TextStyle header1;
  final TextStyle header2;
  final TextStyle cardTitle;
  final TextStyle cardHeader;
  final TextStyle body1;
  final TextStyle body2;
  final TextStyle button;
  final TextStyle caption;
  final TextStyle chipTextStyle;
  final TextStyle restHeaderHead;

  @override
  CustomFontStyles copyWith({
    TextStyle? display,
    TextStyle? header1,
    TextStyle? header2,
    TextStyle? cardTitle,
    TextStyle? cardHeader,
    TextStyle? body1,
    TextStyle? body2,
    TextStyle? button,
    TextStyle? caption,
    TextStyle? chipTextStyle,
    TextStyle? restHeaderHead,
  }) =>
      CustomFontStyles(
        display: display ?? this.display,
        header1: header1 ?? this.header1,
        header2: header2 ?? this.header2,
        cardTitle: cardTitle ?? this.cardTitle,
        cardHeader: cardHeader ?? this.cardHeader,
        body1: body1 ?? this.body1,
        body2: body2 ?? this.body2,
        button: button ?? this.button,
        caption: caption ?? this.caption,
        chipTextStyle: chipTextStyle ?? this.chipTextStyle,
        restHeaderHead: restHeaderHead ?? this.restHeaderHead,
      );

  @override
  CustomFontStyles lerp(ThemeExtension<CustomFontStyles>? other, double t) {
    if (other is! CustomFontStyles) {
      return this;
    }

    return CustomFontStyles(
      display: display,
      header1: header1,
      header2: header2,
      cardTitle: cardTitle,
      cardHeader: cardHeader,
      body1: body1,
      body2: body2,
      button: button,
      caption: caption,
      chipTextStyle: chipTextStyle,
      restHeaderHead: restHeaderHead,
    );
  }
}
