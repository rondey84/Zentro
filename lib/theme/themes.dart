import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/gradient_border_button_style.dart';
import 'package:zentro/theme/extensions/authentication_style.dart';
import 'package:zentro/theme/extensions/onboarding_style.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/theme/theme_helper.dart';

class ZentroTheme {
  static const String darkId = 'ztr_dark';
  static const String lightId = 'ztr_light';
  static const String name = 'Zentro Default Theme';

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFFA36B4C),
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
    appBarTheme: ThemeHelper.appBarTheme(
      bgColor: Colors.transparent,
      iconColor: const Color(0xFF58251E),
      titleColor: const Color(0xFF58251E),
      brightness: Brightness.light,
    ),
    extensions: <ThemeExtension<dynamic>>[
      CustomFontStyles(
        display: TextStyle(
          color: const Color(0xFF58251E),
          fontWeight: FontWeight.bold,
          fontSize: 34.r,
        ),
        header1: TextStyle(
          color: const Color(0xFF58251E),
          fontWeight: FontWeight.bold,
          fontSize: 20.r,
        ),
        header2: TextStyle(
          color: const Color(0xFF58251E),
          fontWeight: FontWeight.bold,
          fontSize: 14.r,
        ),
        cardTitle: TextStyle(
          color: const Color(0xFFA36B4C),
          fontWeight: FontWeight.bold,
          fontSize: 16.r,
        ),
        cardHeader: TextStyle(
          color: const Color(0xFFA36B4C),
          fontWeight: FontWeight.bold,
          fontSize: 14.r,
        ),
        body1: TextStyle(
          color: const Color(0xFFA36B4C),
          fontWeight: FontWeight.normal,
          fontSize: 16.r,
        ),
        body2: TextStyle(
          color: const Color(0xFFAC8F8A),
          fontWeight: FontWeight.normal,
          fontSize: 14.r,
        ),
        caption: TextStyle(
          color: const Color(0xFFAC8F8A),
          fontWeight: FontWeight.normal,
          fontSize: 12.r,
        ),
      ),
      OnboardingStyle(
        buttonColor: const Color(0xFF8B6762),
        buttonBGColor: Colors.white,
        buttonShadowColor: const Color(0xFF8B6762).withOpacity(0.25),
      ),
      GradientBorderButtonStyle(
        buttonLineColor: const Color(0xFFFAE8B6),
        buttonTextColor: const Color(0xFFF4F5F9),
        buttonGradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF603F31), Color(0xFF8F6052), Color(0xFFA66D4B)],
          stops: [0.0, 0.4, 1.0],
        ),
        buttonShadowColor: const Color(0xFF8B6762).withOpacity(0.25),
      ),
      AuthenticationStyle(
        inputBoxColor: Colors.white,
        underLineColor: const Color(0xFF8B6762),
        inputBoxShadowColor: const Color(0xFF8B6762).withOpacity(0.12),
        inputBoxTextColor: const Color(0xFFAC8F8A),
        inputBoxHintColor: const Color(0xFFAC8F8A).withOpacity(0.60),
        modalBgColor: const Color(0xFFF4F5F9),
        modalTextStyle: TextStyle(
          color: const Color(0xFF58251E),
          fontSize: 16.r,
        ),
        modalSearchTextStyle: TextStyle(
          color: const Color(0xFF58251E),
          fontWeight: FontWeight.bold,
          fontSize: 16.r,
        ),
      ),
      ShimmerStyle(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
      ),
    ],
  );
}
