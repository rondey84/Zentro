import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ThemeHelper {
  static AppBarTheme appBarTheme({
    required Color bgColor,
    required Color iconColor,
    required Color titleColor,
    Color? actionIconColor,
    required Brightness brightness,
  }) {
    return AppBarTheme(
      backgroundColor: bgColor,
      elevation: 0,
      toolbarHeight: kToolbarHeight,
      iconTheme: IconThemeData(color: iconColor),
      actionsIconTheme: IconThemeData(color: actionIconColor ?? iconColor),
      titleTextStyle: Typography.englishLike2021.titleLarge!.copyWith(
        color: titleColor,
      ),
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: brightness,
        statusBarIconBrightness:
            brightness == Brightness.light ? Brightness.dark : Brightness.light,
      ),
    );
  }
}
