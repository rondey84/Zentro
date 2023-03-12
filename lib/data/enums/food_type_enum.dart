import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/theme/extensions/extended_colors_style.dart';

enum FoodType { veg, nonVeg, unknown }

extension FoodTypeIconExtension on FoodType {
  Widget icon({double iconSize = 16, Color? color}) {
    var extendedColors = Get.theme.extension<ExtendedColorsStyle>();

    IconData? iconData;
    double? typeIconSize;
    Color? iconColor;

    switch (this) {
      case FoodType.veg:
        iconColor = color ?? extendedColors?.vegColor;
        iconData = Icons.circle;
        typeIconSize = iconSize / 2.6;
        break;
      case FoodType.nonVeg:
        iconColor = color ?? extendedColors?.nonVegColor;
        iconData = Icons.arrow_drop_up_rounded;
        typeIconSize = iconSize;
        break;
      default:
        iconColor = color ?? Get.theme.primaryColor;
        iconData = Icons.error_outline_rounded;
    }

    return Stack(
      alignment: Alignment.center,
      children: this == FoodType.unknown
          ? [Icon(iconData, color: iconColor, size: iconSize)]
          : [
              Icon(Icons.crop_square_rounded, color: iconColor, size: iconSize),
              Icon(iconData, color: iconColor, size: typeIconSize),
            ],
    );
  }
}
