import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/restaurant.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/shadows_styles.dart';
import 'package:zentro/widgets/cart/floating_cart_controller.dart';
import 'package:zentro/widgets/restaurant_header/restaurant_header_controller.dart';

class OrdersController extends GetxController {
  late String restaurantId;
  late Restaurant? restaurant;

  final floatingCartController = Get.find<FloatingCartController>();

  final fontStyles = Get.theme.extension<CustomFontStyles>();
  final shadowStyles = Get.theme.extension<ShadowStyles>();

  FloatingActionButtonLocation get cartLocation {
    return floatingCartController.widgetLocation;
  }

  // ERROR
  final _hasError = false.obs;
  bool get hasError => _hasError.value;
  set hasError(bool val) => _hasError.value = val;

  @override
  void onInit() async {
    restaurantId = Get.parameters['restaurantId']!;

    await loadData();

    super.onInit();
  }

  Future<void> loadData() async {
    await _loadRestaurantData();
  }

  Future<void> _loadRestaurantData() async {
    // Fetch from local storage
    restaurant = await Get.find<RestaurantHeaderController>()
        .loadRestaurantData(restaurantId);

    if (restaurant == null) {
      hasError = true;
    } else {
      hasError = false;
    }
  }
}
