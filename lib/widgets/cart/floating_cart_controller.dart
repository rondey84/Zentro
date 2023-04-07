import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/enums/floating_cart_type.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/user_cart_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/floating_cart_style.dart';
import 'package:zentro/util/extensions/theme_data_extension.dart';
import 'package:zentro/widgets/custom_dialogs.dart';

class FloatingCartController extends GetxController {
  final widgetLocation = FloatingActionButtonLocation.centerFloat;

  // Design Params
  final cartStyle = Get.theme.extension<FloatingCartStyle>();
  final fontStyles = Get.theme.extension<CustomFontStyles>();

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

  final _priceWithTax = 0.0.obs;
  double get priceWithTax => _priceWithTax.value;
  set priceWithTax(double val) => _priceWithTax.value = val;

  // Restaurant Detail Getters
  String? get restaurantImageUrl {
    return UserCartService.instance.restLocalStorageData?.imageUrl;
  }

  String? get restaurantImagePath {
    return UserCartService.instance.restLocalStorageData?.cachedImagePath;
  }

  String? get restaurantName {
    return UserCartService.instance.restLocalStorageData?.name;
  }

  @override
  void onInit() {
    super.onInit();
    showCart = !UserCartService.instance.isCartEmpty;
    itemQuantity = UserCartService.instance.userData.cart?.totalQuantity ?? 0;
    priceWithoutTax =
        UserCartService.instance.userData.cart?.priceWithoutTax ?? 0;
    priceWithTax = UserCartService.instance.userData.cart?.priceWithTax ?? 0;
  }

  void onTapHandler(FloatingCartType cartType) {
    var restaurantId = UserCartService.instance.userCart?.restId;
    switch (cartType) {
      case FloatingCartType.home:
      case FloatingCartType.restaurant:
        Get.toNamed(
          AppRoutes.ORDERS,
          parameters: {'restaurantId': restaurantId ?? ''},
        );
        break;
      case FloatingCartType.order:
        var currentOrderId = UserCartService.instance.userData.currentOrderId;
        if (currentOrderId != null) {
          _showActiveOrderDialog(currentOrderId);
          break;
        }
        Get.toNamed(
          AppRoutes.PAYMENT,
          parameters: {'restaurantId': restaurantId ?? ''},
        );
        break;
    }
  }

  void restaurantNavigator() {
    var restaurantId = UserCartService.instance.userCart?.restId;
    Get.toNamed(
      AppRoutes.RESTAURANT,
      parameters: {'restaurantId': restaurantId ?? ''},
    );
  }

  void resetAndHide() {
    showCart = false;
    itemQuantity = 0;
    priceWithoutTax = 0;
    priceWithTax = 0;
  }

  void _showActiveOrderDialog(String orderId) {
    CustomDialogs.animatedDialog(
      barrierDismissible: true,
      barrierLabel: 'Active Order Dialog',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'You Have an Active Order',
              style: fontStyles?.header1,
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'It looks like you already have an active order. Would you like to view your current order?',
                style: fontStyles?.caption.copyWith(
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.offNamedUntil(
                  AppRoutes.ORDER_STATUS,
                  ModalRoute.withName(AppRoutes.HOME),
                  parameters: {
                    'orderId': orderId,
                  },
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 10,
                ),
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  color: Get.theme.primaryColor,
                ),
                child: Text(
                  'View Order',
                  style: fontStyles?.button.copyWith(
                    color: Get.theme.customColor()?.text00,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
