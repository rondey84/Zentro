import 'package:flutter/material.dart';

extension ColorExtension on Color {
  String toHexCode({bool addHash = true}) {
    String stringColor = value.toRadixString(16).padLeft(6, '0');
    return '${addHash ? '#' : ''}$stringColor';
  }

  String toRGBACode() {
    return 'rgba($red,$green,$blue,$opacity)';
  }
}
