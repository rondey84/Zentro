import 'package:flutter/material.dart';

@immutable
class ShadowStyles extends ThemeExtension<ShadowStyles> {
  const ShadowStyles({
    required this.cardShadow01,
    required this.cardShadow02,
  });

  final List<BoxShadow> cardShadow01;
  final List<BoxShadow> cardShadow02;

  @override
  ShadowStyles copyWith({
    List<BoxShadow>? cardShadow01,
    List<BoxShadow>? cardShadow02,
  }) =>
      ShadowStyles(
        cardShadow01: cardShadow01 ?? this.cardShadow01,
        cardShadow02: cardShadow02 ?? this.cardShadow02,
      );

  @override
  ShadowStyles lerp(ThemeExtension<ShadowStyles>? other, double t) {
    if (other is! ShadowStyles) {
      return this;
    }

    return ShadowStyles(
      cardShadow01: cardShadow01,
      cardShadow02: cardShadow02,
    );
  }
}
