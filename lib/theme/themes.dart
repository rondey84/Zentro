import 'package:flutter/material.dart';

class ZentroTheme {
  static const String darkId = 'ztr_dark';
  static const String lightId = 'ztr_light';
  static const String name = 'Zentro Default Theme';

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF9c4238),
      onPrimary: Color(0xFFffffff),
      primaryContainer: Color(0xFFffdad5),
      onPrimaryContainer: Color(0xFF410001),
      secondary: Color(0xFF775652),
      onSecondary: Color(0xFFffffff),
      secondaryContainer: Color(0xFFffdad5),
      onSecondaryContainer: Color(0xFF2c1512),
      tertiary: Color(0xFF705c2e),
      onTertiary: Color(0xFFffffff),
      tertiaryContainer: Color(0xFFfcdfa6),
      onTertiaryContainer: Color(0xFF261a00),
      error: Color(0xFFba1a1a),
      onError: Color(0xFFffffff),
      errorContainer: Color(0xFFffdad6),
      onErrorContainer: Color(0xFF410002),
      background: Color(0xFFfffbff),
      onBackground: Color(0xFF201a19),
      surface: Color(0xFFfffbff),
      onSurface: Color(0xFF201a19),
      surfaceVariant: Color(0xFFf5ddda),
      onSurfaceVariant: Color(0xFF534341),
      outline: Color(0xFF857370),
      shadow: Color(0xFF8B6762),
    ),
    splashColor: Colors.transparent,
    splashFactory: InkSplash.splashFactory,
    scaffoldBackgroundColor: const Color(0xFFF4F5F9),
    textTheme: Typography.englishLike2021,
  );
}