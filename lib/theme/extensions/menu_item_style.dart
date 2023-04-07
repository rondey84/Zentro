import 'dart:ui';

import 'package:flutter/material.dart';

@immutable
class MenuItemStyle extends ThemeExtension<MenuItemStyle> {
  const MenuItemStyle({
    required this.cardBR,
    required this.imageHeight,
    required this.contentPadding,
    required this.contentSpacing,
    required this.nameTS,
    required this.priceTS,
    required this.priceSymbol,
    required this.ratingsTS,
    required this.ratingsColor,
    required this.descriptionTS,
    required this.iconSize,
  });

  final double cardBR;
  final double imageHeight;
  final EdgeInsetsGeometry contentPadding;
  final double contentSpacing;
  final TextStyle nameTS;
  final TextStyle priceTS;
  final String priceSymbol;
  final TextStyle ratingsTS;
  final Color ratingsColor;
  final TextStyle descriptionTS;
  final double iconSize;

  @override
  MenuItemStyle copyWith({
    double? cardBR,
    double? imageHeight,
    EdgeInsetsGeometry? contentPadding,
    double? contentSpacing,
    TextStyle? nameTS,
    TextStyle? priceTS,
    String? priceSymbol,
    TextStyle? ratingsTS,
    Color? ratingsColor,
    TextStyle? descriptionTS,
    double? iconSize,
  }) =>
      MenuItemStyle(
        cardBR: cardBR ?? this.cardBR,
        imageHeight: imageHeight ?? this.imageHeight,
        contentPadding: contentPadding ?? this.contentPadding,
        contentSpacing: contentSpacing ?? this.contentSpacing,
        nameTS: nameTS ?? this.nameTS,
        priceTS: priceTS ?? this.priceTS,
        priceSymbol: priceSymbol ?? this.priceSymbol,
        ratingsTS: ratingsTS ?? this.ratingsTS,
        ratingsColor: ratingsColor ?? this.ratingsColor,
        descriptionTS: descriptionTS ?? this.descriptionTS,
        iconSize: iconSize ?? this.iconSize,
      );

  @override
  MenuItemStyle lerp(ThemeExtension<MenuItemStyle>? other, double t) {
    if (other is! MenuItemStyle) {
      return this;
    }

    return MenuItemStyle(
      cardBR: lerpDouble(cardBR, other.cardBR, t)!,
      imageHeight: lerpDouble(imageHeight, other.imageHeight, t)!,
      contentPadding: contentPadding,
      contentSpacing: lerpDouble(contentSpacing, other.contentSpacing, t)!,
      nameTS: nameTS,
      priceTS: priceTS,
      priceSymbol: priceSymbol,
      ratingsTS: ratingsTS,
      ratingsColor: Color.lerp(ratingsColor, other.ratingsColor, t)!,
      descriptionTS: descriptionTS,
      iconSize: lerpDouble(iconSize, other.iconSize, t)!,
    );
  }
}
