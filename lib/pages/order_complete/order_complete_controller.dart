import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zentro/data/model/restaurant.dart';
import 'package:zentro/data/model/zentro_order.dart';
import 'package:zentro/routes/app_pages.dart';
import 'package:zentro/services/firebase_service.dart';
import 'package:zentro/services/local_storage_service.dart';
import 'package:zentro/theme/extensions/custom_font_styles.dart';
import 'package:zentro/theme/extensions/shimmer_style.dart';
import 'package:zentro/util/text_helper.dart';

class OrderCompleteController extends GetxController {
  // ====== Order ======
  late ZentroOrder? order;
  final hasOrderDataLoaded = false.obs;

  // ====== Restaurant =====
  late Restaurant? restaurant;
  final hasRestaurantDataLoaded = false.obs;

  // ======= Design Parameters ======
  final fontStyles = Get.theme.extension<CustomFontStyles>();
  final shimmerStyle = Get.theme.extension<ShimmerStyle>();

  @override
  void onInit() {
    _loadData();
    super.onInit();
  }

  Future<void> _loadData() async {
    final fireStoreHelper = FirebaseService.instance.fireStoreHelper;

    order = await fireStoreHelper.userCurrentOrder;

    // Remove current order from local storage and firebase
    LocalStorageService.instance.insertUserData(
      LocalStorageService.instance.getUserData()..currentOrderId = null,
    );
    await fireStoreHelper.updateUserCurrentOrder(order!.orderId, remove: true);

    hasOrderDataLoaded.value = true;

    restaurant = await fireStoreHelper.getRestaurantData(order!.restId);

    hasRestaurantDataLoaded.value = true;
  }

  // ===== Navigator =====
  void navigateToFeedback() {
    Get.offNamed(AppRoutes.FEEDBACK, parameters: {
      'orderId': order!.orderId,
    });
  }

  // ===== MISC =====
  double textHeight(String text, TextStyle? ts) {
    return TextHelper.textSize(text, ts).height;
  }
}
