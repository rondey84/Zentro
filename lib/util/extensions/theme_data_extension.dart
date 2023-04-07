
import 'package:flutter/material.dart';

class CustomColorFields {
  final Color? text00;
  final Color? text01;
  final Color? text02;
  final Color? text03;
  final Color? text04;
  final Color? text05;
  final Color? text06;
  final Color? text07;
  final Color? text08;
  final Color? text09;
  final Color? text10;

  const CustomColorFields({
    this.text00,
    this.text01,
    this.text02,
    this.text03,
    this.text04,
    this.text05,
    this.text06,
    this.text07,
    this.text08,
    this.text09,
    this.text10,
  });

  factory CustomColorFields.empty() {
    return const CustomColorFields(
      text00: Colors.transparent,
      text01: Colors.transparent,
      text02: Colors.transparent,
      text03: Colors.transparent,
      text04: Colors.transparent,
      text05: Colors.transparent,
      text06: Colors.transparent,
      text07: Colors.transparent,
      text08: Colors.transparent,
      text09: Colors.transparent,
      text10: Colors.transparent,
    );
  }
}

extension ThemeDataExtensions on ThemeData {
  static final Map<InputDecorationTheme, CustomColorFields> _colors = {};

  void addColors(CustomColorFields colors) {
    _colors[inputDecorationTheme] = colors;
  }

  static CustomColorFields? empty;

  CustomColorFields? customColor() {
    var col = _colors[inputDecorationTheme];
    if (col == null) {
      empty ??= CustomColorFields.empty();
      col = empty;
    }
    return col;
  }
}
