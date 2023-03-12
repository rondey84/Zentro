import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zentro/theme/extensions/category_chips_style.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/extended_colors_style.dart';
import 'package:zentro/theme/extensions/floating_cart_style.dart';
import 'package:zentro/theme/extensions/gradient_border_button_style.dart';
import 'package:zentro/theme/extensions/authentication_style.dart';
import 'package:zentro/theme/extensions/menu_item_style.dart';
import 'package:zentro/theme/extensions/onboarding_style.dart';
import 'package:zentro/theme/extensions/shadows_styles.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/theme/theme_helper.dart';

class ZentroTheme {
  static const String darkId = 'ztr_dark';
  static const String lightId = 'ztr_light';
  static const String name = 'Zentro Default Theme';

  static const Color _primary = Color(0xFFA36B4C);
  static const Color _lightPrimary = Color(0xFFAC8F8A);
  static const Color _darkPrimary = Color(0xFF58251E);
  static const Color _accent = Color(0xFFFFB7B7);
  static const Color _card = Colors.white;
  static const Color _shadow = Color(0xFF8B6762);

  static const Color _text00 = Color(0xFFF4F5F9);
  static const Color _text01 = Color(0xFFFFEEC0);
  static const Color _text02 = Color(0xFFEDC98B);
  static const Color _text03 = Color(0xFFC7B196);
  static const Color _text04 = Color(0xFFAC8F8A);
  static const Color _text05 = Color(0xFFB58E71);
  static const Color _text06 = Color(0xFFA36B4C);
  static const Color _text07 = Color(0xFF63401C);
  static const Color _text08 = Color(0xFF5F311F);
  static const Color _text09 = Color(0xFF2F1F11);
  static const Color _text10 = Color(0xFF000302);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: _primary,
    primaryColorLight: _lightPrimary,
    primaryColorDark: _darkPrimary,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: _primary,
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
      shadow: _shadow,
    ),
    splashColor: Colors.transparent,
    splashFactory: InkSplash.splashFactory,
    scaffoldBackgroundColor: const Color(0xFFF4F5F9),
    appBarTheme: ThemeHelper.appBarTheme(
      bgColor: Colors.transparent,
      iconColor: _darkPrimary,
      titleColor: _darkPrimary,
      brightness: Brightness.light,
    ),
    cardColor: _card,
    extensions: <ThemeExtension<dynamic>>[
      const ExtendedColorsStyle(
        vegColor: Color(0xFF9ACD32),
        nonVegColor: Color(0xFFFF4500),
        ratingsIconColor: Color(0xFFD3A93B),
      ),
      CustomFontStyles(
        display: TextStyle(
          color: _text08,
          fontWeight: FontWeight.bold,
          fontSize: 34.r,
        ),
        header1: TextStyle(
          color: _text08,
          fontWeight: FontWeight.bold,
          fontSize: 20.r,
        ),
        header2: TextStyle(
          color: _text07,
          fontWeight: FontWeight.bold,
          fontSize: 14.r,
        ),
        cardTitle: TextStyle(
          color: _text06,
          fontWeight: FontWeight.bold,
          fontSize: 16.r,
        ),
        cardHeader: TextStyle(
          color: _text06,
          fontWeight: FontWeight.bold,
          fontSize: 14.r,
        ),
        body1: TextStyle(
          color: _text06,
          fontWeight: FontWeight.normal,
          fontSize: 16.r,
        ),
        body2: TextStyle(
          color: _text04,
          fontWeight: FontWeight.normal,
          fontSize: 14.r,
        ),
        caption: TextStyle(
          color: _text04,
          fontWeight: FontWeight.normal,
          fontSize: 12.r,
        ),
        chipTextStyle: TextStyle(
          color: _text04,
          fontWeight: FontWeight.bold,
          fontSize: 12.r,
        ),
        restHeaderHead: TextStyle(
          color: _text07,
          fontWeight: FontWeight.bold,
          fontSize: 18.r,
        ),
      ),
      ShadowStyles(
        cardShadow01: [
          BoxShadow(
            blurRadius: 4,
            color: _shadow.withOpacity(0.04),
            offset: const Offset(0, 2),
          ),
          BoxShadow(
            blurRadius: 10,
            color: _shadow.withOpacity(0.08),
            offset: const Offset(0, 4),
          ),
        ],
        cardShadow02: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: -4,
            color: _shadow.withOpacity(0.08),
            offset: const Offset(0, 10),
          ),
          BoxShadow(
            blurRadius: 16,
            color: _shadow.withOpacity(0.10),
            offset: const Offset(0, 8),
          ),
        ],
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
        inputBoxTextColor: _lightPrimary,
        inputBoxHintColor: _lightPrimary.withOpacity(0.60),
        modalBgColor: const Color(0xFFF4F5F9),
        modalTextStyle: TextStyle(
          color: _darkPrimary,
          fontSize: 16.r,
        ),
        modalSearchTextStyle: TextStyle(
          color: _darkPrimary,
          fontWeight: FontWeight.bold,
          fontSize: 16.r,
        ),
      ),
      ShimmerStyle(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
      ),
      CategoryChipsStyle(
        selectedBgColor: _primary,
        selectedTextColor: _text00,
        unSelectedBgColor: _primary.withOpacity(0.12),
        unSelectedTextColor: _text04,
      ),
      MenuItemStyle(
        cardBR: 24,
        imageHeight: 116,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        contentSpacing: 10,
        nameTS: TextStyle(
          fontWeight: FontWeight.bold,
          color: _text09,
          fontSize: 16.r,
          overflow: TextOverflow.ellipsis,
        ),
        priceTS: TextStyle(
          fontWeight: FontWeight.bold,
          color: _text07,
          fontSize: 16.r,
        ),
        priceSymbol: '₹',
        ratingsTS: TextStyle(
          fontWeight: FontWeight.w400,
          color: _text04,
          fontSize: 14.r,
        ),
        ratingsColor: _text04,
        descriptionTS: TextStyle(
          fontWeight: FontWeight.w400,
          color: _text03,
          fontSize: 12.r,
          overflow: TextOverflow.ellipsis,
        ),
        buttonColor: _text07,
        iconSize: 14,
      ),
      const FloatingCartStyle(
        cartColor: Color(0xFF41281C),
        restaurantNameTS: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: _text02,
        ),
        text00: _text00,
        text01: _text01,
        text02: _text02,
        text04: _text04,
        text05: _text05,
        miniBoxColor: Color(0xFF724B39),
      )
    ],
  );
}
