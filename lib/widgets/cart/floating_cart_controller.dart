import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/enums/floating_cart_type.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/user_cart_service.dart';
import 'package:zentro/theme/extensions/floating_cart_style.dart';

class FloatingCartController extends GetxController {
  UserCartService userCartService = Get.find();
  final widgetLocation = FloatingActionButtonLocation.centerFloat;

  // Design Params
  final cartStyle = Get.theme.extension<FloatingCartStyle>();

  // State Manager
  final _showCart = false.obs;
  bool get showCart => _showCart.value;
  set showCart(bool val) => _showCart.value = val;

  // Value State Mangers
  final _itemQuantity = 0.obs;
  int get itemQuantity => _itemQuantity.value;
  set itemQuantity(int val) => _itemQuantity.value = val;

  final _priceWithoutTax = 0.0.obs;
  double get priceWithoutTax => _priceWithoutTax.value;
  set priceWithoutTax(double val) => _priceWithoutTax.value = val;

  // Restaurant Detail Getters
  String? get restaurantImageUrl {
    return userCartService.restLocalStorageData?.imageUrl;
  }

  String? get restaurantImagePath {
    return userCartService.restLocalStorageData?.cachedImagePath;
  }

  String? get restaurantName {
    return userCartService.restLocalStorageData?.name;
  }

  @override
  void onInit() {
    super.onInit();
    showCart = !userCartService.isCartEmpty;
    itemQuantity = userCartService.userData.cart?.totalQuantity ?? 0;
    priceWithoutTax = userCartService.userData.cart?.priceWithoutTax ?? 0;
  }

  void onTapHandler(FloatingCartType cartType) {
    var restaurantId = userCartService.userCart?.restId;
    if (cartType == FloatingCartType.home) {
      Get.toNamed(
        AppRoutes.ORDERS,
        parameters: {'restaurantId': restaurantId ?? ''},
      );
      return;
    }
    if (cartType == FloatingCartType.restaurant) {
      Get.toNamed(
        AppRoutes.ORDERS,
        parameters: {'restaurantId': restaurantId ?? ''},
      );
      return;
    }
  }

  void restaurantNavigator() {
    var restaurantId = userCartService.userCart?.restId;
    Get.toNamed(
      AppRoutes.RESTAURANT,
      parameters: {'restaurantId': restaurantId ?? ''},
    );
  }
}
